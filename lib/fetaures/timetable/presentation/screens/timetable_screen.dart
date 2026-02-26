import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/cubit/timetable_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({super.key});

  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _selectedDay = ValueNotifier(DateTime.now());
  String _getWeekDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return "Monday";
      case DateTime.tuesday:
        return "Tuesday";
      case DateTime.wednesday:
        return "Wednesday";
      case DateTime.thursday:
        return "Thursday";
      case DateTime.friday:
        return "Friday";
      case DateTime.saturday:
        return "Saturday";
      case DateTime.sunday:
        return "Sunday";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Time Table',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        actions: const [
          Icon(Icons.chevron_left, color: Colors.black),
          SizedBox(width: 6),
          Text(
            "2025",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          SizedBox(width: 6),
          Icon(Icons.chevron_right, color: Colors.black),
          SizedBox(width: 12),
        ],
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ================= WEEK CALENDAR =================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ValueListenableBuilder<DateTime>(
                  valueListenable: _selectedDay,
                  builder: (_, selectedDay, __) {
                    return TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2035, 12, 31),
                      focusedDay: _focusedDay.value,

                      calendarFormat: CalendarFormat.week,
                      headerVisible: false,
                      daysOfWeekHeight: 24,
                      rowHeight: 64,

                      selectedDayPredicate: (day) =>
                          isSameDay(selectedDay, day),

                      onDaySelected: (day, focused) {
                        _selectedDay.value = day;
                        _focusedDay.value =
                            focused; // Call API when date changes
                        context.read<TimetableCubit>().fetchTimeTable(
                          FetchTimeTableParameter(
                            accYear: "2025-2026",
                            standardId: 3,
                            divisionId: 1,
                            branchId: 1,
                          ),
                        );
                      },

                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                        weekendStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        selectedDecoration: BoxDecoration(
                          color: const Color(0xFFC4005F),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        defaultDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        weekendDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        todayTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        defaultTextStyle: const TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ================= PERIOD LIST =================
            BlocBuilder<TimetableCubit, TimetableState>(
              builder: (context, state) {
                if (state is TimetableLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }

                if (state is TimetableError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(child: Text(state.message)),
                    ),
                  );
                }
                if (state is TimetableLoaded) {
                  final selectedDayName = _getWeekDayName(_selectedDay.value);

                  /// 🔥 FILTER DATA BASED ON DAY
                  final filteredList = state.response.data!
                      .where((item) => item.dayName == selectedDayName)
                      .toList();

                  if (filteredList.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text("No Timetable Available")),
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = filteredList[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _PeriodRow(
                            item: _PeriodItem(
                              item.periodNo ?? '',
                              item.subjectName ?? "No Subject",
                              _getLineColor(index),
                            ),
                          ),
                        );
                      }, childCount: filteredList.length),
                    ),
                  );
                }
                return const SliverToBoxAdapter();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= PERIOD ROW =================
class _PeriodRow extends StatelessWidget {
  final _PeriodItem item;

  const _PeriodRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 52,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.no,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Text(
                "Period",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Container(
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  decoration: BoxDecoration(
                    color: item.lineColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.subject,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // Text(
                //   item.time,
                //   style: const TextStyle(
                //     fontSize: 11,
                //     color: Colors.black54,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================= MODEL =================
class _PeriodItem {
  final String no;
  final String subject;
  //final String time;
  final Color lineColor;

  const _PeriodItem(this.no, this.subject, this.lineColor);
}

Color _getLineColor(int index) {
  final colors = [
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  return colors[index % colors.length];
}
