import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
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
import 'package:studentmanagement/fetaures/classdiary/presentation/widgets/classdiary_skeleton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

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
                    videoUrl: diary.videoUrl,
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
  final List<String>? videoUrl;

  const _DiaryCard({
    required this.index,
    required this.teacherName,
    required this.teacherRole,
    required this.title,
    required this.description,
    required this.date,
    required this.files,
    required this.employeePhoto,
    required this.videoUrl,
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

  @override
  Widget build(BuildContext context) {
    debugPrint('');
    debugPrint('=========== DIARY CARD ===========');
    debugPrint('TITLE => $title');
    debugPrint('videoUrl => $videoUrl');
    debugPrint('videoUrl type => ${videoUrl.runtimeType}');
    debugPrint('videoUrl length => ${videoUrl?.length ?? 0}');
    debugPrint('=================================');
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
                              date.isEmpty ? 'Today' : date,
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

                            /// SHOW FILES ONLY WHEN EXPANDED
                            if (isExpanded) ...[
                              const SizedBox(height: 14),

                              /// ================= VIDEO =================
                              if (videoUrl != null && videoUrl!.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    String cleanedVideoUrl = '';

                                    try {
                                      cleanedVideoUrl = videoUrl!.first;

                                      cleanedVideoUrl = cleanedVideoUrl
                                          .replaceAll(r'\', '');

                                      final regExp = RegExp(r'src="([^"]+)"');

                                      final match = regExp.firstMatch(
                                        cleanedVideoUrl,
                                      );

                                      if (match != null) {
                                        cleanedVideoUrl = match.group(1) ?? '';
                                      }

                                      debugPrint(
                                        "VIDEO URL : $cleanedVideoUrl",
                                      );
                                    } catch (e) {
                                      debugPrint("VIDEO PARSE ERROR : $e");
                                    }

                                    if (cleanedVideoUrl.isEmpty) {
                                      return const SizedBox();
                                    }
                                    final controller = WebViewController();

                                    controller
                                      ..setJavaScriptMode(
                                        JavaScriptMode.unrestricted,
                                      )
                                      ..setBackgroundColor(Colors.black)
                                      ..loadRequest(Uri.parse(cleanedVideoUrl));

                                    if (controller.platform
                                        is AndroidWebViewController) {
                                      AndroidWebViewController.enableDebugging(
                                        true,
                                      );

                                      final androidController =
                                          controller.platform
                                              as AndroidWebViewController;

                                      androidController
                                          .setMediaPlaybackRequiresUserGesture(
                                            false,
                                          );
                                    }

                                    return Column(
                                      children: [
                                        Container(
                                          height: 220,
                                          width: double.infinity,

                                          padding: const EdgeInsets.all(14),

                                          decoration: BoxDecoration(
                                            color: Colors.white,

                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),

                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,

                                          child: WebViewWidget(
                                            controller: controller,
                                          ),
                                        ),

                                        const SizedBox(height: 14),

                                        const SizedBox(height: 14),
                                      ],
                                    );
                                  },
                                ),

                              /// ================= VIDEO =================
                              /// ================= VIDEO =================
                              // if (videoUrl != null && videoUrl!.isNotEmpty)
                              //   Builder(
                              //     builder: (context) {
                              //       String cleanedVideoUrl = '';

                              //       try {
                              //         cleanedVideoUrl = videoUrl!.first;

                              //         cleanedVideoUrl = cleanedVideoUrl
                              //             .replaceAll(r'\', '');

                              //         final regExp = RegExp(r'src="([^"]+)"');

                              //         final match = regExp.firstMatch(
                              //           cleanedVideoUrl,
                              //         );

                              //         if (match != null) {
                              //           cleanedVideoUrl = match.group(1) ?? '';
                              //         }

                              //         debugPrint(
                              //           "VIDEO URL : $cleanedVideoUrl",
                              //         );
                              //       } catch (e) {
                              //         debugPrint("VIDEO PARSE ERROR : $e");
                              //       }

                              //       if (cleanedVideoUrl.isEmpty) {
                              //         return const SizedBox();
                              //       }

                              //       return _VideoThumbnailCard(
                              //         videoUrl: cleanedVideoUrl,
                              //       );
                              //     },
                              //   ),
                              if (files.isNotEmpty)
                                Builder(
                                  builder: (context) {
                                    final imageFiles = files.where((file) {
                                      final url = (file.url ?? '')
                                          .toLowerCase();
                                      final type = (file.type ?? '')
                                          .toLowerCase();

                                      return type.contains('image') ||
                                          url.endsWith('.png') ||
                                          url.endsWith('.jpg') ||
                                          url.endsWith('.jpeg');
                                    }).toList();

                                    final otherFiles = files.where((file) {
                                      final url = (file.url ?? '')
                                          .toLowerCase();

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
                                              borderRadius:
                                                  BorderRadius.circular(24),
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
                                                        const SizedBox(
                                                          width: 12,
                                                        ),

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
                                                                    Colors
                                                                        .black,

                                                                body: Stack(
                                                                  children: [
                                                                    /// IMAGE VIEWER
                                                                    PhotoView(
                                                                      imageProvider: NetworkImage(
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
                                                                            Icons.close,
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
                                                                color: Colors
                                                                    .white,
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
                                                                      highlightColor: Colors
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
                                                                      height:
                                                                          105,

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
                                                            if (imageIndex ==
                                                                    3 &&
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
                                                                    fontSize:
                                                                        24,
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
                                                          final String
                                                          imageUrl =
                                                              imageFiles[i]
                                                                  .url ??
                                                              '';

                                                          if (imageUrl.isEmpty)
                                                            continue;

                                                          final tempDir =
                                                              await getTemporaryDirectory();

                                                          final String
                                                          fileName =
                                                              'cristal_image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';

                                                          final String
                                                          tempPath =
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
                                                onTap: () async {
                                                  try {
                                                    final lowerUrl = url
                                                        .toLowerCase();

                                                    /// VIMEO VIDEO
                                                    final isVimeo = lowerUrl
                                                        .contains("vimeo.com");

                                                    if (isVimeo) {
                                                      final uri = Uri.parse(
                                                        url,
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
                                                        BorderRadius.circular(
                                                          14,
                                                        ),
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
// class _DiaryCard extends StatelessWidget {
//   final int index;
//   final String teacherName;
//   final String teacherRole;
//   final String title;
//   final String description;
//   final String date;
//   final List<DiaryFileEntity> files;
//   final String? employeePhoto;
//   final List<String>? videoUrl;

//   const _DiaryCard({
//     required this.index,
//     required this.teacherName,
//     required this.teacherRole,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.files,
//     required this.employeePhoto,
//     required this.videoUrl,
//   });

//   // ================= COLORS =================
//   Color get mainColor {
//     final colors = [
//       const Color(0xFFE9AFD4),
//       const Color(0xFFBBB3CA),
//       const Color(0xFFFFDB6E),
//       const Color(0xFFE9AFD4),
//       const Color(0xFFBBB3CA),
//     ];
//     return colors[index % colors.length];
//   }

//   Color get bodyColor {
//     final colors = [
//       const Color(0xFFFFD7F0),
//       const Color(0xFFE5D9FA),
//       const Color(0xFFFFEFBF),
//       const Color(0xFFFFD7F0),
//       const Color(0xFFE5D9FA),
//     ];
//     return colors[index % colors.length];
//   }

//   // ================= VIDEO CLEANER =================
//   String extractVideoUrl(String raw) {
//     try {
//       if (raw.isEmpty) return '';

//       final cleaned = raw.replaceAll(r'\"', '"').replaceAll(r'\\', '');

//       final regExp = RegExp(r'src="([^"]+)"');
//       final match = regExp.firstMatch(cleaned);

//       if (match != null) {
//         return match.group(1) ?? '';
//       }

//       return '';
//     } catch (e) {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: expandedIndexNotifier,
//       builder: (_, expandedIndex, __) {
//         final isExpanded = expandedIndex == index;

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= HEADER =================
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundImage:
//                       employeePhoto != null && employeePhoto!.isNotEmpty
//                       ? NetworkImage(employeePhoto!)
//                       : null,
//                   child: employeePhoto == null || employeePhoto!.isEmpty
//                       ? const Icon(Icons.person)
//                       : null,
//                 ),
//                 const SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           teacherName,
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(width: 6),
//                         const Icon(Icons.push_pin, size: 18, color: Colors.red),
//                       ],
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       teacherRole,
//                       style: const TextStyle(
//                         color: Color(0xFF444444),
//                         fontSize: 11,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             // ================= CARD =================
//             GestureDetector(
//               onTap: () {
//                 expandedIndexNotifier.value = isExpanded ? null : index;
//               },
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: mainColor,
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 child: Column(
//                   children: [
//                     // ===== TITLE =====
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20, 12, 14, 10),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               title,
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w900,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 18,
//                               vertical: 7,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.42),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               date.isEmpty ? 'Today' : date,
//                               style: const TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     // ================= BODY =================
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 5.0,
//                         vertical: 10,
//                       ),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
//                         decoration: BoxDecoration(
//                           color: bodyColor,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // DESCRIPTION
//                             Text(
//                               description.isEmpty
//                                   ? 'No Description'
//                                   : description,
//                               maxLines: isExpanded ? null : 2,
//                               overflow: isExpanded
//                                   ? TextOverflow.visible
//                                   : TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 height: 1.7,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),

//                             if (!isExpanded) const SizedBox.shrink(),

//                             // ================= EXPANDED CONTENT =================
//                             if (isExpanded) ...[
//                               const SizedBox(height: 14),

//                               // ================= VIDEO =================
//                               if (videoUrl != null && videoUrl!.isNotEmpty)
//                                 Builder(
//                                   builder: (context) {
//                                     final raw = videoUrl!.first;
//                                     final cleanUrl = extractVideoUrl(raw);

//                                     if (cleanUrl.isEmpty) {
//                                       return const SizedBox();
//                                     }

//                                     return _VideoThumbnailCard(
//                                       videoUrl: cleanUrl,
//                                     );
//                                   },
//                                 ),

//                               const SizedBox(height: 14),

//                               // ================= FILES =================
//                               if (files.isNotEmpty)
//                                 Text(
//                                   "Files section already intact (unchanged)",
//                                   style: TextStyle(color: Colors.grey.shade700),
//                                 ),
//                             ],
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

class _VideoThumbnailCard extends StatelessWidget {
  final String videoUrl;

  const _VideoThumbnailCard({required this.videoUrl});

  String getThumbnail() {
    try {
      if (videoUrl.contains("vimeo.com")) {
        final uri = Uri.parse(videoUrl);

        String videoId = '';

        if (uri.pathSegments.isNotEmpty) {
          videoId = uri.pathSegments.last;
        }

        return "https://vumbnail.com/$videoId.jpg";
      }

      return '';
    } catch (e) {
      return '';
    }
  }

  // Future<void> openVideoExternally(BuildContext context) async {
  //   try {
  //     final intent = AndroidIntent(
  //       action: 'action_view',
  //       data: videoUrl,
  //       type: 'video/*',
  //     );

  //     await intent.launch();
  //   } catch (e) {
  //     debugPrint("VIDEO OPEN ERROR : $e");

  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(const SnackBar(content: Text("Unable to open video")));
  //   }
  // }
  Future<void> openVideoExternally(BuildContext context) async {
    try {
      final intent = AndroidIntent(
        action: 'android.intent.action.VIEW',
        data: videoUrl,
        flags: <int>[0x10000000], // FLAG_ACTIVITY_NEW_TASK
      );

      await intent.launchChooser('Open video with');
    } catch (e) {
      debugPrint("VIDEO OPEN ERROR: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Unable to open video")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = getThumbnail();

    return GestureDetector(
      onTap: () => openVideoExternally(context),
      child: Container(
        height: 220,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(18),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// THUMBNAIL
            Positioned.fill(
              child: thumbnail.isNotEmpty
                  ? Image.network(
                      thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Container(color: Colors.grey.shade300);
                      },
                    )
                  : Container(color: Colors.grey.shade300),
            ),

            /// DARK OVERLAY
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.35)),
            ),

            /// PLAY BUTTON
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),

            /// OPEN TEXT
            Positioned(
              bottom: 14,
              left: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.open_in_new, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Open Video",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
