// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
// import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
// import 'package:studentmanagement/fetaures/materials/presentation/widgets/materials_widget.dart';

// final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
//   'Mathematics',
// );

// final ValueNotifier<int?> expandedIndexNotifier = ValueNotifier<int?>(null);

// class AllClassDiaryScreen extends StatelessWidget {
//   const AllClassDiaryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<DiaryCubit>().fetchDiary(
//         FetchDiaryParameter(
//           admNo: AppData.admissionNo!,
//           accYear: AppData.accYear!,
//         ),
//       );
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Class Diary',
//           style: TextStyle(
//             color: Color(0xFF202020),
//             fontSize: 17,
//             fontWeight: FontWeight.w800,
//           ),
//         ),
//         // actions: [
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 20.0),
//         //     child: Container(
//         //       height: 40,
//         //       width: 40,
//         //       decoration: BoxDecoration(
//         //         color: const Color.fromARGB(255, 208, 205, 205),
//         //         borderRadius: BorderRadius.circular(30),
//         //       ),
//         //       child: PopupMenuButton(
//         //         icon: const Icon(Icons.filter_list),
//         //         shape: RoundedRectangleBorder(
//         //           borderRadius: BorderRadius.circular(16),
//         //         ),
//         //         itemBuilder: (context) => [
//         //           PopupMenuItem(
//         //             enabled: false,
//         //             child: SizedBox(
//         //               width: 220,
//         //               child: ValueListenableBuilder<String>(
//         //                 valueListenable: selectedSubject,
//         //                 builder: (_, value, __) {
//         //                   return Column(
//         //                     mainAxisSize: MainAxisSize.min,
//         //                     children: [
//         //                       radioItem(context, 'Mathematics', value),
//         //                       radioItem(context, 'Malayalam', value),
//         //                       radioItem(context, 'Physics', value),
//         //                       radioItem(context, 'Chemistry', value),
//         //                       radioItem(context, 'Biology', value),
//         //                     ],
//         //                   );
//         //                 },
//         //               ),
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // ],
//       ),
//       body: BlocBuilder<DiaryCubit, DiaryState>(
//         builder: (context, state) {
//           if (state is DiaryLoading) {
//             return AllClassDiarySkeleton();
//           }

//           if (state is DiaryError) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             );
//           }
//           if (state is DiaryLoaded) {
//             final diaryList = state.response.data ?? [];
//             if (diaryList.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No Diary',
//                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                 ),
//               );
//             }
//             return ListView.separated(
//               padding: const EdgeInsets.all(16),
//               itemCount: diaryList.length,
//               separatorBuilder: (context, index) => const SizedBox(height: 10),
//               itemBuilder: (context, index) {
//                 final diary = diaryList[index];
//                 String desc = diary.description ?? '';
//                 String st_diaryHead = desc.length > 8
//                     ? desc.substring(0, 8)
//                     : desc;
//                 st_diaryHead = st_diaryHead + '...';
//                 return ValueListenableBuilder<int?>(
//                   valueListenable: expandedIndexNotifier,
//                   builder: (_, expandedIndex, __) {
//                     final isExpanded = expandedIndex == index;

//                     return Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF8F8F9),
//                         borderRadius: BorderRadius.circular(14),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.08),
//                             blurRadius: 16,
//                             offset: const Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ListTile(
//                             onTap: () {
//                               expandedIndexNotifier.value = isExpanded
//                                   ? null
//                                   : index;
//                             },
//                             title: Text(
//                               diary.diaryTitle ?? "",
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             subtitle: isExpanded
//                                 ? null
//                                 : Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Text(st_diaryHead),
//                                   ),
//                             trailing: Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Column(
//                                 children: [
//                                   Text(diary.diaryDate!),
//                                   const SizedBox(height: 10),
//                                   InkWell(
//                                     onTap: () {
//                                       expandedIndexNotifier.value = isExpanded
//                                           ? null
//                                           : index;
//                                     },
//                                     child: Icon(
//                                       isExpanded
//                                           ? Icons.keyboard_arrow_down
//                                           : Icons.arrow_forward_ios,
//                                       size: 18,
//                                       color: const Color(0xFFC4005F),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           if (isExpanded)
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 10,
//                                 left: 16,
//                                 right: 16,
//                               ),
//                               child: Text(
//                                 diary.description!,
//                                 style: const TextStyle(color: Colors.black87),
//                               ),
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }
//           return Container(child: Text('No Diary'));
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

final ValueNotifier<int?> expandedIndexNotifier = ValueNotifier<int?>(null);

