import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/academiccalender/presentation/screens/academiccalender_screen.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/screens/attendence_screen.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/widget/switch_bottombar.dart';
import 'package:studentmanagement/fetaures/earlygo/presentation/screens/earlygo_listingscreen.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/account_details_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/widget/switch_account.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';
import 'package:studentmanagement/fetaures/fees/presentation/screens/fees_screen.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/screens/marklistscreenN.dart';
import 'package:studentmanagement/fetaures/materials/presentation/screens/subjectlist_screen.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/screens/timetable_screen.dart';

// --- Data ---
const _quickAccessItems = [
  {'icon': Icons.credit_card, 'label': 'Fees', 'color': Color(0xFFFFF5AD)},
  {'icon': Icons.schedule, 'label': 'Time Table', 'color': Color(0xFFE8FFAD)},
  {'icon': Icons.menu_book, 'label': 'Class Diary', 'color': Color(0xFFC1FFAD)},
  {'icon': Icons.checklist, 'label': 'Mark List', 'color': Color(0xFFADDFFF)},
  {'icon': Icons.dashboard, 'label': 'Material', 'color': Color(0xFFC3ADFF)},
  {
    'icon': Icons.event_available,
    'label': 'Attendance',
    'color': Color(0xFFFFF5AD),
  },
  {
    'icon': Icons.event_available,
    'label': 'Academic Calendar',
    'color': Color(0xFFFFF5AD),
  },
  {
    'icon': Icons.logout_rounded,
    'label': 'Early Go',
    'color': const Color(0xFF7C7CF6),
  },
];


final ValueNotifier<bool> showAllNotifications = ValueNotifier<bool>(false);
List<AccountDetails> accounts = [];

// --- Home Screen ---
class StudentScreenN extends StatefulWidget {
  final LoginResponseResult? loginResponse;
  const StudentScreenN({super.key, this.loginResponse});

