import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<AcademiccalenderCubit>().fetchAcademicCalendar();
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
                      scrollDirection: Axis.horizontal,
                      itemCount: months.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedMonth.value = index;
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
                      return Center(child: Text(state.message));
                    }

                    if (state is AcademiccalenderLoaded) {
                      final events = state.response.data ?? [];

                      // final filteredEvents = events.where((event) {
                      //   if (event.eventDate == null) return false;

                      //   final eventDate = DateTime.parse(event.eventDate!);

                      //   return eventDate.month == selectedMonth.value + 1 &&
                      //       eventDate.year == _focusedDay.value.year;
                      // }).toList();

                      // if (filteredEvents.isEmpty) {
                      //   return const Center(child: Text("No Events Found"));
                      // }

                      return ListView.separated(
                        itemCount: events.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 18),
                        itemBuilder: (context, index) {
                          final event = events[index];
                          final eventDate = DateTime.parse(event.eventDate!);

                          // Color dateColor;
                          // Color typeColor;
                          // Color stripeColor;

                          // switch (event.categoryName?.toLowerCase()) {
                          //   case "public holiday":
                          //     dateColor = Colors.red;
                          //     typeColor = Colors.red;
                          //     stripeColor = Colors.red;
                          //     break;

                          //   case "arts":
                          //     dateColor = Colors.orange;
                          //     typeColor = Colors.orange;
                          //     stripeColor = Colors.orange;
                          //     break;

                          //   case "onam":
                          //     dateColor = Colors.teal;
                          //     typeColor = Colors.green;
                          //     stripeColor = Colors.green;
                          //     break;

                          //   default:
                          //     dateColor = Colors.deepPurple;
                          //     typeColor = Colors.purple;
                          //     stripeColor = Colors.purple;
                          // }
                          Color dateColor;
                          Color typeColor;
                          Color stripeColor;

                          switch (index % 5) {
                            case 0:
                              dateColor = Colors.red;
                              typeColor = Colors.red;
                              stripeColor = Colors.red;
                              break;

                            case 1:
                              dateColor = Colors.orange;
                              typeColor = Colors.orange;
                              stripeColor = Colors.orange;
                              break;

                            case 2:
                              dateColor = Colors.teal;
                              typeColor = Colors.green;
                              stripeColor = Colors.green;
                              break;

                            case 3:
                              dateColor = Colors.deepPurple;
                              typeColor = Colors.purple;
                              stripeColor = Colors.purple;
                              break;

                            default:
                              dateColor = Colors.grey;
                              typeColor = Colors.grey;
                              stripeColor = Colors.transparent;
                          }
                          return CalendarEventTile(
                            date: eventDate.day.toString().padLeft(2, '0'),
                            day: _getDayName(eventDate.weekday),
                            dateColor: dateColor,
                            title: event.eventTitle ?? '',
                            type: event.categoryName ?? '',
                            description: event.eventDescription,
                            typeColor: typeColor,
                            stripeColor: stripeColor,
                            imageUrl: event.image,
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              // Expanded(
              //   child: ListView(
              //     children: const [
              //       CalendarEventTile(
              //         date: "01",
              //         day: "Sun",
              //         dateColor: Colors.red,
              //         title: "National Day",
              //         type: "Holiday",
              //         typeColor: Colors.red,
              //         stripeColor: Colors.red,
              //         imageUrl:
              //             "https://www.vectorstock.com/royalty-free-vectors/cultural-event-vectors",
              //       ),
              //       SizedBox(height: 18),
              //       CalendarEventTile(
              //         date: "02",
              //         day: "Mon",
              //         dateColor: Colors.orange,
              //         title: "First PTA Meeting",
              //         type: "Meeting",
              //         typeColor: Colors.orange,
              //         stripeColor: Colors.orange,
              //       ),
              //       SizedBox(height: 18),
              //       CalendarEventTile(
              //         date: "03",
              //         day: "Thu",
              //         dateColor: Colors.teal,
              //         title: "Environment Day",
              //         type: "Assembly",
              //         typeColor: Colors.green,
              //         stripeColor: Colors.green,
              //       ),
              //       SizedBox(height: 18),
              //       CalendarEventTile(
              //         date: "04",
              //         day: "Wen",
              //         dateColor: Colors.deepPurple,
              //         title: "General Knowlage Quiz",
              //         type: "Event",
              //         typeColor: Colors.purple,
              //         stripeColor: Colors.purple,
              //       ),
              //       SizedBox(height: 18),
              //       CalendarEventTile(
              //         date: "05",
              //         day: "The",
              //         dateColor: Colors.grey,
              //         title: "No Spacial Day",
              //         type: "",
              //         typeColor: Colors.grey,
              //         stripeColor: Colors.transparent,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
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
// class CalendarEventTile extends StatelessWidget {
//   final String date;
//   final String day;
//   final Color dateColor;
//   final String title;
//   final String type;
//   final Color typeColor;
//   final Color stripeColor;
//   final String? imageUrl;

//   const CalendarEventTile({
//     super.key,
//     required this.date,
//     required this.day,
//     required this.dateColor,
//     required this.title,
//     required this.type,
//     required this.typeColor,
//     required this.stripeColor,
//     this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 40,
//           child: Column(
//             children: [
//               Text(
//                 date,
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: dateColor,
//                 ),
//               ),
//               Text(
//                 day,
//                 style: const TextStyle(color: Colors.grey, fontSize: 12),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(width: 12),

//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: const Color(0xffF3F3F3),
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 3,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: stripeColor,
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),

//                 const SizedBox(width: 10),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),

//                       if (type.isNotEmpty) ...[
//                         const SizedBox(height: 6),
//                         Row(
//                           children: [
//                             Icon(Icons.circle, size: 8, color: typeColor),
//                             const SizedBox(width: 4),
//                             Text(
//                               type,
//                               style: TextStyle(color: typeColor, fontSize: 11),
//                             ),
//                           ],
//                         ),
//                       ],

//                       const SizedBox(height: 8),

//                       const Text(
//                         "Discussion Between Parents And Teachers On Student Progress, Performance, Attendance, Behavior And Overall Development.",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                           height: 1.4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (title == "National Day")
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: GestureDetector(
//                       onTap: () {
//                         showGeneralDialog(
//                           context: context,
//                           barrierDismissible: true,
//                           barrierLabel: "",
//                           barrierColor: Colors.black54,
//                           pageBuilder: (_, __, ___) {
//                             return Stack(
//                               children: [
//                                 Positioned(
//                                   top: 180, // adjust
//                                   left: 60, // adjust
//                                   child: Material(
//                                     color: Colors.transparent,
//                                     child: Stack(
//                                       clipBehavior: Clip.none,
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius: BorderRadius.circular(
//                                             12,
//                                           ),
//                                           child: Image.network(
//                                             "https://picsum.photos/200",
//                                             width: 250,
//                                             height: 200,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         ),

//                                         Positioned(
//                                           top: -8,
//                                           right: -8,
//                                           child: InkWell(
//                                             onTap: () => Navigator.pop(context),
//                                             child: Container(
//                                               padding: const EdgeInsets.all(4),
//                                               decoration: const BoxDecoration(
//                                                 color: Colors.white,
//                                                 shape: BoxShape.circle,
//                                               ),
//                                               child: const Icon(
//                                                 Icons.close,
//                                                 size: 18,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                         // return Dialog(
//                         //   backgroundColor: Colors.transparent,
//                         //   child: Stack(
//                         //     clipBehavior: Clip.none,
//                         //     children: [
//                         //       ClipRRect(
//                         //         borderRadius: BorderRadius.circular(12),
//                         //         child: Image.network(
//                         //           "https://picsum.photos/200",
//                         //           fit: BoxFit.contain,
//                         //         ),
//                         //       ),

//                         //       Positioned(
//                         //         top: -10,
//                         //         right: -10,
//                         //         child: InkWell(
//                         //           onTap: () => Navigator.pop(context),
//                         //           child: Container(
//                         //             padding: const EdgeInsets.all(4),
//                         //             decoration: const BoxDecoration(
//                         //               color: Colors.white,
//                         //               shape: BoxShape.circle,
//                         //             ),
//                         //             child: const Icon(
//                         //               Icons.close,
//                         //               size: 18,
//                         //             ),
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // );
//                       },

//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           "https://picsum.photos/200",
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                 // if (title == "National Day")
//                 //   Padding(
//                 //     padding: const EdgeInsets.only(left: 8),
//                 //     child: ClipRRect(
//                 //       borderRadius: BorderRadius.circular(8),
//                 //       child: Image.network(
//                 //         "https://picsum.photos/200",
//                 //         width: 80,
//                 //         height: 80,
//                 //         fit: BoxFit.cover,
//                 //       ),
//                 //     ),
//                 //   ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