class AllClassDiaryScreen extends StatelessWidget {
  const AllClassDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiaryCubit>().fetchDiary(
        FetchDiaryParameter(
          admNo: AppData.admissionNo!,
          accYear: AppData.accYear!,
        ),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFAF8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF8FF),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: const Text(
          'Class Diary',
          style: TextStyle(
            color: Color(0xFF202020),
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: BlocBuilder<DiaryCubit, DiaryState>(
        builder: (context, state) {
          if (state is DiaryLoading) {
            return AllClassDiarySkeleton();
          }

          if (state is DiaryError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is DiaryLoaded) {
            final diaryList = state.response.data ?? [];

            if (diaryList.isEmpty) {
              return const Center(
                child: Text(
                  'No Diary',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
              itemCount: diaryList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 22),
              itemBuilder: (context, index) {
                final diary = diaryList[index];

                return _DiaryCard(
                  index: index,
                  teacherName: 'Sandra P 🔥',
                  teacherRole: 'Chemistry Teacher',
                  title: diary.diaryTitle ?? 'Announcement',
                  description: diary.description ?? '',
                  date: diary.diaryDate ?? 'Today',
                );
              },
            );
          }

          return const Center(child: Text('No Diary'));
        },
      ),
    );
  }
}

class _DiaryCard extends StatelessWidget {
  final int index;
  final String teacherName;
  final String teacherRole;
  final String title;
  final String description;
  final String date;

  const _DiaryCard({
    required this.index,
    required this.teacherName,
    required this.teacherRole,
    required this.title,
    required this.description,
    required this.date,
  });

  Color get mainColor {
    final colors = [
      const Color(0xFFE9AFD4),
      const Color(0xFFBBB3CA),
      const Color(0xFFFFDB6E),
      const Color(0xFFE9AFD4),
      const Color(0xFFBBB3CA),
    ];

    return colors[index % colors.length];
  }

  Color get bodyColor {
    final colors = [
      const Color(0xFFFFD7F0),
      const Color(0xFFE5D9FA),
      const Color(0xFFFFEFBF),
      const Color(0xFFFFD7F0),
      const Color(0xFFE5D9FA),
    ];

    return colors[index % colors.length];
  }

  String get avatarImage {
    final images = [
      'https://i.pravatar.cc/100?img=12',
      'https://i.pravatar.cc/100?img=47',
      'https://i.pravatar.cc/100?img=12',
      'https://i.pravatar.cc/100?img=47',
    ];
    return images[index % images.length];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: expandedIndexNotifier,
      builder: (_, expandedIndex, __) {
        final isExpanded = expandedIndex == index;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(avatarImage),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacherName,
                      style: const TextStyle(
                        color: Color(0xFF202020),
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      teacherRole,
                      style: const TextStyle(
                        color: Color(0xFF444444),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: () {
                expandedIndexNotifier.value = isExpanded ? null : index;
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 14, 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Announcement',
                              style: const TextStyle(
                                color: Color(0xFF171717),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.42),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              date.isEmpty ? 'Today' : 'Today',
                              style: const TextStyle(
                                color: Color(0xFF151515),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container(
                    //   width: double.infinity,
                    //   padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                    //   decoration: BoxDecoration(
                    //     color: bodyColor,
                    //     borderRadius: const BorderRadius.only(
                    //       topLeft: Radius.circular(22),
                    //       topRight: Radius.circular(22),
                    //       bottomLeft: Radius.circular(18),
                    //       bottomRight: Radius.circular(18),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     description.isEmpty ? 'No Description' : description,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //     style: const TextStyle(
                    //       color: Color(0xFF222222),
                    //       fontSize: 12,
                    //       height: 1.7,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    // ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                      decoration: BoxDecoration(
                        color: bodyColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                          bottomLeft: Radius.circular(18),
                          bottomRight: Radius.circular(18),
                        ),
                      ),
                      child: Text(
                        description.isEmpty ? 'No Description' : description,
                        maxLines: isExpanded ? null : 2, // 👈 KEY CHANGE
                        overflow: isExpanded
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF222222),
                          fontSize: 12,
                          height: 1.7,
                          fontWeight: FontWeight.w500,
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
  }
}

class AllClassDiarySkeleton extends StatelessWidget {
  const AllClassDiarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(26), // same as real UI
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(14), // same as UI
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F9),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 LEFT SIDE (Title + Subtitle)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 8),

                        /// Subtitle (short preview)
                        Container(height: 14, width: 120, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// 🔹 RIGHT SIDE (Date + Arrow)
                Column(
                  children: [
                    Container(height: 14, width: 60, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
