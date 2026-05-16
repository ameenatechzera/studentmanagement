import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';

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

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  void _callApi(DateTime date) {
    context.read<AttendenceCubit>().getAttendanceReportByMonth(
      AttendanceReportByMonthParameter(
        admno: AppData.admissionNo!,
        month: date.month,
        accYear: AppData.accYear!,
        branchId: AppData.branchId!,
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
    return Scaffold(
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
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ✅ ALWAYS VISIBLE CALENDAR
            _buildCalendarSection(),
            BlocBuilder<AttendenceCubit, AttendenceState>(
              builder: (context, state) {
                bool isLoading = state is AttendenceMonthLoading;

                int totalPresent = 0;
                int totalAbsent = 0;

                if (state is AttendenceMonthLoaded) {
                  final student = state.data.data?.isNotEmpty == true
                      ? state.data.data!.first
                      : null;

                  totalPresent =
                      int.tryParse(student?.totalPresent?.toString() ?? "0") ??
                      0;

                  totalAbsent =
                      int.tryParse(student?.totalAbsent?.toString() ?? "0") ??
                      0;
                }

                final totalWorkingDays = totalPresent + totalAbsent;

                final attendancePercentage = totalWorkingDays == 0
                    ? 0.0
                    : totalPresent / totalWorkingDays;

                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xffc5c4ff),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Total working days",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff111827),
                                      ),
                                    ),

                                    const SizedBox(height: 35),

                                    isLoading
                                        ? const SizedBox(
                                            height: 34,
                                            width: 34,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: Colors.black,
                                            ),
                                          )
                                        : Text(
                                            "$totalWorkingDays",
                                            style: const TextStyle(
                                              fontSize: 34,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Total Attendance",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xff111827),
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Transform.scale(
                                            scale: 1.8,
                                            child: CircularProgressIndicator(
                                              value: isLoading
                                                  ? null
                                                  : attendancePercentage,
                                              strokeWidth: 8,
                                              backgroundColor: Colors.white,
                                              valueColor:
                                                  const AlwaysStoppedAnimation(
                                                    Color(0xff807fd8),
                                                  ),
                                            ),
                                          ),

                                          isLoading
                                              ? const SizedBox.shrink()
                                              : Text(
                                                  "${(attendancePercentage * 100).toInt()}%",
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w900,
                                                    color: Color(0xff111827),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 25),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _attendanceLegendDot(
                                      title: "Present",
                                      color: const Color(0xff22c55e),
                                    ),
                                    _attendanceLegendDot(
                                      title: "Absent",
                                      color: const Color(0xffff4b4b),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    isLoading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            "$totalPresent",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),

                                    isLoading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : Text(
                                            "$totalAbsent",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      right: 100,
                      top: 40,
                      child: Image.asset(
                        "assets/images/mask_bg.png",
                        width: 250,
                        height: 200,
                        fit: BoxFit.contain,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
            // BlocBuilder<AttendenceCubit, AttendenceState>(
            //   builder: (context, state) {
            //     if (state is AttendenceMonthLoading) {
            //       return const Center(
            //         child: Padding(
            //           padding: EdgeInsets.all(30),
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //     if (state is AttendenceMonthError) {
            //       return Center(
            //         child: Padding(
            //           padding: const EdgeInsets.all(20),
            //           child: Text(state.message),
            //         ),
            //       );
            //     }
            //     if (state is AttendenceMonthLoaded) {
            //       final student = state.data.data?.isNotEmpty == true
            //           ? state.data.data!.first
            //           : null;

            //       final totalPresent =
            //           int.tryParse(student?.totalPresent?.toString() ?? "0") ??
            //           0;

            //       final totalAbsent =
            //           int.tryParse(student?.totalAbsent?.toString() ?? "0") ??
            //           0;

            //       // final totalLeave =
            //       //     int.tryParse(student?.totalAbsent.toString() ?? "0") ?? 0;

            //       final totalWorkingDays = totalPresent + totalAbsent;

            //       final attendancePercentage = totalWorkingDays == 0
            //           ? 0.0
            //           : totalPresent / totalWorkingDays;
            //       return Stack(
            //         children: [
            //           Container(
            //             margin: const EdgeInsets.all(16),
            //             padding: const EdgeInsets.all(18),
            //             decoration: BoxDecoration(
            //               color: const Color(0xffc5c4ff),
            //               borderRadius: BorderRadius.circular(28),
            //             ),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Expanded(
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             "Total working days",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w800,
            //                               color: Color(0xff111827),
            //                             ),
            //                           ),

            //                           SizedBox(height: 35),

            //                           Text(
            //                             "$totalWorkingDays",
            //                             style: TextStyle(
            //                               fontSize: 34,
            //                               fontWeight: FontWeight.w900,
            //                               color: Colors.black,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),

            //                     Expanded(
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         children: [
            //                           const Text(
            //                             "Total Attendance",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w800,
            //                               color: Color(0xff111827),
            //                             ),
            //                           ),

            //                           const SizedBox(height: 16),

            //                           SizedBox(
            //                             width: 100,
            //                             height: 100,
            //                             child: Stack(
            //                               alignment: Alignment.center,
            //                               children: [
            //                                 Transform.scale(
            //                                   scale: 1.8,
            //                                   child: CircularProgressIndicator(
            //                                     value: attendancePercentage,
            //                                     strokeWidth: 8,
            //                                     backgroundColor: Colors.white,
            //                                     valueColor:
            //                                         const AlwaysStoppedAnimation(
            //                                           Color(0xff807fd8),
            //                                         ),
            //                                   ),
            //                                 ),

            //                                 Text(
            //                                   "${(attendancePercentage * 100).toInt()}%",
            //                                   style: TextStyle(
            //                                     fontSize: 17,
            //                                     fontWeight: FontWeight.w900,
            //                                     color: Color(0xff111827),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),

            //                 // const SizedBox(height: 20),
            //                 Container(
            //                   padding: const EdgeInsets.symmetric(
            //                     horizontal: 22,
            //                     vertical: 5,
            //                   ),
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(18),
            //                   ),
            //                   child: Column(
            //                     children: [
            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceAround,
            //                         children: [
            //                           _attendanceLegendDot(
            //                             title: "Present",
            //                             color: const Color(0xff22c55e),
            //                           ),
            //                           _attendanceLegendDot(
            //                             title: "Absent",
            //                             color: const Color(0xffff4b4b),
            //                           ),
            //                           // Row(
            //                           //   children: [
            //                           //     Container(
            //                           //       width: 11,
            //                           //       height: 11,
            //                           //       decoration: const BoxDecoration(
            //                           //         shape: BoxShape.circle,
            //                           //         gradient: LinearGradient(
            //                           //           colors: [
            //                           //             Color(0xff22c55e),
            //                           //             Color(0xffff4b4b),
            //                           //           ],
            //                           //         ),
            //                           //       ),
            //                           //     ),
            //                           //     const SizedBox(width: 6),
            //                           //     const Text(
            //                           //       "Half day",
            //                           //       style: TextStyle(
            //                           //         fontSize: 13,
            //                           //         fontWeight: FontWeight.w700,
            //                           //       ),
            //                           //     ),
            //                           //   ],
            //                           // ),
            //                         ],
            //                       ),

            //                       const SizedBox(height: 12),

            //                       Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceAround,
            //                         children: [
            //                           Text(
            //                             "$totalPresent",
            //                             style: TextStyle(
            //                               fontSize: 20,
            //                               fontWeight: FontWeight.w900,
            //                             ),
            //                           ),
            //                           Text(
            //                             "$totalAbsent",
            //                             style: TextStyle(
            //                               fontSize: 20,
            //                               fontWeight: FontWeight.w900,
            //                             ),
            //                           ),
            //                           // Text(
            //                           //   "1",
            //                           //   style: TextStyle(
            //                           //     fontSize: 20,
            //                           //     fontWeight: FontWeight.w900,
            //                           //   ),
            //                           // ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),

            //           Positioned(
            //             right: 100,
            //             top: 40,
            //             child: Image.asset(
            //               "assets/images/mask_bg.png",
            //               width: 250,
            //               height: 200,
            //               fit: BoxFit.contain,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       );
            //     }
            //     return const SizedBox();
            //   },
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

  Widget _buildCalendarSection() {
    final ValueNotifier<Map<String, dynamic>?> selectedLeave =
        ValueNotifier<Map<String, dynamic>?>(null);

    // const double cellHeight = 72.0;
    // const double popupHeightOffset = 155.0;

    return ValueListenableBuilder<DateTime>(
      valueListenable: _focusedDay,
      builder: (context, focusedDay, _) {
        return BlocBuilder<AttendenceCubit, AttendenceState>(
          builder: (context, state) {
            Map<String, dynamic> daysMap = {};
            List<dynamic> attendanceDetails = [];
            if (state is AttendenceMonthLoaded) {
              final student = state.data.data?.isNotEmpty == true
                  ? state.data.data!.first
                  : null;

              daysMap = student?.days ?? {};

              /// ✅ CORRECT
              attendanceDetails = state.data.attendanceDetails ?? [];
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
                          // childAspectRatio: 1.5,
                          mainAxisExtent: 78,
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
                              // final currentDate = DateTime(
                              //   focusedDay.year,
                              //   focusedDay.month,
                              //   day,
                              // );

                              // /// WEEKEND CHECK
                              // final isSaturday =
                              //     currentDate.weekday == DateTime.saturday;

                              // final isSunday =
                              //     currentDate.weekday == DateTime.sunday;

                              final isPresent = statusValue == "Present";
                              final isAbsent = statusValue == "Absent";
                              dynamic detail;

                              try {
                                detail = attendanceDetails.firstWhere(
                                  (e) => e.day == day,
                                );
                              } catch (e) {
                                detail = null;
                              }
                              Color bgColor = Colors.white;
                              Color textColor = Colors.black87;

                              if (isAbsent) {
                                bgColor = const Color(0xffef4444);
                                textColor = Colors.white;
                              }

                              return InkWell(
                                onTap: detail != null
                                    ? () {
                                        final columnIndex = index % 7;
                                        final rowIndex = index ~/ 7;

                                        selectedLeave.value = {
                                          "day": day,
                                          "index": index,
                                          "rowIndex": rowIndex,
                                          "columnIndex": columnIndex,
                                          "title": detail.status ?? "",
                                          "date": detail.date ?? "",
                                          "description":
                                              (detail.narration == null ||
                                                  detail.narration
                                                      .toString()
                                                      .trim()
                                                      .isEmpty)
                                              ? "Not mentioned"
                                              : detail.narration,
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

                                      // if (!isPresent &&
                                      //     !isAbsent &&
                                      //     (isSaturday || isSunday))
                                      //   Padding(
                                      //     padding: const EdgeInsets.only(
                                      //       top: 5,
                                      //     ),
                                      //     child: Text(
                                      //       isSunday ? "Sun" : "Sat",
                                      //       style: TextStyle(
                                      //         fontSize: 9,
                                      //         color: Colors.grey.shade600,
                                      //       ),
                                      //     ),
                                      //   ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          // if (leaveData != null)
                          //   Positioned(
                          //     top:
                          //         ((leaveData["rowIndex"] ?? 0) * cellHeight) -
                          //         popupHeightOffset,
                          //     left: 22,
                          //     right: 22,
                          //     child: _leaveDetailsPopup(
                          //       title: leaveData["title"] ?? "Leave",
                          //       date: leaveData["date"] ?? "",
                          //       description: leaveData["description"] ?? "",
                          //       columnIndex: leaveData["columnIndex"] ?? 3,
                          //       onClose: () {
                          //         selectedLeave.value = null;
                          //       },
                          //     ),
                          //   ),
                          if (leaveData != null)
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final cellWidth = constraints.maxWidth / 7;
                                final cellHeight = cellWidth / 0.95;

                                final rowIndex = leaveData["rowIndex"] ?? 0;
                                final popupHeight = 145.0;

                                return Positioned(
                                  top: (rowIndex * cellHeight) - popupHeight,
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
                                );
                              },
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Container(
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
                            "$title (${_formatDate(date)})",
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
                    description.trim().isEmpty ? "Not mentioned" : description,
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

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);

      return "${parsedDate.day.toString().padLeft(2, '0')}-"
          "${parsedDate.month.toString().padLeft(2, '0')}-"
          "${parsedDate.year}";
    } catch (e) {
      return date;
    }
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

// class AttendanceCard extends StatelessWidget {
//   final DateTime date;
//   final String status;
//   final String time;
//   final double progress;
//   final Color color;

//   const AttendanceCard({
//     super.key,
//     required this.date,
//     required this.status,
//     required this.time,
//     required this.progress,
//     required this.color,
//   });

//   String _getWeekDay(int day) {
//     const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
//     return days[day - 1];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.08),
//         borderRadius: BorderRadius.circular(18),
//         border: Border.all(color: color.withOpacity(0.2)),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 65,
//             height: 80,
//             decoration: BoxDecoration(
//               color: color,
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "${date.day}",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   _getWeekDay(date.weekday),
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       status,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: color.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         status,
//                         style: TextStyle(
//                           color: color,
//                           fontSize: 11,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 6),

//                 Row(
//                   children: [
//                     const Icon(Icons.access_time, size: 14, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Text(
//                       time,
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: LinearProgressIndicator(
//                     value: progress,
//                     minHeight: 6,
//                     backgroundColor: Colors.white,
//                     valueColor: AlwaysStoppedAnimation(color),
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     "${(progress * 100).toInt()}%",
//                     style: const TextStyle(fontSize: 11, color: Colors.grey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
