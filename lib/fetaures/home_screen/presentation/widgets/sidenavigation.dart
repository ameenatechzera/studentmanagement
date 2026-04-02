import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/widget/switch_account.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/screens/main_screen.dart';

class SideNavigationBar extends StatefulWidget {
  SideNavigationBar({super.key});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  List<AccountDetails> accounts = [];
  String? selectedAdmissionNo;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _headerSection(),
                  const SizedBox(height: 10),
                  _accountSwitchSectionO(context),
                  const Divider(height: 30),
                  _menuItem(Icons.home_rounded, "Home", () {}),
                  _menuItem(Icons.person_outline, "Profile", () {}),
                  _menuItem(Icons.notifications_none, "Notifications", () {}),
                  _menuItem(Icons.settings_outlined, "Settings", () {}),
                  const Spacer(),
                  const Divider(),
                  _menuItem(Icons.logout, "Logout", () {}),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔷 Welcome Header
  Widget _headerSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(
              "https://randomuser.me/api/portraits/men/32.jpg",
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                AppData.studentName!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _accountSwitchSection(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (accounts.isEmpty) {
      return const Center(child: Text('No accounts found'));
    }

    return Container(
      height: 250,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Account Switch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          /// 🔥 IMPORTANT
          Expanded(
            child: ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final acc = accounts[index];

                return Card(
                  child: ListTile(
                    title: Text(acc.admissionNo ?? ''),
                    subtitle: Text("DOB: ${acc.dob}"),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          _addAccountButton(context),
        ],
      ),
    );
  }

  Widget _accountSwitchSectionO(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Account Switch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          /// 🔥 Dynamic tiles here
          ...accounts.map((acc) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _accountTile(
                name: acc.name ?? "No Name",
                imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
                isSelected: acc.admissionNo == selectedAdmissionNo,
                onTap: () {
                  setState(() {
                    selectedAdmissionNo = acc.admissionNo;
                  });
                },
                accountData: acc,
              ),
            );
          }).toList(),

          const SizedBox(height: 12),

          _addAccountButton(context),
        ],
      ),
    );
  }

  // 🔷 Account Card
  Widget _accountTile({
    required String name,
    required String imageUrl,
    required AccountDetails accountData,
    bool isSelected = false,
    VoidCallback? onTap, // ✅ add this
  }) {
    return InkWell(
      onTap: () {
        AppData.admissionNo = accountData.admissionNo;
        AppData.studentName = accountData.name;
        AppData.studentStdId = accountData.stdId;
        AppData.studentDivId = accountData.divId;
        AppData.accYear = accountData.accYear;
        AppData.dob = accountData.dob;

        context.read<LoginCubit>().loginUser(
          LoginRequest(admno: AppData.admissionNo!, dob: AppData.dob!),
        );
      }, // ✅ handle tap
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return MainScreen(loginResponse: state.loginResponse);
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? Colors.pinkAccent : Colors.grey.shade300,
                width: isSelected ? 1.5 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 14),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔷 Add Account Button
  Widget _addAccountButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // important for full height
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return AddAccount();
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: Colors.white, size: 18),
          ),
          SizedBox(width: 12),
          Text(
            "Add Account",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // 🔷 Menu Item
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      horizontalTitleGap: 10,
    );
  }

  Future<void> loadAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data = prefs.getStringList('accounts') ?? [];

    accounts = data.map((e) => AccountDetails.fromJson(jsonDecode(e))).toList();

    print('accountsList_Admno ${accounts.first.name}');

    setState(() {
      isLoading = false;
    });
  }
}
