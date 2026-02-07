import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class TimeTableScreen extends StatelessWidget {
  TimeTableScreen({super.key});

  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> _selectedDay = ValueNotifier(DateTime.now());

  final periods = const [
    _PeriodItem(1, "Malayalam", "09:00 To 10:00", Color(0xFFFFE9A6)),
    _PeriodItem(2, "Hindi", "10:00 To 11:00", Color(0xFFB7F19A)),
    _PeriodItem(3, "Mathematics", "12:00 To 13:00", Color(0xFF9BD6FF)),
    _PeriodItem(4, "Biology", "01:00 To 02:00", Color(0xFFBDB2FF)),
    _PeriodItem(5, "Physics", "02:00 To 03:00", Color(0xFFBDB2FF)),
    _PeriodItem(6, "Chemistry", "03:00 To 04:00", Color(0xFFFFB2E6)),
  ];

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
                        _focusedDay.value = focused;
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
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _PeriodRow(item: periods[index]),
                  ),
                  childCount: periods.length,
                ),
              ),
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
                "${item.no}",
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
                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
  final int no;
  final String subject;
  final String time;
  final Color lineColor;

  const _PeriodItem(this.no, this.subject, this.time, this.lineColor);
}