  @override
  State<StudentScreenN> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<StudentScreenN>
    with WidgetsBindingObserver {
  // Future<void> checkAndFetchAttendance() async {
  //   String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   final prefs = await SharedPreferences.getInstance();

  //   final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  //   final lastFetchDate = prefs.getString('attendance_fetch_date');

  //   if (lastFetchDate != today) {
  //     // Fetch fresh attendance
  //     context.read<AttendenceCubit>().getAttendanceReportByDate(
  //       AttendanceReportByDateParameter(
  //         admno: AppData.admissionNo,
  //         date: currentDate,
  //         accYear: AppData.accYear,
  //         branchId: AppData.branchId,
  //       ),
  //     );

  //     await prefs.setString('attendance_fetch_date', today);
  //   }
  // }
  Future<void> checkAndFetchAttendance() async {
    final prefs = await SharedPreferences.getInstance();

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final lastFetchDate = prefs.getString('attendance_fetch_date');

    debugPrint("TODAY: $today");
    debugPrint("LAST FETCH DATE: $lastFetchDate");

    if (lastFetchDate != today) {
      debugPrint("✅ FETCHING ATTENDANCE");

      context.read<AttendenceCubit>().getAttendanceReportByDate(
        AttendanceReportByDateParameter(
          admno: AppData.admissionNo,
          date: today,
          accYear: AppData.accYear,
          branchId: AppData.branchId,
        ),
      );

      await prefs.setString('attendance_fetch_date', today);
      debugPrint("SAVED DATE: ${prefs.getString('attendance_fetch_date')}");
    } else {
      debugPrint("❌ SKIPPING ATTENDANCE FETCH");
    }
  }

  int _selectedIndex = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAccounts();
    WidgetsBinding.instance.addObserver(this);
    checkAndFetchAttendance();
    // String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // context.read<AttendenceCubit>().getAttendanceReportByDate(
    //   AttendanceReportByDateParameter(
    //     admno: AppData.admissionNo,
    //     date: currentDate,
    //     accYear: AppData.accYear,
    //     branchId: AppData.branchId,
    //   ),
    // );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkAndFetchAttendance();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileCard(),
                const SizedBox(height: 24),
                // _buildSectionTitle('Notification'),
                // const SizedBox(height: 10),
                // _buildNotificationCard(),
                const SizedBox(height: 24),
                _buildSectionTitle('Quick Access'),
                const SizedBox(height: 12),
                _buildQuickAccessGrid(),
                const SizedBox(height: 20),


              ],
            ),
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
          // Positioned(
          //   right: -10,
          //   top: -10,
          //   child: Text(
          //     '66',
          //     style: TextStyle(
          //       fontSize: 90,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white.withOpacity(0.08),
          //     ),
          //   ),
          // ),
          Positioned(
            right: -10,
            top: 10,
            bottom: 10,
            child: Opacity(
              opacity: 0.99, // 👈 adjust visibility
              child: Image.asset(
                "assets/images/mask_bg.png",
                color: Colors.white,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar + Name + Phone
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true, // important for full height
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom, // ✅ keyboard pushes sheet up
                            ),
                            child: const SwitchAccountBottomSheet(),
                          );

                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          (AppData.profileUrl != null &&
                              AppData.profileUrl!.isNotEmpty)
                          ? NetworkImage(AppData.profileUrl!)
                          : null,
                      child:
                          (AppData.profileUrl == null ||
                              AppData.profileUrl!.isEmpty)
                          ? ClipOval(
                              child: Image.asset(
                                getGenderImage(),
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            )
                          : null,
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
                        widget.loginResponse!.student!.mobile,
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
                    _buildStatItem(
                      'Class',
                      widget.loginResponse!.student!.studentStandard.toString(),
                    ),
                    _buildStatItem(
                      'Div',
                      widget.loginResponse!.student!.studentDivision.toString(),
                    ),
                    _buildStatItem(
                      'Admission No',
                      widget.loginResponse!.student!.admno.toString(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45.0, top: 10),
                child: BlocBuilder<AttendenceCubit, AttendenceState>(
                  builder: (context, state) {
                    if (state is AttendenceLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                      );
                    } else if (state is AttendenceLoaded) {
                      final list = state.response.data ?? [];

                      if (list.isEmpty) {
                        return const Text(
                          'No Attendance Data',
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final attendance = list.first;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          attendance.status == "1"
                              ? "Present"
                              : attendance.status == 0
                              ? "Absent"
                              : "No Attendance Data",
                        ),
                      );
                    } else if (state is AttendenceError) {
                      return Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Present":
        return const Color(0xff22c55e); // green
      case "Absent":
        return const Color(0xffef4444); // red
      case "Upcoming":
        return Colors.blueGrey;
      case "Not Marked":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String getGenderImage() {
    final g = (AppData.gender ?? '').toLowerCase().trim();

    if (g == 'male') {
      return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
    } else if (g == 'female') {
      return "assets/icons/1f5debb8-6e36-4d25-bde8-526f4dd89820_removalai_preview.png";
    } else {
      return "assets/images/defaultstudent.png";
    }
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
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
                // height: 120,
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
                //height: 120,
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
                //  height: 90,
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
                //height: 90,
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
                // height: 90,
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
                // height: 90,
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
              flex: 3,
              child: _buildQuickAccessTile(
                icon: _quickAccessItems[6]['icon'] as IconData,
                label: _quickAccessItems[6]['label'] as String,
                color: _quickAccessItems[6]['color'] as Color,
                // height: 90,
              ),
            ),

            const SizedBox(width: 12),

            // Small Card
            Expanded(
              flex: 2,
              child:  _buildQuickAccessTile(
                icon: _quickAccessItems[7]['icon'] as IconData,
                label: _quickAccessItems[7]['label'] as String,
                color: _quickAccessItems[7]['color'] as Color,
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
  }) {
    return GestureDetector(
      onTap: () {
        print('label $label');
        if (label == "Fees") {
          AppNavigator.pushSlide(context: context, page: FeesScreen());
        }
        if (label == "Time Table") {
          AppNavigator.pushSlide(context: context, page: TimeTableScreen());
        }
        if (label == "Class Diary") {
          AppNavigator.pushSlide(context: context, page: AllClassDiaryScreen());
        }
        if (label == "Mark List") {
         // MarkListStudent M = MarkListStudent(name: 'Haris', className: 'className', admissionNo: 'admissionNo', academicYear: 'academicYear');
           AppNavigator.pushSlide(context: context, page: MarkListPage());
          //AppNavigator.pushSlide(context: context, page: MarkListScreen(student: M, examTitle: '', subjects: [],));
        }
        if (label == "Material") {
          AppNavigator.pushSlide(context: context, page: SubjectPage());
        }
        if (label == "Attendance") {
          AppNavigator.pushSlide(context: context, page: AttendenceScreen());
        }
        if (label == "Academic Calendar") {
          AppNavigator.pushSlide(context: context, page: AcademicCalendarScreen());
        }
        if (label == "Early Go") {
          AppNavigator.pushSlide(context: context, page: EarlyGoScreen());
        }
      },
      child: Container(
        height: 90,
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
