import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/fees/presentation/widgets/pendingfee_skeleton.dart';
import 'package:studentmanagement/fetaures/timetable/domain/entities/fetch_timetable_entity.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/cubit/timetable_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  final DateTime _today = DateTime.now();
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime?> _selectedDay = ValueNotifier(DateTime.now());
  List<FetchTimeTableDetails> loadedList = [];
  @override
  void initState() {
    super.initState();
    Future.microtask(_fetchTimetable);
  }

  void _fetchTimetable() {
    context.read<TimetableCubit>().fetchTimeTable(
      FetchTimeTableParameter(
        accYear: AppData.accYear!,
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
        branchId: 1,
      ),
    );
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  String _getWeekDayName(DateTime date) {
    const days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    return days[date.weekday - 1];
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

    final isCurrentMonth =
        changedMonth.year == _today.year && changedMonth.month == _today.month;

    _selectedDay.value = isCurrentMonth ? _today : changedMonth;
  }

  Widget _calendarDayItem(DateTime day, bool isSelected) {
    final weekDays = ['M', 'Tu', 'W', 'Th', 'F', 'S', 'Su'];
    final dayName = weekDays[day.weekday - 1];

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 38,
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8D8BE8) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '${day.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isSelected ? Colors.white : const Color(0xFF555555),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleSpacing: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: ValueListenableBuilder<DateTime>(
        valueListenable: _focusedDay,
        builder: (context, focusedDay, _) {
          return Text(
            "${_getMonthName(focusedDay.month)} Time Table",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          );
        },
      ),
      actions: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, focusedDay, _) {
            return Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 22,
                  ),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  "${_getMonthName(focusedDay.month).substring(0, 3).toUpperCase()} ${focusedDay.year}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 22,
                  ),
                  onPressed: () => _changeMonth(1),
                ),
                const SizedBox(width: 6),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return ValueListenableBuilder<DateTime?>(
      valueListenable: _selectedDay,
      builder: (_, selectedDay, __) {
        return ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (_, focusedDay, __) {
            return Container(
              width: double.infinity,
              color: const Color(0xFFF0EEFF),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2035, 12, 31),
                focusedDay: focusedDay,
                calendarFormat: CalendarFormat.week,
                headerVisible: false,
                daysOfWeekVisible: false,
                rowHeight: 64,
                availableGestures: AvailableGestures.horizontalSwipe,
                selectedDayPredicate: (day) =>
                    selectedDay != null && isSameDay(selectedDay, day),
                onDaySelected: (day, focused) {
                  _selectedDay.value = day;
                  _focusedDay.value = focused;
                  setState(() {});
                  //_fetchTimetable();
                },
                onPageChanged: (focusedDay) {
                  _focusedDay.value = focusedDay;
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: true,
                  cellMargin: EdgeInsets.zero,
                  cellPadding: EdgeInsets.zero,
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    return _calendarDayItem(day, false);
                  },
                  todayBuilder: (context, day, focusedDay) {
                    final isSelected =
                        selectedDay != null && isSameDay(selectedDay, day);
                    return _calendarDayItem(day, isSelected);
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return _calendarDayItem(day, true);
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    return _calendarDayItem(day, false);
                  },
                  disabledBuilder: (context, day, focusedDay) {
                    return _calendarDayItem(day, false);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity == null) return;

            if (details.primaryVelocity! < 0) {
              // swipe left → next day
              _changeDay(1);
            } else if (details.primaryVelocity! > 0) {
              // swipe right → previous day
              _changeDay(-1);
            }
          },
          child: Column(
            children: [
              _buildCalendar(),

              const SizedBox(height: 18),

              Expanded(
                child: BlocBuilder<TimetableCubit, TimetableState>(
                  builder: (context, state) {
                    if (state is TimetableLoaded) {
                      loadedList = state.response.data ?? [];
                    }
                    return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // SliverToBoxAdapter(child: _buildCalendar()),

                        // const SliverToBoxAdapter(child: SizedBox(height: 18)),
                        if (state is TimetableLoading)
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) => const Padding(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: PendingFeeShimmer(),
                                ),
                                childCount: 6,
                              ),
                            ),
                          ),

                        if (state is TimetableError)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Center(child: Text(state.message)),
                            ),
                          ),
                        if (state is TimetableLoaded || loadedList.isNotEmpty)
                          _buildTimetableList(),
                        // if (state is TimetableLoaded) _buildTimetableList(state),
                        // if (state is DaySelectionChanged)
                        //   _buildTimetableDaySelectedList(state),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeDay(int offset) {
    final current = _selectedDay.value ?? _focusedDay.value;

    final changedDay = current.add(Duration(days: offset));

    _selectedDay.value = changedDay;
    _focusedDay.value = changedDay;

    // _fetchTimetable();
    setState(() {});
  }

  Widget _buildTimetableList() {
    final dayForFilter = _selectedDay.value ?? _focusedDay.value;
    final selectedDayName = _getWeekDayName(dayForFilter);

    // final filteredList = state.response.data!
    //     .where((item) => item.dayName == selectedDayName)
    //     .toList();
    // loadedList?.clear();
    // loadedList = state.response.data!;
    final filteredList = loadedList
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

  //   Widget _buildTimetableDaySelectedList(DaySelectionChanged state) {
  //     final dayForFilter = _selectedDay.value ?? _focusedDay.value;
  //     final selectedDayName = _getWeekDayName(dayForFilter);
  //     print('loadedList ${loadedList}');

  //     final filteredList = loadedList!
  //         .where((item) => item.dayName == selectedDayName)
  //         .toList();

  //     if (filteredList.isEmpty) {
  //       return const SliverToBoxAdapter(
  //         child: Padding(
  //           padding: EdgeInsets.all(20),
  //           child: Center(child: Text("No Timetable Available")),
  //         ),
  //       );
  //     }

  //     return SliverPadding(
  //       padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
  //       sliver: SliverList(
  //         delegate: SliverChildBuilderDelegate((context, index) {
  //           final item = filteredList[index];

  //           return Padding(
  //             padding: const EdgeInsets.only(bottom: 12, top: 12),
  //             child: _PeriodRow(
  //               item: _PeriodItem(
  //                 item.periodNo ?? '',
  //                 item.subjectName ?? "No Subject",
  //                 _getLineColor(index),
  //               ),
  //             ),
  //           );
  //         }, childCount: filteredList.length),
  //       ),
  //     );
  //   }
  // }
}

class _PeriodRowSkeleton extends StatelessWidget {
  const _PeriodRowSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 20, width: 30, color: Colors.white),
                const SizedBox(height: 6),
                Container(height: 12, width: 40, color: Colors.white),
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
              ),
              child: Row(
                children: [
                  Container(width: 4, height: 50, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(child: Container(height: 14, color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PeriodRow extends StatelessWidget {
  final _PeriodItem item;

  const _PeriodRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final periodNumber = item.no.isEmpty ? '-' : item.no;

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 90,
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
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 4,
                    decoration: BoxDecoration(
                      color: item.lineColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 14),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: item.lineColor.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Per',
                              style: TextStyle(
                                color: item.lineColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              periodNumber,
                              style: TextStyle(
                                color: item.lineColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.subject,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF222222),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PeriodItem {
  final String no;
  final String subject;
  final Color lineColor;

  const _PeriodItem(this.no, this.subject, this.lineColor);
}

Color _getLineColor(int index) {
  final colors = [
    Color(0xFF8E8FFA),
    Color(0xFF67C47D),
    Color(0xFF4B6AE8),
    Color(0xFFFFA94E),
    Color(0xFFFF6B6B),
  ];

  return colors[index % colors.length];
}
