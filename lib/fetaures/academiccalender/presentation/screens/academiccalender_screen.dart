import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';
import 'package:studentmanagement/fetaures/academiccalender/presentation/cubit/academiccalender_cubit.dart';

class AcademicCalendarScreen extends StatefulWidget {
  const AcademicCalendarScreen({super.key});
  @override
  State<AcademicCalendarScreen> createState() => _AcademicCalendarScreenState();

  static Widget _monthChip(String month, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        height: 35,
        width: 50,
        decoration: BoxDecoration(
          color: selected ? const Color(0xff807FD8) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? const Color(0xff807FD8) : Colors.grey.shade300,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          month,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _AcademicCalendarScreenState extends State<AcademicCalendarScreen> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());

  final ValueNotifier<int> selectedMonth = ValueNotifier(
    DateTime.now().month - 1,
  );
  final ScrollController _monthScrollController = ScrollController();
  final months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  @override
  void initState() {
    super.initState();

    context.read<AcademiccalenderCubit>().fetchAcademicCalendar(
      FetchCalendarParameter(
        accYear: AppData.accYear!,
        branchId: 1,
        admno: AppData.admissionNo!,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerSelectedMonth(selectedMonth.value, jump: true);
    });
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    selectedMonth.dispose();
    _monthScrollController.dispose();
    super.dispose();
  }

  void _centerSelectedMonth(int index, {bool jump = false}) {
    if (!_monthScrollController.hasClients) return;

    const double itemWidth = 62;

    final screenWidth = MediaQuery.of(context).size.width;

    final targetOffset =
        (index * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    final maxOffset = _monthScrollController.position.maxScrollExtent;

    final safeOffset = targetOffset.clamp(0.0, maxOffset);

    if (jump) {
      _monthScrollController.jumpTo(safeOffset);
    } else {
      _monthScrollController.animateTo(
        safeOffset,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _changeYear(int offset) {
    final focusedDay = _focusedDay.value;

    _focusedDay.value = DateTime(
      focusedDay.year + offset,
      focusedDay.month,
      focusedDay.day,
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return "Mon";
      case DateTime.tuesday:
        return "Tue";
      case DateTime.wednesday:
        return "Wed";
      case DateTime.thursday:
        return "Thu";
      case DateTime.friday:
        return "Fri";
      case DateTime.saturday:
        return "Sat";
      case DateTime.sunday:
        return "Sun";
      default:
        return "";
    }
  }

  DateTime? _parseEventDate(String? date) {
    if (date == null || date.trim().isEmpty) return null;

    try {
      return DateTime.parse(date);
    } catch (e) {
      debugPrint("ACADEMIC CALENDAR DATE PARSE ERROR: $e");
      return null;
    }
  }

  _EventColors _getEventColors({
    required String? categoryName,
    required String? isHoliday,
  }) {
    final category = (categoryName ?? '').toLowerCase().trim();
    final holiday = (isHoliday ?? '').toLowerCase().trim();

    if (holiday == 'yes' || category.contains('holiday')) {
      return const _EventColors(
        dateColor: Color(0xffF04438),
        typeColor: Color(0xffF04438),
        stripeColor: Color(0xffF04438),
      );
    }

    if (category.contains('meeting') || category.contains('pta')) {
      return const _EventColors(
        dateColor: Color(0xffD99A20),
        typeColor: Color(0xffD99A20),
        stripeColor: Color(0xffD99A20),
      );
    }

    if (category.contains('special') ||
        category.contains('special day') ||
        category.contains('special days') ||
        category.contains('onam') ||
        category.contains('environment')) {
      return const _EventColors(
        dateColor: Color(0xff3A9670),
        typeColor: Color(0xff3A9670),
        stripeColor: Color(0xff3A9670),
      );
    }

    if (category.contains('event') ||
        category.contains('events') ||
        category.contains('arts') ||
        category.contains('quiz') ||
        category.contains('assembly')) {
      return const _EventColors(
        dateColor: Color(0xff5B5CE2),
        typeColor: Color(0xff5B5CE2),
        stripeColor: Color(0xff5B5CE2),
      );
    }

    return const _EventColors(
      dateColor: Color(0xff777777),
      typeColor: Color(0xff777777),
      stripeColor: Color(0xffD8D8D8),
    );
  }

  Future<void> _refreshCalendar() async {
    await context.read<AcademiccalenderCubit>().fetchAcademicCalendar(
      FetchCalendarParameter(
        accYear: AppData.accYear!,
        branchId: 1,
        admno: AppData.admissionNo!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Academic Calender',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
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
                    onPressed: () => _changeYear(-1),
                  ),
                  Text(
                    "${focusedDay.year}",
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
                    onPressed: () => _changeYear(1),
                  ),
                  const SizedBox(width: 6),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),

              SizedBox(
                height: 40,
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedMonth,
                  builder: (context, selected, _) {
                    return ListView.builder(
                      controller: _monthScrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: months.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedMonth.value = index;
                            _centerSelectedMonth(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AcademicCalendarScreen._monthChip(
                              months[index],
                              selected == index,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Expanded(
                child: BlocBuilder<AcademiccalenderCubit, AcademiccalenderState>(
                  builder: (context, state) {
                    if (state is AcademiccalenderLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AcademiccalenderError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    if (state is AcademiccalenderLoaded) {
                      final monthList = state.response.data ?? [];

                      return ValueListenableBuilder<DateTime>(
                        valueListenable: _focusedDay,
                        builder: (context, focusedDay, _) {
                          return ValueListenableBuilder<int>(
                            valueListenable: selectedMonth,
                            builder: (context, selected, _) {
                              final selectedMonthNo = selected + 1;

                              final selectedMonthData = monthList.where((
                                monthData,
                              ) {
                                return monthData.monthNo == selectedMonthNo;
                              }).toList();

                              final events = selectedMonthData.isNotEmpty
                                  ? selectedMonthData.first.events ?? []
                                  : [];

                              final filteredEvents = events.where((event) {
                                final eventDate = _parseEventDate(
                                  event.eventDate,
                                );

                                if (eventDate == null) return false;

                                return eventDate.month == selectedMonthNo &&
                                    eventDate.year == focusedDay.year;
                              }).toList();

                              filteredEvents.sort((a, b) {
                                final aDate = _parseEventDate(a.eventDate);
                                final bDate = _parseEventDate(b.eventDate);

                                if (aDate == null && bDate == null) return 0;
                                if (aDate == null) return 1;
                                if (bDate == null) return -1;

                                return aDate.compareTo(bDate);
                              });

                              if (filteredEvents.isEmpty) {
                                return RefreshIndicator(
                                  onRefresh: _refreshCalendar,
                                  child: ListView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.45,
                                        child: Center(
                                          child: Text(
                                            "No Events Found In ${months[selected]} ${focusedDay.year}",
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: _refreshCalendar,
                                child: ListView.separated(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: filteredEvents.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 18),
                                  itemBuilder: (context, index) {
                                    final event = filteredEvents[index];

                                    final eventDate = _parseEventDate(
                                      event.eventDate,
                                    );

                                    if (eventDate == null) {
                                      return const SizedBox.shrink();
                                    }

                                    final colors = _getEventColors(
                                      categoryName: event.categoryName,
                                      isHoliday: event.isHoliday,
                                    );

                                    return CalendarEventTile(
                                      date: eventDate.day.toString().padLeft(
                                        2,
                                        '0',
                                      ),
                                      day: _getDayName(eventDate.weekday),
                                      dateColor: colors.dateColor,
                                      title: event.eventTitle ?? '',
                                      type: event.categoryName ?? '',
                                      description: event.eventDescription,
                                      typeColor: colors.typeColor,
                                      stripeColor: colors.stripeColor,
                                      imageUrl: event.image,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventColors {
  final Color dateColor;
  final Color typeColor;
  final Color stripeColor;

  const _EventColors({
    required this.dateColor,
    required this.typeColor,
    required this.stripeColor,
  });
}

class CalendarEventTile extends StatelessWidget {
  final String date;
  final String day;
  final Color dateColor;
  final String title;
  final String type;
  final String? description;
  final Color typeColor;
  final Color stripeColor;
  final String? imageUrl;

  const CalendarEventTile({
    super.key,
    required this.date,
    required this.day,
    required this.dateColor,
    required this.title,
    required this.type,
    this.description,
    required this.typeColor,
    required this.stripeColor,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 40,
          child: Column(
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: dateColor,
                ),
              ),
              Text(
                day,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 3,
                  height: 100,
                  decoration: BoxDecoration(
                    color: stripeColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      if (type.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 8, color: typeColor),
                            const SizedBox(width: 4),
                            Text(
                              type,
                              style: TextStyle(color: typeColor, fontSize: 11),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 8),

                      Text(
                        (description != null && description!.trim().isNotEmpty)
                            ? description!
                            : "No Description",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                if (imageUrl != null && imageUrl!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: GestureDetector(
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "",
                          barrierColor: Colors.black54,
                          pageBuilder: (_, __, ___) {
                            return Stack(
                              children: [
                                Positioned(
                                  top: 180,
                                  left: 60,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.network(
                                            imageUrl!,
                                            width: 250,
                                            height: 200,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                const SizedBox.shrink(),
                                          ),
                                        ),

                                        Positioned(
                                          top: -8,
                                          right: -8,
                                          child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
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
