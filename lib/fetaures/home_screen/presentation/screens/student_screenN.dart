import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/screens/attendence_screen.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';
import 'package:studentmanagement/fetaures/fees/presentation/screens/fees_screen.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/screens/marklistscreenN.dart';
import 'package:studentmanagement/fetaures/materials/presentation/screens/subjectlist_screen.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/screens/timetable_screen.dart';


// --- Data ---
const _quickAccessItems = [
  {'icon': Icons.credit_card, 'label': 'Fees', 'color': Color(0xFFF5F0A8)},
  {'icon': Icons.schedule, 'label': 'Time Table', 'color': Color(0xFFD4EDA4)},
  {'icon': Icons.menu_book, 'label': 'Class Diary', 'color': Color(0xFFB8F0B8)},
  {'icon': Icons.checklist, 'label': 'Mark List', 'color': Color(0xFFB8E8F5)},
  {'icon': Icons.dashboard, 'label': 'Material', 'color': Color(0xFFCFBEF5)},
  {'icon': Icons.event_available, 'label': 'Attendance', 'color': Color(0xFFD4EDA4)},
];

final ValueNotifier<bool> showAllNotifications = ValueNotifier<bool>(false);
List<AccountDetails> accounts = [];
// --- Home Screen ---
class StudentScreenN extends StatefulWidget {
  final LoginResponseResult? loginResponse;
  const StudentScreenN({super.key , this.loginResponse});

  @override
  State<StudentScreenN> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentScreenN> {
  int _selectedIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccounts();
    context.read<AttendenceCubit>().getAttendanceReportByDate(
      AttendanceReportByDateParameter(
        admno: "PKG7",
        date: "2026-04-04",
        accYear: "2026-2027",
        branchId: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Notification'),
              const SizedBox(height: 10),
              _buildNotificationCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Quick Access'),
              const SizedBox(height: 12),
              _buildQuickAccessGrid(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

    );
  }

  // --- Profile Card ---
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF7C6FCD),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Stack(
        children: [
          // Watermark "66" text in background
          Positioned(
            right: -10,
            top: -10,
            child: Text(
              '66',
              style: TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar + Name + Phone
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.5),
                    ),
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/44.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.loginResponse!.student!.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.loginResponse!.student!.admno,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Class / Std / Roll No
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Class', widget.loginResponse!.student!.currentStudentStandardId
                        .toString()),
                    _buildStatItem('Div', widget.loginResponse!.student!.currentStudentDivisionId
                        .toString()),
                    _buildStatItem('Admission No', widget.loginResponse!.student!.admno
                        .toString()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // --- Section Title ---
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // --- Notification Card ---
  Widget _buildNotificationCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE8FB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Color(0xFF7C6FCD),
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Please Note That Today Will Be A Half-Day Of Classes.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

// --- Quick Access Grid ---
  Widget _buildQuickAccessGrid() {
    return Column(
      children: [
        /// First Row
        Row(
          children: [
            // Small Card
            Expanded(
              flex: 2,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[0]['icon'] as IconData,
                label: _quickAccessItems[0]['label'] as String,
                color: _quickAccessItems[0]['color'] as Color,
                height: 90,
              ),
            ),

            const SizedBox(width: 12),

            // Large Card
            Expanded(
              flex: 3,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[1]['icon'] as IconData,
                label: _quickAccessItems[1]['label'] as String,
                color: _quickAccessItems[1]['color'] as Color,
                height: 90,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Second Row
        Row(
          children: [
            // Large Card
            Expanded(
              flex: 3,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[2]['icon'] as IconData,
                label: _quickAccessItems[2]['label'] as String,
                color: _quickAccessItems[2]['color'] as Color,
                height: 90,
              ),
            ),

            const SizedBox(width: 12),

            // Small Card
            Expanded(
              flex: 2,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[3]['icon'] as IconData,
                label: _quickAccessItems[3]['label'] as String,
                color: _quickAccessItems[3]['color'] as Color,
                height: 90,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        /// Third Row
        Row(
          children: [
            // Large Card
            Expanded(
              flex: 2,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[4]['icon'] as IconData,
                label: _quickAccessItems[4]['label'] as String,
                color: _quickAccessItems[4]['color'] as Color,
                height: 90,
              ),
            ),

            const SizedBox(width: 12),

            // Small Card
            Expanded(
              flex: 3,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[5]['icon'] as IconData,
                label: _quickAccessItems[5]['label'] as String,
                color: _quickAccessItems[5]['color'] as Color,
                height: 90,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessTile({
    required IconData icon,
    required String label,
    required Color color,
    double height = 80,
  }) {
    return GestureDetector(
      onTap: () {
        print('label $label');
        if(label=="Fees"){
          AppNavigator.pushSlide(context: context, page: FeesScreen());
        }
        if(label=="Time Table"){
          AppNavigator.pushSlide(context: context, page: TimeTableScreen());
        }
        if(label=="Class Diary"){
          AppNavigator.pushSlide(context: context, page: AllClassDiaryScreen());
        }
        if(label=="Mark List"){
          AppNavigator.pushSlide(context: context, page: MarkListPage());
        }
        if(label=="Material"){
          AppNavigator.pushSlide(context: context, page: SubjectPage());
        }
        if(label=="Attendance"){
          AppNavigator.pushSlide(context: context, page: AttendenceScreen());
        }

      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Bottom Nav ---
  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(icon: Icons.home_outlined, index: 0),
          _navItem(icon: Icons.school_outlined, label: 'Student', index: 1),
          _navItem(icon: Icons.notifications_outlined, index: 2),
          _navItem(icon: Icons.settings_outlined, index: 3),
        ],
      ),
    );
  }

  Widget _navItem({required IconData icon, String? label, required int index}) {
    final active = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
     //  onTap: () {
     //    AppNavigator.pushSlide(context: context, page: FeesScreen());
     //  },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: label != null && active
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
            : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF6C63FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (label != null && active) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
Future<void> loadAccounts() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> data = prefs.getStringList('accounts') ?? [];

  accounts = data.map((e) => AccountDetails.fromJson(jsonDecode(e))).toList();

  print('accountsList_Admno ${accounts.first.name}');

  // setState(() {
  //   isLoading = false;
  // });
}