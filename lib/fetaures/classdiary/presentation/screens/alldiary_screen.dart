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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/entities/fetch_diary_entity.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

final ValueNotifier<int?> expandedIndexNotifier = ValueNotifier<int?>(null);

class AllClassDiaryScreen extends StatefulWidget {
  const AllClassDiaryScreen({super.key});

  @override
  State<AllClassDiaryScreen> createState() => _AllClassDiaryScreenState();
}

class _AllClassDiaryScreenState extends State<AllClassDiaryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiaryCubit>().fetchDiary(
      FetchDiaryParameter(
        admNo: AppData.admissionNo!,
        accYear: AppData.accYear!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<DiaryCubit>().fetchDiary(
    //     FetchDiaryParameter(
    //       admNo: AppData.admissionNo!,
    //       accYear: AppData.accYear!,
    //     ),
    //   );
    // });
    // debugPrint("API CALLED");
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
      body: SafeArea(
        child: BlocBuilder<DiaryCubit, DiaryState>(
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
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 22),
                itemBuilder: (context, index) {
                  final diary = diaryList[index];

                  return _DiaryCard(
                    index: index,
                    teacherName: '${diary.name}',
                    teacherRole: diary.employeeName != null
                        ? '${diary.employeeName}'
                        : '',
                    title: diary.diaryTitle ?? 'Announcement',
                    description: diary.description ?? '',
                    date: diary.diaryDate ?? 'Today',
                    files: diary.files ?? [],
                    employeePhoto: diary.employeePhoto,
                  );
                },
              );
            }

            return const Center(child: Text('No Diary'));
          },
        ),
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
  final List<DiaryFileEntity> files;
  final String? employeePhoto;

  const _DiaryCard({
    required this.index,
    required this.teacherName,
    required this.teacherRole,
    required this.title,
    required this.description,
    required this.date,
    required this.files,
    required this.employeePhoto,
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

  // String get avatarImage {
  //   final images = [
  //     'https://i.pravatar.cc/100?img=12',
  //     'https://i.pravatar.cc/100?img=47',
  //     'https://i.pravatar.cc/100?img=12',
  //     'https://i.pravatar.cc/100?img=47',
  //   ];
  //   return images[index % images.length];
  // }

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
                  backgroundImage:
                      employeePhoto != null && employeePhoto!.isNotEmpty
                      ? NetworkImage(employeePhoto!)
                      : null,
                  child: employeePhoto == null || employeePhoto!.isEmpty
                      ? const Icon(Icons.person)
                      : null,
                ),
                // CircleAvatar(
                //   radius: 22,
                //   backgroundImage: NetworkImage(avatarImage),
                // ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          teacherName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.push_pin, size: 18, color: Colors.red),
                      ],
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
                              title,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description.isEmpty
                                ? 'No Description'
                                : description,
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

                          //       /// SHOW FILES ONLY WHEN EXPANDED
                          //       if (isExpanded && files.isNotEmpty) ...[
                          //         const SizedBox(height: 14),

                          //         Wrap(
                          //           spacing: 10,
                          //           runSpacing: 10,
                          //           children: files.map((file) {
                          //             final url = file.url ?? '';
                          //             final type = (file.type ?? '').toLowerCase();

                          //             final isImage =
                          //                 type.contains('image') ||
                          //                 url.endsWith('.png') ||
                          //                 url.endsWith('.jpg') ||
                          //                 url.endsWith('.jpeg');

                          //             final isPdf = url.toLowerCase().endsWith(
                          //               '.pdf',
                          //             );

                          //             final isDoc =
                          //                 url.toLowerCase().endsWith('.doc') ||
                          //                 url.toLowerCase().endsWith('.docx');

                          //             return GestureDetector(
                          //               onTap: () async {
                          //                 final uri = Uri.parse(url);

                          //                 if (await canLaunchUrl(uri)) {
                          //                   await launchUrl(
                          //                     uri,
                          //                     mode: LaunchMode.externalApplication,
                          //                   );
                          //                 }
                          //               },
                          //               child: isImage
                          //                   ? ClipRRect(
                          //                       borderRadius: BorderRadius.circular(
                          //                         12,
                          //                       ),
                          //                       child: Image.network(
                          //                         url,
                          //                         // width: 100,
                          //                         // height: 100,
                          //                         fit: BoxFit.cover,
                          //                       ),
                          //                     )
                          //                   : Container(
                          //                       width: 100,
                          //                       padding: const EdgeInsets.symmetric(
                          //                         vertical: 16,
                          //                       ),
                          //                       decoration: BoxDecoration(
                          //                         color: Colors.white,
                          //                         borderRadius: BorderRadius.circular(
                          //                           14,
                          //                         ),
                          //                       ),
                          //                       child: Column(
                          //                         children: [
                          //                           Icon(
                          //                             isPdf
                          //                                 ? Icons.picture_as_pdf
                          //                                 : isDoc
                          //                                 ? Icons.description
                          //                                 : Icons.insert_drive_file,
                          //                             size: 42,
                          //                             color: isPdf
                          //                                 ? Colors.red
                          //                                 : Colors.blue,
                          //                           ),
                          //                           const SizedBox(height: 8),
                          //                           Text(
                          //                             isPdf
                          //                                 ? 'PDF File'
                          //                                 : isDoc
                          //                                 ? 'Document'
                          //                                 : 'File',
                          //                             style: const TextStyle(
                          //                               fontSize: 11,
                          //                               fontWeight: FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ),
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ],
                          //     ],
                          //   ),
                          // ),
                          /// SHOW FILES ONLY WHEN EXPANDED
                          if (isExpanded && files.isNotEmpty) ...[
                            const SizedBox(height: 14),

                            Builder(
                              builder: (context) {
                                final imageFiles = files.where((file) {
                                  final url = (file.url ?? '').toLowerCase();
                                  final type = (file.type ?? '').toLowerCase();

                                  return type.contains('image') ||
                                      url.endsWith('.png') ||
                                      url.endsWith('.jpg') ||
                                      url.endsWith('.jpeg');
                                }).toList();

                                final otherFiles = files.where((file) {
                                  final url = (file.url ?? '').toLowerCase();

                                  return !(url.endsWith('.png') ||
                                      url.endsWith('.jpg') ||
                                      url.endsWith('.jpeg'));
                                }).toList();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// IMAGE CAROUSEL
                                    if (imageFiles.isNotEmpty)
                                      SizedBox(
                                        height: 220,
                                        child: PageView.builder(
                                          itemCount: imageFiles.length,
                                          controller: PageController(
                                            viewportFraction: 0.92,
                                          ),
                                          itemBuilder: (context, imageIndex) {
                                            final image =
                                                imageFiles[imageIndex];

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                right: 10,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final uri = Uri.parse(
                                                      image.url ?? '',
                                                    );

                                                    if (await canLaunchUrl(
                                                      uri,
                                                    )) {
                                                      await launchUrl(
                                                        uri,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }
                                                  },
                                                  child: Stack(
                                                    children: [
                                                      /// SHIMMER LOADER
                                                      Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey
                                                            .shade300,
                                                        highlightColor: Colors
                                                            .grey
                                                            .shade100,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 220,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  18,
                                                                ),
                                                          ),
                                                        ),
                                                      ),

                                                      /// IMAGE
                                                      Image.network(
                                                        image.url ?? '',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,

                                                        loadingBuilder:
                                                            (
                                                              context,
                                                              child,
                                                              loadingProgress,
                                                            ) {
                                                              if (loadingProgress ==
                                                                  null) {
                                                                return child;
                                                              }

                                                              return const SizedBox();
                                                            },

                                                        errorBuilder:
                                                            (
                                                              context,
                                                              error,
                                                              stackTrace,
                                                            ) {
                                                              return const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .broken_image,
                                                                  size: 40,
                                                                ),
                                                              );
                                                            },
                                                      ),
                                                    ],
                                                  ),
                                                  // child: Stack(
                                                  //   alignment: Alignment.center,
                                                  //   children: [
                                                  //     /// LOADER SHOWS IMMEDIATELY
                                                  //     const Center(
                                                  //       child:
                                                  //           CircularProgressIndicator(),
                                                  //     ),

                                                  //     /// IMAGE
                                                  //     Image.network(
                                                  //       image.url ?? '',
                                                  //       fit: BoxFit.cover,
                                                  //       width: double.infinity,

                                                  //       loadingBuilder:
                                                  //           (
                                                  //             context,
                                                  //             child,
                                                  //             loadingProgress,
                                                  //           ) {
                                                  //             if (loadingProgress ==
                                                  //                 null) {
                                                  //               return child;
                                                  //             }

                                                  //             return child;
                                                  //           },

                                                  //       errorBuilder:
                                                  //           (
                                                  //             context,
                                                  //             error,
                                                  //             stackTrace,
                                                  //           ) {
                                                  //             return const Center(
                                                  //               child: Icon(
                                                  //                 Icons
                                                  //                     .broken_image,
                                                  //                 size: 40,
                                                  //               ),
                                                  //             );
                                                  //           },
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // child: Image.network(
                                                  //   image.url ?? '',
                                                  //   fit: BoxFit.cover,
                                                  //   width: double.infinity,
                                                  // ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                    /// FILES
                                    if (otherFiles.isNotEmpty) ...[
                                      const SizedBox(height: 14),

                                      Wrap(
                                        spacing: 10,
                                        runSpacing: 10,
                                        children: otherFiles.map((file) {
                                          final url = file.url ?? '';

                                          final isPdf = url
                                              .toLowerCase()
                                              .endsWith('.pdf');

                                          final isDoc =
                                              url.toLowerCase().endsWith(
                                                '.doc',
                                              ) ||
                                              url.toLowerCase().endsWith(
                                                '.docx',
                                              );

                                          return GestureDetector(
                                            // onTap: () async {
                                            //   try {
                                            //     debugPrint("FILE CLICKED");

                                            //     final dir =
                                            //         await getTemporaryDirectory();

                                            //     final extension = url
                                            //         .split('.')
                                            //         .last;

                                            //     final filePath =
                                            //         '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.$extension';

                                            //     debugPrint(
                                            //       "DOWNLOADING TO: $filePath",
                                            //     );

                                            //     await Dio().download(
                                            //       url,
                                            //       filePath,
                                            //     );

                                            //     debugPrint(
                                            //       "DOWNLOAD COMPLETED",
                                            //     );

                                            //     final result =
                                            //         await OpenFilex.open(
                                            //           filePath,
                                            //         );

                                            //     debugPrint(
                                            //       "OPEN RESULT: ${result.message}",
                                            //     );
                                            //   } catch (e) {
                                            //     debugPrint("ERROR: $e");
                                            //   }
                                            // },
                                            onTap: () async {
                                              final uri = Uri.parse(url);

                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(
                                                  uri,
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                );
                                              }
                                            },
                                            child: Container(
                                              //width: 100,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 16,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 20),

                                                  Icon(
                                                    isPdf
                                                        ? Icons.picture_as_pdf
                                                        : isDoc
                                                        ? Icons.description
                                                        : Icons
                                                              .insert_drive_file,
                                                    size: 42,
                                                    color: isPdf
                                                        ? Colors.red
                                                        : Colors.blue,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    isPdf
                                                        ? title
                                                        : isDoc
                                                        ? title
                                                        : title,
                                                    style: const TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        ],
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
