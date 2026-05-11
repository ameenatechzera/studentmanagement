import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({super.key});

  @override
  State<AttendenceScreen> createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  final DateTime _today = DateTime.now();
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime?> _selectedDay = ValueNotifier(DateTime.now());

  @override
  void initState() {
    super.initState();
    _callApi(_focusedDay.value);
  }

  void _callApi(DateTime date) {
    context.read<AttendenceCubit>().getAttendanceReportByMonth(
      AttendanceReportByMonthParameter(
        admno: "PKG7",
        month: 4,
        accYear: "2026-2027",
        branchId: 1,
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  void _changeMonth(int offset) {
    final focusedDay = _focusedDay.value;

    final changedMonth = DateTime(
      focusedDay.year,
      focusedDay.month + offset,
      1,
    );

    _focusedDay.value = changedMonth;
    _callApi(changedMonth);

    final isCurrentMonth =
        changedMonth.year == _today.year && changedMonth.month == _today.month;

    _selectedDay.value = isCurrentMonth ? _today : null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AttendenceCubit>().getAttendanceReportByDate(
          AttendanceReportByDateParameter(
            admno: "PKG7",
            date: "2026-04-04",
            accYear: "2026-2027",
            branchId: 1,
          ),
        );

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: const Text(
            'My Attendance',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          // actions: [
          //   ValueListenableBuilder<DateTime>(
          //     valueListenable: _focusedDay,
          //     builder: (context, focusedDay, _) {
          //       return Row(
          //         children: [
          //           IconButton(
          //             icon: const Icon(Icons.chevron_left),
          //             color: Colors.black,
          //             onPressed: () => _changeMonth(-1),
          //           ),
          //           Text(
          //             "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
          //             style: const TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.w800,
          //             ),
          //           ),
          //           IconButton(
          //             icon: const Icon(Icons.chevron_right),
          //             color: Colors.black,
          //             onPressed: () => _changeMonth(1),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ],
        ),

        body: Column(
          children: [
            /// ✅ ALWAYS VISIBLE CALENDAR
            // _buildCalendarSection(),

            /// ✅ ONLY LIST CHANGES
            BlocBuilder<AttendenceCubit, AttendenceState>(
              builder: (context, state) {
                if (state is AttendenceMonthLoading) {
                  return AllClassDiarySkeleton();
                }

                if (state is AttendenceMonthError) {
                  return Center(child: Text(state.message));
                }

                if (state is AttendenceMonthLoaded) {
                  final student = state.data.data?.isNotEmpty == true
                      ? state.data.data!.first
                      : null;

                  final daysMap = student?.days ?? {};

                  final focusedDay = _focusedDay.value;

                  final daysInMonth = DateTime(
                    focusedDay.year,
                    focusedDay.month + 1,
                    0,
                  ).day;

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: daysInMonth,
                      itemBuilder: (context, index) {
                        final date = DateTime(
                          focusedDay.year,
                          focusedDay.month,
                          index + 1,
                        );

                        final dayKey = "Day${index + 1}";
                        final statusValue = daysMap[dayKey];

                        final now = DateTime.now();
                        final today = DateTime(now.year, now.month, now.day);

                        String status;
                        Color color;
                        double progress;
                        String time;

                        /// ✅ FUTURE DATE
                        if (date.isAfter(today)) {
                          status = "Upcoming";
                          color = Colors.blueGrey;
                          progress = 0.0;
                          time = "Not Yet";
                        }
                        /// ✅ PRESENT
                        else if (statusValue == "Present") {
                          status = "Present";
                          color = const Color(0xff22c55e);
                          progress = 1.0;
                          time = "09:00 AM - 06:00 PM";
                        }
                        /// ✅ ABSENT
                        else if (statusValue == "Absent") {
                          status = "Absent";
                          color = const Color(0xffef4444);
                          progress = 0.0;
                          time = "No Login";
                        }
                        /// ✅ NO DATA
                        else {
                          status = "No Data";
                          color = Colors.blueGrey;
                          progress = 0.0;
                          time = "Missing Data";
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AttendanceCard(
                            date: date,
                            status: status,
                            time: time,
                            progress: progress,
                            color: color,
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
            // Stack(
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.all(16),
            //       padding: const EdgeInsets.all(18),
            //       decoration: BoxDecoration(
            //         color: const Color(0xffc5c4ff),
            //         borderRadius: BorderRadius.circular(28),
            //       ),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Expanded(
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Text(
            //                       "Total working days",
            //                       style: TextStyle(
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.w800,
            //                         color: Color(0xff111827),
            //                       ),
            //                     ),

            //                     SizedBox(height: 35),

            //                     Text(
            //                       "22",
            //                       style: TextStyle(
            //                         fontSize: 34,
            //                         fontWeight: FontWeight.w900,
            //                         color: Colors.black,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),

            //               Expanded(
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const Text(
            //                       "Total Attendance",
            //                       style: TextStyle(
            //                         fontSize: 15,
            //                         fontWeight: FontWeight.w800,
            //                         color: Color(0xff111827),
            //                       ),
            //                     ),

            //                     const SizedBox(height: 16),

            //                     SizedBox(
            //                       width: 100,
            //                       height: 100,
            //                       child: Stack(
            //                         alignment: Alignment.center,
            //                         children: [
            //                           Transform.scale(
            //                             scale: 1.8,
            //                             child: CircularProgressIndicator(
            //                               value: 0.89,
            //                               strokeWidth: 8,
            //                               backgroundColor: Colors.white,
            //                               valueColor:
            //                                   const AlwaysStoppedAnimation(
            //                                     Color(0xff807fd8),
            //                                   ),
            //                             ),
            //                           ),

            //                           const Text(
            //                             "89%",
            //                             style: TextStyle(
            //                               fontSize: 17,
            //                               fontWeight: FontWeight.w900,
            //                               color: Color(0xff111827),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),

            //           // const SizedBox(height: 20),
            //           Container(
            //             padding: const EdgeInsets.symmetric(
            //               horizontal: 22,
            //               vertical: 5,
            //             ),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(18),
            //             ),
            //             child: Column(
            //               children: [
            //                 Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     _attendanceLegendDot(
            //                       title: "Present",
            //                       color: const Color(0xff22c55e),
            //                     ),
            //                     _attendanceLegendDot(
            //                       title: "Absent",
            //                       color: const Color(0xffff4b4b),
            //                     ),
            //                     Row(
            //                       children: [
            //                         Container(
            //                           width: 11,
            //                           height: 11,
            //                           decoration: const BoxDecoration(
            //                             shape: BoxShape.circle,
            //                             gradient: LinearGradient(
            //                               colors: [
            //                                 Color(0xff22c55e),
            //                                 Color(0xffff4b4b),
            //                               ],
            //                             ),
            //                           ),
            //                         ),
            //                         const SizedBox(width: 6),
            //                         const Text(
            //                           "Half day",
            //                           style: TextStyle(
            //                             fontSize: 13,
            //                             fontWeight: FontWeight.w700,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),

            //                 const SizedBox(height: 12),

            //                 const Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       "19",
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w900,
            //                       ),
            //                     ),
            //                     Text(
            //                       "2",
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w900,
            //                       ),
            //                     ),
            //                     Text(
            //                       "1",
            //                       style: TextStyle(
            //                         fontSize: 20,
            //                         fontWeight: FontWeight.w900,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),

            //     Positioned(
            //       right: 100,
            //       top: 40,
            //       child: Image.asset(
            //         "assets/images/mask_bg.png",
            //         width: 250,
            //         height: 200,
            //         fit: BoxFit.contain,
            //         color: Colors.black,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceLegendDot({required String title, required Color color}) {
    return Row(
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  //   Widget _buildCalendarSection() {
  //     return ValueListenableBuilder<DateTime>(
  //       valueListenable: _focusedDay,
  //       builder: (context, focusedDay, _) {
  //         return BlocBuilder<AttendenceCubit, AttendenceState>(
  //           builder: (context, state) {
  //             Map<String, dynamic> daysMap = {};

  //             if (state is AttendenceMonthLoaded) {
  //               final student = state.data.data?.isNotEmpty == true
  //                   ? state.data.data!.first
  //                   : null;

  //               daysMap = student?.days ?? {};
  //             }

  //             final daysInMonth = DateTime(
  //               focusedDay.year,
  //               focusedDay.month + 1,
  //               0,
  //             ).day;

  //             final firstDayOfMonth = DateTime(
  //               focusedDay.year,
  //               focusedDay.month,
  //               1,
  //             );

  //             /// Sunday = 0
  //             final startWeekDay = firstDayOfMonth.weekday % 7;

  //             final totalItems = startWeekDay + daysInMonth;

  //             return Container(
  //               //padding: const EdgeInsets.all(16),
  //               color: Colors.white,
  //               child: Column(
  //                 children: [
  //                   /// MONTH TITLE
  //                   Text(
  //                     "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
  //                     style: const TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.w800,
  //                       color: Colors.black,
  //                     ),
  //                   ),

  //                   const SizedBox(height: 10),

  //                   /// WEEK DAYS
  //                   GridView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: 7,
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 7,
  //                           childAspectRatio: 1.5,
  //                         ),
  //                     itemBuilder: (context, index) {
  //                       final weekDays = [
  //                         'SUN',
  //                         'MON',
  //                         'TUE',
  //                         'WED',
  //                         'THU',
  //                         'FRI',
  //                         'SAT',
  //                       ];

  //                       return Center(
  //                         child: Text(
  //                           weekDays[index],
  //                           style: const TextStyle(
  //                             fontSize: 11,
  //                             fontWeight: FontWeight.w700,
  //                             color: Colors.grey,
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),

  //                   /// REAL CALENDAR GRID
  //                   GridView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: totalItems,
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 7,
  //                           childAspectRatio: 0.95,
  //                         ),
  //                     itemBuilder: (context, index) {
  //                       /// EMPTY BOXES BEFORE MONTH STARTS
  //                       if (index < startWeekDay) {
  //                         return Container(
  //                           decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.grey.shade200),
  //                           ),
  //                         );
  //                       }

  //                       final day = index - startWeekDay + 1;

  //                       final dayKey = "Day$day";
  //                       final statusValue = daysMap[dayKey];

  //                       final isPresent = statusValue == "Present";
  //                       final isAbsent = statusValue == "Absent";

  //                       Color bgColor = Colors.white;
  //                       Color textColor = Colors.black87;

  //                       if (isAbsent) {
  //                         bgColor = const Color(0xffef4444);
  //                         textColor = Colors.white;
  //                       }

  //                       return Container(
  //                         decoration: BoxDecoration(
  //                           color: bgColor,
  //                           border: Border.all(color: Colors.grey.shade300),
  //                         ),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               "$day",
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.w700,
  //                                 color: textColor,
  //                               ),
  //                             ),

  //                             if (isPresent)
  //                               Container(
  //                                 width: 5,
  //                                 height: 5,
  //                                 margin: const EdgeInsets.only(top: 5),
  //                                 decoration: const BoxDecoration(
  //                                   color: Color(0xff22c55e),
  //                                   shape: BoxShape.circle,
  //                                 ),
  //                               ),

  //                             if (isAbsent)
  //                               const Padding(
  //                                 padding: EdgeInsets.only(top: 5),
  //                                 child: Text(
  //                                   "Absent",
  //                                   style: TextStyle(
  //                                     fontSize: 9,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),

  //                   const SizedBox(height: 14),

  //                   /// LEGEND
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 8,
  //                             height: 8,
  //                             decoration: const BoxDecoration(
  //                               color: Color(0xff22c55e),
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text("Present", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       ),

  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 10,
  //                             height: 10,
  //                             decoration: const BoxDecoration(
  //                               color: Color(0xffef4444),
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text("Absent", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       ),

  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 10,
  //                             height: 10,
  //                             decoration: const BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               gradient: LinearGradient(
  //                                 colors: [
  //                                   Color(0xff22c55e),
  //                                   Color(0xff22c55e),
  //                                   Color(0xffef4444),
  //                                   Color(0xffef4444),
  //                                 ],
  //                                 stops: [0.0, 0.5, 0.5, 1.0],
  //                                 begin: Alignment.centerLeft,
  //                                 end: Alignment.centerRight,
  //                               ),
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text(
  //                             "Half Day",
  //                             style: TextStyle(fontSize: 12),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }
  //   Widget _buildCalendarSection() {
  //     return ValueListenableBuilder<DateTime>(
  //       valueListenable: _focusedDay,
  //       builder: (context, focusedDay, _) {
  //         return BlocBuilder<AttendenceCubit, AttendenceState>(
  //           builder: (context, state) {
  //             Map<String, dynamic> daysMap = {};

  //             if (state is AttendenceMonthLoaded) {
  //               final student = state.data.data?.isNotEmpty == true
  //                   ? state.data.data!.first
  //                   : null;

  //               daysMap = student?.days ?? {};
  //             }

  //             final daysInMonth = DateTime(
  //               focusedDay.year,
  //               focusedDay.month + 1,
  //               0,
  //             ).day;

  //             final firstDayOfMonth = DateTime(
  //               focusedDay.year,
  //               focusedDay.month,
  //               1,
  //             );

  //             /// Sunday = 0
  //             final startWeekDay = firstDayOfMonth.weekday % 7;

  //             final totalItems = startWeekDay + daysInMonth;

  //             return Container(
  //               color: Colors.white,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ValueListenableBuilder<DateTime>(
  //                     valueListenable: _focusedDay,
  //                     builder: (context, focusedDay, _) {
  //                       return Row(
  //                         children: [
  //                           IconButton(
  //                             icon: const Icon(Icons.chevron_left),
  //                             color: Colors.black,
  //                             onPressed: () => _changeMonth(-1),
  //                           ),
  //                           Text(
  //                             "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
  //                             style: const TextStyle(
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.w800,
  //                             ),
  //                           ),
  //                           IconButton(
  //                             icon: const Icon(Icons.chevron_right),
  //                             color: Colors.black,
  //                             onPressed: () => _changeMonth(1),
  //                           ),
  //                         ],
  //                       );
  //                     },
  //                   ),
  //                   // /// MONTH TITLE
  //                   // Text(
  //                   //   "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
  //                   //   style: const TextStyle(
  //                   //     fontSize: 18,
  //                   //     fontWeight: FontWeight.w800,
  //                   //     color: Colors.black,
  //                   //   ),
  //                   // ),
  //                   const SizedBox(height: 10),

  //                   /// WEEK DAYS
  //                   GridView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: 7,
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 7,
  //                           childAspectRatio: 1.5,
  //                         ),
  //                     itemBuilder: (context, index) {
  //                       final weekDays = [
  //                         'SUN',
  //                         'MON',
  //                         'TUE',
  //                         'WED',
  //                         'THU',
  //                         'FRI',
  //                         'SAT',
  //                       ];

  //                       return Center(
  //                         child: Text(
  //                           weekDays[index],
  //                           style: const TextStyle(
  //                             fontSize: 11,
  //                             fontWeight: FontWeight.w700,
  //                             color: Colors.grey,
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),

  //                   /// REAL CALENDAR GRID
  //                   GridView.builder(
  //                     shrinkWrap: true,
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemCount: totalItems,
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 7,
  //                           childAspectRatio: 0.95,
  //                         ),
  //                     itemBuilder: (context, index) {
  //                       /// EMPTY CELLS BEFORE MONTH START
  //                       if (index < startWeekDay) {
  //                         return Container(
  //                           decoration: BoxDecoration(
  //                             border: Border.all(color: Colors.grey.shade200),
  //                           ),
  //                         );
  //                       }

  //                       final day = index - startWeekDay + 1;

  //                       final dayKey = "Day$day";
  //                       final statusValue = daysMap[dayKey];

  //                       final isPresent = statusValue == "Present";
  //                       final isAbsent = statusValue == "Absent";

  //                       /// TEMP MOCK LEAVE DAYS
  //                       final leaveDays = [5, 12, 21];

  //                       final isLeave =
  //                           statusValue == "Leave" || leaveDays.contains(day);

  //                       Color bgColor = Colors.white;
  //                       Color textColor = Colors.black87;

  //                       if (isAbsent) {
  //                         bgColor = const Color(0xffef4444);
  //                         textColor = Colors.white;
  //                       }

  //                       if (isLeave) {
  //                         bgColor = Colors.red;
  //                         textColor = Colors.white;
  //                       }

  //                       return Container(
  //                         decoration: BoxDecoration(
  //                           color: bgColor,
  //                           border: Border.all(color: Colors.grey.shade300),
  //                         ),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               "$day",
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.w700,
  //                                 color: textColor,
  //                               ),
  //                             ),

  //                             /// PRESENT
  //                             if (isPresent)
  //                               Container(
  //                                 width: 5,
  //                                 height: 5,
  //                                 margin: const EdgeInsets.only(top: 5),
  //                                 decoration: const BoxDecoration(
  //                                   color: Color(0xff22c55e),
  //                                   shape: BoxShape.circle,
  //                                 ),
  //                               ),

  //                             /// ABSENT
  //                             if (isAbsent)
  //                               const Padding(
  //                                 padding: EdgeInsets.only(top: 5),
  //                                 child: Text(
  //                                   "Absent",
  //                                   style: TextStyle(
  //                                     fontSize: 9,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                               ),

  //                             /// LEAVE
  //                             InkWell(
  //                               child: const Padding(
  //                                 padding: EdgeInsets.only(top: 5),
  //                                 child: Text(
  //                                   "Fever",
  //                                   style: TextStyle(
  //                                     fontSize: 9,
  //                                     color: Colors.white,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       );
  //                     },
  //                   ),

  //                   const SizedBox(height: 14),

  //                   /// LEGEND
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       /// PRESENT
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 8,
  //                             height: 8,
  //                             decoration: const BoxDecoration(
  //                               color: Color(0xff22c55e),
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text("Present", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       ),

  //                       /// ABSENT
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 10,
  //                             height: 10,
  //                             decoration: const BoxDecoration(
  //                               color: Color(0xffef4444),
  //                               shape: BoxShape.circle,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text("Absent", style: TextStyle(fontSize: 12)),
  //                         ],
  //                       ),

  //                       /// HALF DAY
  //                       Row(
  //                         children: [
  //                           Container(
  //                             width: 10,
  //                             height: 10,
  //                             decoration: const BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               gradient: LinearGradient(
  //                                 colors: [
  //                                   Color(0xff22c55e),
  //                                   Color(0xff22c55e),
  //                                   Color(0xffef4444),
  //                                   Color(0xffef4444),
  //                                 ],
  //                                 stops: [0.0, 0.5, 0.5, 1.0],
  //                                 begin: Alignment.centerLeft,
  //                                 end: Alignment.centerRight,
  //                               ),
  //                             ),
  //                           ),
  //                           const SizedBox(width: 5),
  //                           const Text(
  //                             "Half Day",
  //                             style: TextStyle(fontSize: 12),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     );
  //   }
  // }
  Widget _buildCalendarSection() {
    final ValueNotifier<Map<String, dynamic>?> selectedLeave =
        ValueNotifier<Map<String, dynamic>?>(null);

    const double cellHeight = 72.0;
    const double popupHeightOffset = 155.0;

    return ValueListenableBuilder<DateTime>(
      valueListenable: _focusedDay,
      builder: (context, focusedDay, _) {
        return BlocBuilder<AttendenceCubit, AttendenceState>(
          builder: (context, state) {
            Map<String, dynamic> daysMap = {};

            if (state is AttendenceMonthLoaded) {
              final student = state.data.data?.isNotEmpty == true
                  ? state.data.data!.first
                  : null;

              daysMap = student?.days ?? {};
            }

            final daysInMonth = DateTime(
              focusedDay.year,
              focusedDay.month + 1,
              0,
            ).day;

            final firstDayOfMonth = DateTime(
              focusedDay.year,
              focusedDay.month,
              1,
            );

            final startWeekDay = firstDayOfMonth.weekday % 7;
            final totalItems = startWeekDay + daysInMonth;

            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        color: Colors.black,
                        onPressed: () {
                          selectedLeave.value = null;
                          _changeMonth(-1);
                        },
                      ),
                      Text(
                        "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        color: Colors.black,
                        onPressed: () {
                          selectedLeave.value = null;
                          _changeMonth(1);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 7,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1.5,
                        ),
                    itemBuilder: (context, index) {
                      final weekDays = [
                        'SUN',
                        'MON',
                        'TUE',
                        'WED',
                        'THU',
                        'FRI',
                        'SAT',
                      ];

                      return Center(
                        child: Text(
                          weekDays[index],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),

                  ValueListenableBuilder<Map<String, dynamic>?>(
                    valueListenable: selectedLeave,
                    builder: (context, leaveData, _) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: totalItems,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 7,
                                  childAspectRatio: 0.95,
                                ),
                            itemBuilder: (context, index) {
                              if (index < startWeekDay) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                );
                              }

                              final day = index - startWeekDay + 1;
                              final dayKey = "Day$day";
                              final statusValue = daysMap[dayKey];

                              /// CURRENT DATE
                              final currentDate = DateTime(
                                focusedDay.year,
                                focusedDay.month,
                                day,
                              );

                              /// WEEKEND CHECK
                              final isSaturday =
                                  currentDate.weekday == DateTime.saturday;

                              final isSunday =
                                  currentDate.weekday == DateTime.sunday;

                              // final isPresent = statusValue == "Present";
                              // final isAbsent = statusValue == "Absent";

                              final leaveDays = {
                                18: {
                                  "title": "Personal Reason",
                                  "date": "18-10-2026",
                                  "short": "Per.....",
                                  "description":
                                      "Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Sed Do Eiusmod Tempor Incididunt Ut Labore Et Dolore",
                                },
                                27: {
                                  "title": "Head Ache",
                                  "date": "27-10-2026",
                                  "short": "Head\nAche",
                                  "description":
                                      "Student requested leave due to headache and health discomfort.",
                                },
                              };

                              /// LEAVE CHECK
                              final isLeave =
                                  statusValue == "Leave" ||
                                  leaveDays.containsKey(day);

                              /// ABSENT CHECK
                              final isAbsent = statusValue == "Absent";

                              /// ✅ GREEN DOT ONLY FOR NORMAL WEEKDAYS
                              final isPresent =
                                  !isSaturday &&
                                  !isSunday &&
                                  !isLeave &&
                                  !isAbsent;
                              // final isLeave =
                              //     statusValue == "Leave" ||
                              //     leaveDays.containsKey(day);

                              Color bgColor = Colors.white;
                              Color textColor = Colors.black87;

                              if (isAbsent) {
                                bgColor = const Color(0xffef4444);
                                textColor = Colors.white;
                              }

                              if (isLeave) {
                                bgColor = const Color(0xffff4b4b);
                                textColor = Colors.white;
                              }

                              return InkWell(
                                onTap: isLeave
                                    ? () {
                                        final columnIndex = index % 7;
                                        final rowIndex = index ~/ 7;

                                        selectedLeave.value = {
                                          "day": day,
                                          "index": index,
                                          "rowIndex": rowIndex,
                                          "columnIndex": columnIndex,
                                          ...?leaveDays[day],
                                        };
                                      }
                                    : null,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "$day",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: textColor,
                                        ),
                                      ),

                                      if (isPresent)
                                        Container(
                                          width: 5,
                                          height: 5,
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: const BoxDecoration(
                                            color: Color(0xff22c55e),
                                            shape: BoxShape.circle,
                                          ),
                                        ),

                                      if (isAbsent)
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Absent",
                                            style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                      if (isLeave)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Text(
                                            leaveDays[day]?["short"] ?? "Leave",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          if (leaveData != null)
                            Positioned(
                              top:
                                  ((leaveData["rowIndex"] ?? 0) * cellHeight) -
                                  popupHeightOffset,
                              left: 22,
                              right: 22,
                              child: _leaveDetailsPopup(
                                title: leaveData["title"] ?? "Leave",
                                date: leaveData["date"] ?? "",
                                description: leaveData["description"] ?? "",
                                columnIndex: leaveData["columnIndex"] ?? 3,
                                onClose: () {
                                  selectedLeave.value = null;
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xff22c55e),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Present", style: TextStyle(fontSize: 12)),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xffef4444),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text("Absent", style: TextStyle(fontSize: 12)),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff22c55e),
                                  Color(0xff22c55e),
                                  Color(0xffef4444),
                                  Color(0xffef4444),
                                ],
                                stops: [0.0, 0.5, 0.5, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Half Day",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _leaveDetailsPopup({
    required String title,
    required String date,
    required String description,
    required int columnIndex,
    required VoidCallback onClose,
  }) {
    final double alignmentX = (-1.0 + (columnIndex * (2 / 6))).clamp(
      -0.82,
      0.82,
    );

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 14, 12, 20),
            decoration: BoxDecoration(
              color: const Color(0xff2d2d2d),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "$title ($date)",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onClose,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    height: 1.7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment(
              columnIndex == 0
                  ? -0.94
                  : columnIndex == 6
                  ? 0.94
                  : alignmentX,
              0,
            ),
            child: CustomPaint(
              size: const Size(24, 14),
              painter: _TrianglePainter(columnIndex: columnIndex),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final int columnIndex;

  _TrianglePainter({required this.columnIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xff2d2d2d);

    final path = Path();

    /// LEFT EDGE
    if (columnIndex == 0) {
      path
        ..moveTo(6, 0)
        ..lineTo(0, size.height)
        ..lineTo(18, 0)
        ..close();
    }
    /// RIGHT EDGE
    else if (columnIndex == 6) {
      path
        ..moveTo(size.width - 18, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width - 6, 0)
        ..close();
    }
    /// CENTER
    else {
      path
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0)
        ..close();
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         /// ✅ trigger API before going back
//         context.read<AttendenceCubit>().getAttendanceReportByDate(
//           AttendanceReportByDateParameter(
//             admno: "PKG7",
//             date: "2026-04-04",
//             accYear: "2026-2027",
//             branchId: 1,
//           ),
//         );

//         return true; // allow back
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,

//         appBar: AppBar(
//           title: const Text(
//             'Attendance Report',
//             style: TextStyle(fontSize: 18),
//           ),
//           backgroundColor: Colors.white,
//           elevation: 0,
//           actions: [
//             ValueListenableBuilder<DateTime>(
//               valueListenable: _focusedDay,
//               builder: (context, focusedDay, _) {
//                 return Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.chevron_left),
//                       color: Colors.black,
//                       onPressed: () => _changeMonth(-1),
//                     ),
//                     Text(
//                       "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.chevron_right),
//                       color: Colors.black,
//                       onPressed: () => _changeMonth(1),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),

//         body: BlocBuilder<AttendenceCubit, AttendenceState>(
//           builder: (context, state) {
//             if (state is AttendenceMonthLoading) {
//               return AllClassDiarySkeleton();
//             }

//             if (state is AttendenceMonthError) {
//               return Center(child: Text(state.message));
//             }

//             if (state is AttendenceMonthLoaded) {
//               final student = state.data.data?.isNotEmpty == true
//                   ? state.data.data!.first
//                   : null;

//               final daysMap = student?.days ?? {};

//               final focusedDay = _focusedDay.value;

//               final daysInMonth = DateTime(
//                 focusedDay.year,
//                 focusedDay.month + 1,
//                 0,
//               ).day;

//               // return ListView.builder(
//               //   padding: const EdgeInsets.all(16),
//               //   itemCount: daysInMonth,
//               //   itemBuilder: (context, index) {
//               //     final date = DateTime(
//               //       focusedDay.year,
//               //       focusedDay.month,
//               //       index + 1,
//               //     );

//               //     final dayKey = "Day${index + 1}";
//               //     final statusValue = daysMap[dayKey];

//               //     final now = DateTime.now();
//               //     final today = DateTime(now.year, now.month, now.day);

//               //     String status;
//               //     Color color;
//               //     double progress;
//               //     String time;

//               //     /// ✅ FUTURE DATE
//               //     if (date.isAfter(today)) {
//               //       status = "Upcoming";
//               //       color = Colors.blueGrey;
//               //       progress = 0.0;
//               //       time = "Not Yet";
//               //     }
//               //     /// ✅ PRESENT
//               //     else if (statusValue == "Present") {
//               //       status = "Present";
//               //       color = const Color(0xff22c55e);
//               //       progress = 1.0;
//               //       time = "09:00 AM - 06:00 PM";
//               //     }
//               //     /// ✅ ABSENT
//               //     else if (statusValue == "Absent") {
//               //       status = "Absent";
//               //       color = const Color(0xffef4444);
//               //       progress = 0.0;
//               //       time = "No Login";
//               //     }
//               //     /// ✅ PAST BUT NOT MARKED
//               //     else {
//               //       status = "No Data";
//               //       color = Colors.blueGrey;
//               //       progress = 0.0;
//               //       time = "Missing Data";
//               //     }

//               //     return Padding(
//               //       padding: const EdgeInsets.only(bottom: 16),
//               //       child: AttendanceCard(
//               //         date: date,
//               //         status: status,
//               //         time: time,
//               //         progress: progress,
//               //         color: color,
//               //       ),
//               //     );
//               //   },
//               // );
//               return ListView(
//                 padding: const EdgeInsets.all(16),
//                 children: [
//                   /// Calendar Section
//                   Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: 7,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 7,
//                                 childAspectRatio: 1.2,
//                               ),
//                           itemBuilder: (context, index) {
//                             final weekDays = [
//                               'SUN',
//                               'MON',
//                               'TUE',
//                               'WED',
//                               'THU',
//                               'FRI',
//                               'SAT',
//                             ];

//                             return Center(
//                               child: Text(
//                                 weekDays[index],
//                                 style: const TextStyle(
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),

//                         GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: daysInMonth,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 7,
//                                 childAspectRatio: 0.95,
//                               ),
//                           itemBuilder: (context, index) {
//                             final day = index + 1;
//                             final dayKey = "Day$day";
//                             final statusValue = daysMap[dayKey];

//                             final isPresent = statusValue == "Present";
//                             final isAbsent = statusValue == "Absent";

//                             Color bgColor = Colors.white;
//                             Color textColor = Colors.black87;

//                             if (isAbsent) {
//                               bgColor = const Color(0xffef4444);
//                               textColor = Colors.white;
//                             }

//                             return Container(
//                               margin: const EdgeInsets.all(1),
//                               decoration: BoxDecoration(
//                                 color: bgColor,
//                                 border: Border.all(color: Colors.grey.shade300),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "$day",
//                                     style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w700,
//                                       color: textColor,
//                                     ),
//                                   ),

//                                   if (isPresent)
//                                     Container(
//                                       width: 5,
//                                       height: 5,
//                                       margin: const EdgeInsets.only(top: 5),
//                                       decoration: const BoxDecoration(
//                                         color: Color(0xff22c55e),
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),

//                                   if (isAbsent)
//                                     const Padding(
//                                       padding: EdgeInsets.only(top: 5),
//                                       child: Text(
//                                         "Absent",
//                                         style: TextStyle(
//                                           fontSize: 9,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),

//                         const SizedBox(height: 14),

//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 8,
//                                   height: 8,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xff22c55e),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 const Text(
//                                   "Present",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Container(
//                                   width: 8,
//                                   height: 8,
//                                   decoration: const BoxDecoration(
//                                     color: Color(0xffef4444),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 5),
//                                 const Text(
//                                   "Absent",
//                                   style: TextStyle(fontSize: 12),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// Existing List Section
//                   ...List.generate(daysInMonth, (index) {
//                     final date = DateTime(
//                       focusedDay.year,
//                       focusedDay.month,
//                       index + 1,
//                     );

//                     final dayKey = "Day${index + 1}";
//                     final statusValue = daysMap[dayKey];

//                     final now = DateTime.now();
//                     final today = DateTime(now.year, now.month, now.day);

//                     String status;
//                     Color color;
//                     double progress;
//                     String time;

//                     if (date.isAfter(today)) {
//                       status = "Upcoming";
//                       color = Colors.blueGrey;
//                       progress = 0.0;
//                       time = "Not Yet";
//                     } else if (statusValue == "Present") {
//                       status = "Present";
//                       color = const Color(0xff22c55e);
//                       progress = 1.0;
//                       time = "09:00 AM - 06:00 PM";
//                     } else if (statusValue == "Absent") {
//                       status = "Absent";
//                       color = const Color(0xffef4444);
//                       progress = 0.0;
//                       time = "No Login";
//                     } else {
//                       status = "No Data";
//                       color = Colors.blueGrey;
//                       progress = 0.0;
//                       time = "Missing Data";
//                     }

//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: AttendanceCard(
//                         date: date,
//                         status: status,
//                         time: time,
//                         progress: progress,
//                         color: color,
//                       ),
//                     );
//                   }),
//                 ],
//               );
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }

class AttendanceCard extends StatelessWidget {
  final DateTime date;
  final String status;
  final String time;
  final double progress;
  final Color color;

  const AttendanceCard({
    super.key,
    required this.date,
    required this.status,
    required this.time,
    required this.progress,
    required this.color,
  });

  String _getWeekDay(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${date.day}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _getWeekDay(date.weekday),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),

                const SizedBox(height: 4),

                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${(progress * 100).toInt()}%",
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
