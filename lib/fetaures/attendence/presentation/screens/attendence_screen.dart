import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
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
        /// ✅ trigger API before going back
        context.read<AttendenceCubit>().getAttendanceReportByDate(
          AttendanceReportByDateParameter(
            admno: "PKG7",
            date: "2026-04-04",
            accYear: "2026-2027",
            branchId: 1,
          ),
        );

        return true; // allow back
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: const Text(
            'Attendance Report',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            ValueListenableBuilder<DateTime>(
              valueListenable: _focusedDay,
              builder: (context, focusedDay, _) {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      color: Colors.black,
                      onPressed: () => _changeMonth(-1),
                    ),
                    Text(
                      "${_getMonthName(focusedDay.month)} ${focusedDay.year}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      color: Colors.black,
                      onPressed: () => _changeMonth(1),
                    ),
                  ],
                );
              },
            ),
          ],
        ),

        body: BlocBuilder<AttendenceCubit, AttendenceState>(
          builder: (context, state) {
            if (state is AttendenceMonthLoading) {
              return const Center(child: CircularProgressIndicator());
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

              return ListView.builder(
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
                  /// ✅ PAST BUT NOT MARKED
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
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}

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
