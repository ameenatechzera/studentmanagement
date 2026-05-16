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
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 10,
                      ),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                        decoration: BoxDecoration(
                          color: bodyColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
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
                                    final type = (file.type ?? '')
                                        .toLowerCase();

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// IMAGE CAROUSEL
                                      if (imageFiles.isNotEmpty)
                                        //if (imageFiles.isNotEmpty)
                                        Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF3F4F8),
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),

                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// TITLE
                                              Text(
                                                title,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),
                                              ),

                                              const SizedBox(height: 16),

                                              /// IMAGES
                                              SizedBox(
                                                height: 105,

                                                child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      imageFiles.length > 4
                                                      ? 4
                                                      : imageFiles.length,

                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(width: 12),

                                                  itemBuilder: (context, imageIndex) {
                                                    final image =
                                                        imageFiles[imageIndex];

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) => Scaffold(
                                                              backgroundColor:
                                                                  Colors.black,

                                                              body: Stack(
                                                                children: [
                                                                  /// IMAGE VIEWER
                                                                  PhotoView(
                                                                    imageProvider:
                                                                        NetworkImage(
                                                                          image.url ??
                                                                              '',
                                                                        ),

                                                                    minScale:
                                                                        PhotoViewComputedScale
                                                                            .contained,

                                                                    maxScale:
                                                                        PhotoViewComputedScale
                                                                            .covered *
                                                                        3,
                                                                  ),

                                                                  /// CLOSE BUTTON
                                                                  Positioned(
                                                                    top: 50,
                                                                    right: 20,

                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(
                                                                          context,
                                                                        );
                                                                      },

                                                                      child: Container(
                                                                        padding:
                                                                            const EdgeInsets.all(
                                                                              8,
                                                                            ),

                                                                        decoration: BoxDecoration(
                                                                          color: Colors.black.withOpacity(
                                                                            0.5,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),

                                                                        child: const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },

                                                      child: Stack(
                                                        children: [
                                                          /// IMAGE CARD
                                                          Container(
                                                            width: 95,
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    14,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                              ),
                                                            ),

                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    14,
                                                                  ),

                                                              child: Stack(
                                                                children: [
                                                                  /// SHIMMER
                                                                  Shimmer.fromColors(
                                                                    baseColor: Colors
                                                                        .grey
                                                                        .shade300,
                                                                    highlightColor:
                                                                        Colors
                                                                            .grey
                                                                            .shade100,

                                                                    child: Container(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),

                                                                  /// IMAGE
                                                                  Image.network(
                                                                    image.url ??
                                                                        '',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    width: 95,
                                                                    height: 105,

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
                                                                              Icons.broken_image,
                                                                            ),
                                                                          );
                                                                        },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          /// +MORE OVERLAY
                                                          if (imageIndex == 3 &&
                                                              imageFiles
                                                                      .length >
                                                                  4)
                                                            Container(
                                                              width: 95,
                                                              height: 105,

                                                              decoration: BoxDecoration(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                      0.45,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      14,
                                                                    ),
                                                              ),

                                                              alignment:
                                                                  Alignment
                                                                      .center,

                                                              child: Text(
                                                                "+${imageFiles.length - 4}",
                                                                style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              const SizedBox(height: 18),

                                              /// DOWNLOAD ALL
                                              Center(
                                                child: GestureDetector(
                                                  // onTap: () async {
                                                  //   try {
                                                  //     final dio = Dio();

                                                  //     for (
                                                  //       int i = 0;
                                                  //       i < imageFiles.length;
                                                  //       i++
                                                  //     ) {
                                                  //       final String imageUrl =
                                                  //           imageFiles[i].url ??
                                                  //           '';

                                                  //       if (imageUrl.isEmpty)
                                                  //         continue;

                                                  //       final tempDir =
                                                  //           await getTemporaryDirectory();

                                                  //       final String fileName =
                                                  //           'cristal_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

                                                  //       final String tempPath =
                                                  //           '${tempDir.path}/$fileName';

                                                  //       /// DOWNLOAD TEMP FILE
                                                  //       await dio.download(
                                                  //         imageUrl,
                                                  //         tempPath,
                                                  //       );

                                                  //       print(
                                                  //         "Downloaded Temp File: $tempPath",
                                                  //       );

                                                  //       /// SAVE TO DOWNLOADS
                                                  //       final MediaStore
                                                  //       mediaStore =
                                                  //           MediaStore();

                                                  //       final result =
                                                  //           await mediaStore
                                                  //               .saveFile(
                                                  //                 tempFilePath:
                                                  //                     tempPath,
                                                  //                 dirType: DirType
                                                  //                     .download,
                                                  //                 dirName: DirName
                                                  //                     .download,
                                                  //               );

                                                  //       print(
                                                  //         "Save Result: $result",
                                                  //       );
                                                  //     }

                                                  //     ScaffoldMessenger.of(
                                                  //       context,
                                                  //     ).showSnackBar(
                                                  //       const SnackBar(
                                                  //         content: Text(
                                                  //           'Images downloaded to Downloads',
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   } catch (e, stackTrace) {
                                                  //     print(
                                                  //       "DOWNLOAD ERROR: $e",
                                                  //     );
                                                  //     print(
                                                  //       "STACK TRACE: $stackTrace",
                                                  //     );

                                                  //     ScaffoldMessenger.of(
                                                  //       context,
                                                  //     ).showSnackBar(
                                                  //       SnackBar(
                                                  //         content: Text(
                                                  //           'Download failed: $e',
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   }
                                                  // },
                                                  onTap: () async {
                                                    try {
                                                      final dio = Dio();
                                                      final mediaStore =
                                                          MediaStore();

                                                      for (
                                                        int i = 0;
                                                        i < imageFiles.length;
                                                        i++
                                                      ) {
                                                        final String imageUrl =
                                                            imageFiles[i].url ??
                                                            '';

                                                        if (imageUrl.isEmpty)
                                                          continue;

                                                        final tempDir =
                                                            await getTemporaryDirectory();

                                                        final String fileName =
                                                            'cristal_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

                                                        final String tempPath =
                                                            '${tempDir.path}/$fileName';

                                                        await dio.download(
                                                          imageUrl,
                                                          tempPath,
                                                        );

                                                        await mediaStore
                                                            .saveFile(
                                                              tempFilePath:
                                                                  tempPath,
                                                              dirType: DirType
                                                                  .download,
                                                              dirName: DirName
                                                                  .download,
                                                            );
                                                      }

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            'Images saved to Downloads/Cristal',
                                                          ),
                                                        ),
                                                      );
                                                    } catch (e, stackTrace) {
                                                      print(
                                                        "DOWNLOAD ERROR: $e",
                                                      );
                                                      print(
                                                        "STACK TRACE: $stackTrace",
                                                      );

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Download failed: $e',
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },

                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Icon(
                                                        Icons.download,
                                                        size: 18,
                                                        color: Color(
                                                          0xff5B8DEF,
                                                        ),
                                                      ),

                                                      SizedBox(width: 6),

                                                      Text(
                                                        "Download All",
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xff5B8DEF,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      // SizedBox(
                                      //   height: 220,
                                      //   child: PageView.builder(
                                      //     itemCount: imageFiles.length,
                                      //     controller: PageController(
                                      //       viewportFraction: 0.92,
                                      //     ),
                                      //     itemBuilder: (context, imageIndex) {
                                      //       final image =
                                      //           imageFiles[imageIndex];
                                      //       return Padding(
                                      //         padding: const EdgeInsets.only(
                                      //           right: 10,
                                      //         ),
                                      //         child: ClipRRect(
                                      //           borderRadius:
                                      //               BorderRadius.circular(18),
                                      //           child: GestureDetector(
                                      //             onTap: () async {
                                      //               final uri = Uri.parse(
                                      //                 image.url ?? '',
                                      //               );
                                      //               if (await canLaunchUrl(
                                      //                 uri,
                                      //               )) {
                                      //                 await launchUrl(
                                      //                   uri,
                                      //                   mode: LaunchMode
                                      //                       .externalApplication,
                                      //                 );
                                      //               }
                                      //             },
                                      //             child: Stack(
                                      //               children: [
                                      //                 /// SHIMMER LOADER
                                      //                 Shimmer.fromColors(
                                      //                   baseColor: Colors
                                      //                       .grey
                                      //                       .shade300,
                                      //                   highlightColor: Colors
                                      //                       .grey
                                      //                       .shade100,
                                      //                   child: Container(
                                      //                     width:
                                      //                         double.infinity,
                                      //                     height: 220,
                                      //                     decoration:
                                      //                         BoxDecoration(
                                      //                           color: Colors
                                      //                               .white,
                                      //                           borderRadius:
                                      //                               BorderRadius.circular(
                                      //                                 18,
                                      //                               ),
                                      //                         ),
                                      //                   ),
                                      //                 ),
                                      //                 /// IMAGE
                                      //                 Image.network(
                                      //                   image.url ?? '',
                                      //                   fit: BoxFit.cover,
                                      //                   width:
                                      //                       double.infinity,
                                      //                   loadingBuilder:
                                      //                       (
                                      //                         context,
                                      //                         child,
                                      //                         loadingProgress,
                                      //                       ) {
                                      //                         if (loadingProgress ==
                                      //                             null) {
                                      //                           return child;
                                      //                         }
                                      //                         return const SizedBox();
                                      //                       },
                                      //                   errorBuilder:
                                      //                       (
                                      //                         context,
                                      //                         error,
                                      //                         stackTrace,
                                      //                       ) {
                                      //                         return const Center(
                                      //                           child: Icon(
                                      //                             Icons
                                      //                                 .broken_image,
                                      //                             size: 40,
                                      //                           ),
                                      //                         );
                                      //                       },
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             // child: Stack(
                                      //             //   alignment: Alignment.center,
                                      //             //   children: [
                                      //             //     /// LOADER SHOWS IMMEDIATELY
                                      //             //     const Center(
                                      //             //       child:
                                      //             //           CircularProgressIndicator(),
                                      //             //     ),
                                      //             //     /// IMAGE
                                      //             //     Image.network(
                                      //             //       image.url ?? '',
                                      //             //       fit: BoxFit.cover,
                                      //             //       width: double.infinity,
                                      //             //       loadingBuilder:
                                      //             //           (
                                      //             //             context,
                                      //             //             child,
                                      //             //             loadingProgress,
                                      //             //           ) {
                                      //             //             if (loadingProgress ==
                                      //             //                 null) {
                                      //             //               return child;
                                      //             //             }
                                      //             //             return child;
                                      //             //           },
                                      //             //       errorBuilder:
                                      //             //           (
                                      //             //             context,
                                      //             //             error,
                                      //             //             stackTrace,
                                      //             //           ) {
                                      //             //             return const Center(
                                      //             //               child: Icon(
                                      //             //                 Icons
                                      //             //                     .broken_image,
                                      //             //                 size: 40,
                                      //             //               ),
                                      //             //             );
                                      //             //           },
                                      //             //     ),
                                      //             //   ],
                                      //             // ),
                                      //             // child: Image.network(
                                      //             //   image.url ?? '',
                                      //             //   fit: BoxFit.cover,
                                      //             //   width: double.infinity,
                                      //             // ),
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),
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
                                              // onTap: () async {
                                              //   try {
                                              //     debugPrint(
                                              //       "FILE DOWNLOAD STARTED",
                                              //     );

                                              //     final extension = url
                                              //         .split('.')
                                              //         .last
                                              //         .split('?')
                                              //         .first;

                                              //     final fileName =
                                              //         '${title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.$extension';

                                              //     /// PHONE DOWNLOADS PATH
                                              //     final savePath =
                                              //         '/storage/emulated/0/Download/$fileName';

                                              //     debugPrint(
                                              //       "SAVE PATH: $savePath",
                                              //     );

                                              //     /// DOWNLOAD FILE
                                              //     await Dio().download(
                                              //       url,
                                              //       savePath,
                                              //     );

                                              //     debugPrint(
                                              //       "DOWNLOAD COMPLETED",
                                              //     );

                                              //     ScaffoldMessenger.of(
                                              //       context,
                                              //     ).showSnackBar(
                                              //       SnackBar(
                                              //         content: Text(
                                              //           'Downloaded to Downloads/$fileName',
                                              //         ),
                                              //       ),
                                              //     );
                                              //   } catch (e, stackTrace) {
                                              //     debugPrint(
                                              //       "DOWNLOAD ERROR: $e",
                                              //     );
                                              //     debugPrint(
                                              //       "STACK TRACE: $stackTrace",
                                              //     );

                                              //     ScaffoldMessenger.of(
                                              //       context,
                                              //     ).showSnackBar(
                                              //       SnackBar(
                                              //         content: Text(
                                              //           'Download failed: $e',
                                              //         ),
                                              //       ),
                                              //     );
                                              //   }
                                              // },
                                              onTap: () async {
                                                try {
                                                  final lowerUrl = url
                                                      .toLowerCase();

                                                  /// VIMEO VIDEO
                                                  final isVimeo = lowerUrl
                                                      .contains("vimeo.com");

                                                  if (isVimeo) {
                                                    final uri = Uri.parse(url);

                                                    if (await canLaunchUrl(
                                                      uri,
                                                    )) {
                                                      await launchUrl(
                                                        uri,
                                                        mode: LaunchMode
                                                            .externalApplication,
                                                      );
                                                    }

                                                    return;
                                                  }
                                                  debugPrint(
                                                    "FILE DOWNLOAD STARTED",
                                                  );

                                                  // Request storage permission if needed
                                                  if (Platform.isAndroid) {
                                                    await Permission.storage
                                                        .request();
                                                    await Permission
                                                        .manageExternalStorage
                                                        .request();
                                                  }

                                                  // Get Downloads folder path
                                                  final downloadsDir = Directory(
                                                    '/storage/emulated/0/Download',
                                                  );

                                                  if (!await downloadsDir
                                                      .exists()) {
                                                    await downloadsDir.create(
                                                      recursive: true,
                                                    );
                                                  }

                                                  final extension = url
                                                      .split('.')
                                                      .last;

                                                  final fileName =
                                                      '${title}_${DateTime.now().millisecondsSinceEpoch}.$extension';

                                                  final savePath =
                                                      '${downloadsDir.path}/$fileName';

                                                  debugPrint(
                                                    "SAVE PATH: $savePath",
                                                  );

                                                  // Download file
                                                  await Dio().download(
                                                    url,
                                                    savePath,
                                                  );

                                                  debugPrint(
                                                    "DOWNLOAD COMPLETED",
                                                  );

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'File downloaded to Downloads folder',
                                                      ),
                                                    ),
                                                  );

                                                  // Open downloaded file
                                                  final result =
                                                      await OpenFilex.open(
                                                        savePath,
                                                      );

                                                  debugPrint(
                                                    "OPEN RESULT: ${result.message}",
                                                  );
                                                } catch (e) {
                                                  debugPrint("ERROR: $e");

                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Download failed',
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                              child: Container(
                                                //width: 100,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 16,
                                                    ),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //const SizedBox(width: 20),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          isPdf
                                                              ? Icons
                                                                    .picture_as_pdf
                                                              : isDoc
                                                              ? Icons
                                                                    .description
                                                              : Icons
                                                                    .insert_drive_file,
                                                          size: 42,
                                                          color: isPdf
                                                              ? Colors.red
                                                              : Colors.blue,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),

                                                        Text(
                                                          isPdf
                                                              ? title
                                                              : isDoc
                                                              ? title
                                                              : title,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    //const SizedBox(width: 20),
                                                    // Text(
                                                    //   isPdf
                                                    //       ? title
                                                    //       : isDoc
                                                    //       ? title
                                                    //       : title,
                                                    //   style: const TextStyle(
                                                    //     fontSize: 11,
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //   ),
                                                    // ),
                                                    Icon(Icons.download),
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

  Future<void> downloadFile(BuildContext context, String url) async {
    try {
      /// STORAGE PERMISSION
      await Permission.storage.request();

      final dio = Dio();

      /// FILE NAME
      final fileName = url.split('/').last;

      /// SAVE DIRECTORY
      Directory? directory;

      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final filePath = "${directory!.path}/$fileName";

      /// DOWNLOAD
      await dio.download(url, filePath);

      /// SUCCESS MESSAGE
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$fileName downloaded successfully")),
      );

      /// OPEN FILE
      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download failed: $e")));
    }
  }
}
