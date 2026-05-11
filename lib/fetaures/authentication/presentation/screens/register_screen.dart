import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:flutter/services.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/getbranch_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/main_splash.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController schoolCodeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),

      /// 🔥 LISTENER
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is FetchSchoolLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          if (state is FetchSchoolSuccess) {
            Navigator.pop(context); // close loader

            // final school = state.response.schoolDetails?.first;
            final pref = SharedPreferenceHelper();
            // 👉 You can store baseUrl + dbName here if needed
            await pref.saveSchoolRegistered(true); // 🔥 THIS IS IMPORTANT

            print("Saved school registered TRUE"); // add this

            /// 🔥 GET SCHOOL DATA
            final school = state.response.schoolDetails?.first;

            if (school != null) {
              /// ✅ SAVE BASE URL
              await pref.setBaseUrl(school.baseUrl ?? '');

              /// ✅ SAVE DB NAME
              await pref.setDatabaseName(school.dbName ?? '');

              print("BaseURL saved: ${school.baseUrl}");
              print("DB Name saved: ${school.dbName}");
            }

            /// 🔥 CALL NEXT API (branch)
            context.read<LoginCubit>().getBranchDetails();
            // AppNavigator.pushSlide(context: context, page: MainSplashScreen());
          }

          if (state is FetchSchoolFailure) {
            Navigator.pop(context); // close loader

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          /// 🔄 BRANCH LOADING
          if (state is GetBranchLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }

          /// ✅ BRANCH SUCCESS
          if (state is GetBranchSuccess) {
            Navigator.pop(context); // close loader

            final pref = SharedPreferenceHelper();

            final branch = state.response.data;

            if (branch != null && branch is BranchDataModel) {
              await pref.saveBranchData(branch.toJson());

              print("Branch saved successfully: ${branch.branchName}");
            }
            AppNavigator.pushReplacementSlide(
              context: context,
              page: MainSplashScreen(),
            );
          }

          /// ❌ BRANCH FAILURE
          if (state is GetBranchFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        /// 🔥 UI
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter School Code",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),

                /// School Code Field
                TextField(
                  controller: schoolCodeController,
                  textCapitalization: TextCapitalization.characters,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                    UpperCaseTextFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: "Enter code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Connect Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF807FD8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      final code = schoolCodeController.text.trim();

                      if (code.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter school code"),
                          ),
                        );
                        return;
                      }

                      /// 🔥 CALL API
                      context.read<LoginCubit>().fetchSchools(
                        FetchSchoolRequest(slno: code),
                      );
                    },
                    child: const Text(
                      "Connect",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
