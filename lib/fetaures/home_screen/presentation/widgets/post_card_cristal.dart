import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

String feedExtractIframeVideoUrl(String value) {
  try {
    final cleaned = value
        .replaceAll(r'\"', '"')
        .replaceAll(r'\\', '')
        .replaceAll('&amp;', '&')
        .trim();

    final iframeMatch = RegExp(r'''src=["']([^"']+)["']''').firstMatch(cleaned);

    if (iframeMatch != null) {
      return iframeMatch.group(1) ?? '';
    }

    final vimeoUrlMatch = RegExp(
      r'''https?:\/\/[^\s"'<>]*vimeo\.com[^\s"'<>]*''',
    ).firstMatch(cleaned);

    if (vimeoUrlMatch != null) {
      return vimeoUrlMatch.group(0) ?? '';
    }

    final uri = Uri.tryParse(cleaned);

    if (uri != null && uri.pathSegments.isNotEmpty) {
      final lastSegment = uri.pathSegments.last.trim();

      final isOnlyNumber = RegExp(r'^\d+$').hasMatch(lastSegment);

      if (isOnlyNumber) {
        return 'https://player.vimeo.com/video/$lastSegment';
      }
    }

    return '';
  } catch (e) {
    debugPrint("FEED IFRAME VIDEO PARSE ERROR: $e");
    return '';
  }
}

String feedPrepareVimeoUrl(String url) {
  if (url.trim().isEmpty) return '';

  final uri = Uri.tryParse(url.trim());

  if (uri == null) return '';

  String videoId = '';

  if (uri.host.contains('player.vimeo.com')) {
    final videoIndex = uri.pathSegments.indexOf('video');

    if (videoIndex != -1 && uri.pathSegments.length > videoIndex + 1) {
      videoId = uri.pathSegments[videoIndex + 1];
    }
  } else if (uri.host.contains('vimeo.com')) {
    videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
  }

  if (videoId.isEmpty) {
    return url;
  }

  final params = Map<String, String>.from(uri.queryParameters);

  params['title'] = '0';
  params['byline'] = '0';
  params['portrait'] = '0';
  params['badge'] = '0';
  params['dnt'] = '1';
  params['transparent'] = '0';
  params['autoplay'] = '0';
  params['autopause'] = '1';
  params['pip'] = '0';
  params['loop'] = '0';

  return Uri(
    scheme: 'https',
    host: 'player.vimeo.com',
    path: '/video/$videoId',
    queryParameters: params,
  ).toString();
}

String feedBuildCleanVimeoPlayerHtml(String videoUrl) {
  final safeUrl = const HtmlEscape().convert(videoUrl);

  return '''
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <style>
    html, body {
      margin: 0;
      padding: 0;
      background: #000000;
      width: 100%;
      height: 100%;
      overflow: hidden;
    }

    #playerWrap {
      position: fixed;
      inset: 0;
      background: #000000;
    }

    iframe {
      position: absolute;
      inset: 0;
      width: 100%;
      height: 100%;
      border: 0;
      background: #000000;
    }

    #endOverlay {
      display: none;
      position: fixed;
      inset: 0;
      background: #000000;
      align-items: center;
      justify-content: center;
      flex-direction: column;
      z-index: 9999;
      color: #ffffff;
      font-family: Arial, sans-serif;
    }

    #replayButton {
      width: 72px;
      height: 72px;
      border-radius: 50%;
      border: 2px solid #ffffff;
      background: rgba(255, 255, 255, 0.12);
      color: #ffffff;
      font-size: 34px;
      line-height: 72px;
      text-align: center;
      cursor: pointer;
      user-select: none;
    }

    #replayText {
      margin-top: 14px;
      font-size: 14px;
      font-weight: 600;
    }
  </style>
</head>
<body>
  <div id="playerWrap">
    <iframe
      id="vimeoPlayer"
      src="$safeUrl"
      allow="autoplay; fullscreen; picture-in-picture"
      allowfullscreen>
    </iframe>
  </div>

  <div id="endOverlay">
    <div id="replayButton">↻</div>
    <div id="replayText">Replay Video</div>
  </div>

  <script src="https://player.vimeo.com/api/player.js"></script>
  <script>
    const iframe = document.getElementById('vimeoPlayer');
    const endOverlay = document.getElementById('endOverlay');
    const replayButton = document.getElementById('replayButton');
    const player = new Vimeo.Player(iframe);

    let overlayShown = false;

    function showCleanEndScreen() {
      if (overlayShown) return;

      overlayShown = true;
      iframe.style.opacity = '0';
      iframe.style.pointerEvents = 'none';
      endOverlay.style.display = 'flex';

      player.pause().catch(function() {});
    }

    player.on('timeupdate', function(data) {
      if (!data || !data.duration || !data.seconds) return;

      const remaining = data.duration - data.seconds;

      if (remaining <= 0.08) {
        showCleanEndScreen();
      }
    });

    player.on('ended', function() {
      showCleanEndScreen();
    });

    replayButton.addEventListener('click', function() {
      overlayShown = false;
      endOverlay.style.display = 'none';
      iframe.style.opacity = '1';
      iframe.style.pointerEvents = 'auto';

      player.setCurrentTime(0).then(function() {
        player.play();
      }).catch(function() {});
    });
  </script>
</body>
</html>
''';
}

class PostCard extends StatefulWidget {
  final FeedDetails feed;

  const PostCard({super.key, required this.feed});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool isLiked;
  late int likeCount;
  int currentPage = 0;

  // static final Map<String, Size> _imageSizeCache = {};
  // static final Map<String, double> _aspectRatioCache = {};

  @override
  void initState() {
    super.initState();
    isLiked = widget.feed.isLiked ?? false;
    likeCount = widget.feed.likeCount ?? 0;
    debugPrint("🟢 FEED INIT → ${widget.feed.feedId}");

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _preloadImageSizes();
    // });
  }

  // String cleanUrl(String url) {
  //   return url
  //       .replaceAll('[', '')
  //       .replaceAll(']', '')
  //       .replaceAll('"', '')
  //       .trim();
  // }

  // List<String> getImages() {
  //   List<String> images = [];

  //   final feed = widget.feed;

  //   print("══════════════════════════════");
  //   print("🖼 FEED ID: ${feed.feedId}");
  //   print("📂 FILES COUNT: ${feed.files?.length ?? 0}");
  //   print("🖼 IMAGE FIELD: ${feed.image}");

  //   if (feed.files != null && feed.files!.isNotEmpty) {
  //     for (var file in feed.files!) {
  //       print("📂 FILE IMAGE: ${file.image}");

  //       final img = file.image?.trim();

  //       if (img != null && img.isNotEmpty) {
  //         images.add(img);
  //       }
  //     }
  //   }

  //   if (images.isEmpty && feed.image != null && feed.image!.isNotEmpty) {
  //     print("📸 USING IMAGE ARRAY");

  //     images.addAll(
  //       feed.image!.where((e) => e.trim().isNotEmpty).map((e) => e.trim()),
  //     );
  //   }

  //   print("✅ FINAL IMAGES COUNT: ${images.length}");
  //   print("✅ FINAL IMAGES: $images");
  //   print("══════════════════════════════");

  //   return images;
  // }
  // List<String> getImages() {
  //   print("════════ IMAGE DEBUG START ════════");
  //   final images = <String>[];
  //   final feed = widget.feed;

  //   print("\n════════════ GET IMAGES ════════════");
  //   print("🆔 FEED ID: ${feed.feedId}");

  //   print("📂 FILES COUNT: ${feed.files?.length ?? 0}");
  //   print("🖼 IMAGE ARRAY COUNT: ${feed.image?.length ?? 0}");

  //   /// FILES
  //   if (feed.files != null && feed.files!.isNotEmpty) {
  //     for (int i = 0; i < feed.files!.length; i++) {
  //       final img = feed.files![i].image?.trim();

  //       print("📂 FILE[$i] => $img");
  //       print("📂 FILE[$i] RAW => $img");
  //       print("📂 FILE[$i] TYPE => ${_detectType(img)}");

  //       if (img != null && img.isNotEmpty) {
  //         images.add(img);
  //         print("✅ ADDED FROM FILES");
  //       } else {
  //         print("❌ FILE IMAGE EMPTY");
  //       }
  //     }
  //   }

  //   /// IMAGE ARRAY
  //   if (feed.image != null && feed.image!.isNotEmpty) {
  //     for (int i = 0; i < feed.image!.length; i++) {
  //       final img = feed.image![i].trim();

  //       print(
  //         "🖼 IMAGE[$i] => ${img.substring(0, img.length > 50 ? 50 : img.length)}...",
  //       );

  //       if (img.isNotEmpty) {
  //         images.add(img);
  //         print("✅ ADDED FROM IMAGE ARRAY");
  //       } else {
  //         print("❌ IMAGE ARRAY ITEM EMPTY");
  //       }
  //     }
  //   }

  //   /// REMOVE DUPLICATES
  //   final uniqueImages = images.toSet().toList();
  //   for (int i = 0; i < uniqueImages.length; i++) {
  //     final img = uniqueImages[i];
  //   }

  //   return uniqueImages;
  // }

  // String _detectType(String? value) {
  //   if (value == null) return "NULL";

  //   if (value.startsWith("http")) return "URL";
  //   if (value.length > 1000) return "BASE64 (LIKELY)";
  //   if (value.contains("/")) return "FILE PATH?";
  //   return "UNKNOWN";
  // }

  // Future<void> _preloadImageSizes() async {
  //   final images = getImages();

  //   print("🚀 PRELOADING IMAGES");
  //   print("📦 IMAGE COUNT: ${images.length}");

  //   for (final url in images) {
  //     print(
  //       "🚨 PRELOAD INPUT => ${url.substring(0, url.length > 80 ? 80 : url.length)}",
  //     );
  //     if (_aspectRatioCache.containsKey(url)) {
  //       print("⚡ CACHE HIT: $url");
  //       continue;
  //     }

  //     try {
  //       print("🌐 LOADING SIZE: $url");

  //       // final image = Image.network(url);
  //       //final image = Image.file(File(url));
  //       final imageBytes = base64Decode(url);

  //       final image = Image.memory(imageBytes);
  //       final completer = Completer<Size>();

  //       image.image
  //           .resolve(const ImageConfiguration())
  //           .addListener(
  //             ImageStreamListener((info, _) {
  //               final size = Size(
  //                 info.image.width.toDouble(),
  //                 info.image.height.toDouble(),
  //               );

  //               completer.complete(size);
  //             }),
  //           );

  //       final size = await completer.future;

  //       _imageSizeCache[url] = size;
  //       _aspectRatioCache[url] = size.width / size.height;

  //       print("✅ SIZE SAVED: ${size.width} x ${size.height}");

  //       // if (mounted) {
  //       //   setState(() {});
  //       // }
  //     } catch (e) {
  //       print("❌ IMAGE SIZE ERROR");
  //       print("❌ URL: $url");
  //       print("❌ ERROR: $e");
  //     }
  //   }
  // }

  // /// 🔥 GET ASPECT RATIO
  // double getAspectRatio(String url) {
  //   return _aspectRatioCache[url] ?? 1.0;
  // }

  @override
  Widget build(BuildContext context) {
    final feed = widget.feed;
    final mediaUrls = _getMediaUrls();
    final activePage = mediaUrls.isNotEmpty && currentPage < mediaUrls.length
        ? currentPage
        : 0;
    // final images = getImages();
    //final logo = AppData.logo?.trim();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 TOP ROW
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   radius: 20,
              //   backgroundImage:
              //       (logo != null &&
              //           logo.isNotEmpty &&
              //           logo.toLowerCase() != "null" &&
              //           logo.startsWith("http"))
              //       ? NetworkImage(logo)
              //       : null,
              //   child:
              //       (logo == null ||
              //           logo.isEmpty ||
              //           logo.toLowerCase() == "null" ||
              //           !logo.startsWith("http"))
              //       ? const Icon(Icons.school)
              //       : null,
              // ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child:
                      (AppData.logo != null && AppData.logo!.trim().isNotEmpty)
                      ? Image.network(
                          AppData.logo!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.school, size: 24);
                          },
                        )
                      : const Icon(Icons.school, size: 24),
                ),
              ),
              // CircleAvatar(
              //   radius: 20,
              //   backgroundImage:
              //       (AppData.logo != null && AppData.logo!.trim().isNotEmpty)
              //       ? NetworkImage(AppData.logo ?? '')
              //       : null,
              //   child: (AppData.logo == null || AppData.logo!.trim().isEmpty)
              //       ? const Icon(Icons.school)
              //       : null,
              // ),
              // CircleAvatar(
              //   radius: 20,
              //   backgroundImage: NetworkImage(AppData.logo!),
              // ),
              //
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feed.postedBy ?? 'No Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          //color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        feed.designationName ?? "",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Text(
                  feed.createdTime ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        // if (images.isNotEmpty)
        //   SizedBox(
        //     width: double.infinity,
        //     child: AspectRatio(
        //       aspectRatio: getAspectRatio(images.first),
        //       child: PageView.builder(
        //         itemCount: images.length,
        //         onPageChanged: (index) {
        //           setState(() {
        //             currentPage = index;
        //           });
        //         },
        //         itemBuilder: (context, index) {
        //           final url = images[index];

        //           print("🖼 DISPLAYING IMAGE => $url");
        //           print("🖼 IMAGE PATH => $url");
        //           print("🖼 FILE EXISTS => ${File(url).existsSync()}");

        //           // return Image.file(
        //           //   File(url),
        //           //   fit: BoxFit.cover,
        //           //   // errorBuilder: (context, child, progress) {
        //           //   //   if (progress == null) {
        //           //   //     print("✅ IMAGE LOADED => $url");
        //           //   //     return child;
        //           //   //   }

        //           //   //   return const Center(child: CircularProgressIndicator());
        //           //   // },
        //           //   errorBuilder: (context, error, stackTrace) {
        //           //     print("❌ IMAGE LOAD FAILED");
        //           //     print("❌ URL => $url");
        //           //     print("❌ ERROR => $error");

        //           //     return const Center(
        //           //       child: Icon(Icons.broken_image, size: 40),
        //           //     );
        //           //   },
        //           // );
        //           final imageBytes = base64Decode(url);

        //           return Image.memory(imageBytes, fit: BoxFit.cover);
        //         },
        //       ),
        //     ),
        //   ),

        // // 🔹 IMAGE SECTION
        // if (feed.files != null && feed.files!.isNotEmpty)
        //   // if (images.isNotEmpty)
        //   Column(
        //     children: [
        //       FutureBuilder<Size>(
        //         future: _getImageSize(feed.files!.first.image ?? ""),
        //         builder: (context, snapshot) {
        //           if (!snapshot.hasData) {
        //             return const SizedBox(
        //               height: 200,
        //               child: Center(child: CircularProgressIndicator()),
        //             );
        //           }
        //           final size = snapshot.data!;
        //           final aspectRatio = size.width / size.height;
        //           return AspectRatio(
        //             aspectRatio: aspectRatio,
        //             child: PageView.builder(
        //               itemCount: feed.files!.length,
        //               onPageChanged: (index) {
        //                 setState(() {
        //                   currentPage = index;
        //                 });
        //               },
        //               itemBuilder: (context, index) {
        //                 final imageUrl = feed.files![index].image;
        //                 return Image.network(
        //                   imageUrl ?? "",
        //                   fit: BoxFit.cover,
        //                   width: double.infinity,
        //                 );
        //               },
        //             ),
        //           );
        //         },
        //       ),
        //       // SizedBox(
        //       //   width: double.infinity,
        //       //   child: AspectRatio(
        //       //     aspectRatio: getAspectRatio(images.first),
        //       //     child: PageView.builder(
        //       //       itemCount: images.length,
        //       //       onPageChanged: (index) {
        //       //         setState(() => currentPage = index);
        //       //       },
        //       //       itemBuilder: (context, index) {
        //       //         final url = images[index];

        //       //         return Image.network(
        //       //           url,
        //       //           fit: BoxFit.cover,
        //       //           loadingBuilder: (c, child, p) {
        //       //             if (p == null) return child;
        //       //             return const Center(child: CircularProgressIndicator());
        //       //           },
        //       //           errorBuilder: (c, e, s) {
        //       //             return const Icon(Icons.broken_image);
        //       //           },
        //       //         );
        //       //       },
        //       //     ),
        //       //   ),
        //       // ),

        //       /// 🔹 DOT INDICATOR
        //       if (feed.files!.length > 1)
        // if (images.length > 1)
        /// IMAGE + VIMEO VIDEO SECTION
        if (mediaUrls.isNotEmpty)
          Column(
            children: [
              FutureBuilder<double>(
                future: _getMediaAspectRatio(mediaUrls[activePage]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final aspectRatio = snapshot.data ?? 1.0;

                  return AspectRatio(
                    aspectRatio: aspectRatio <= 0 ? 1.0 : aspectRatio,
                    child: PageView.builder(
                      itemCount: mediaUrls.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final mediaUrl = mediaUrls[index];

                        if (_isVimeoMedia(mediaUrl)) {
                          final cleanedVideoUrl = _getCleanVimeoUrl(mediaUrl);

                          if (cleanedVideoUrl.isEmpty) {
                            return const Center(
                              child: Icon(Icons.videocam_off, size: 45),
                            );
                          }

                          return FeedVimeoThumbnailCard(
                            videoUrl: cleanedVideoUrl,
                          );
                        }

                        return Image.network(
                          mediaUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint("Image load error: $error");

                            return const Center(
                              child: Icon(Icons.broken_image, size: 45),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),

              if (mediaUrls.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    feed.files!.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(3),
                      width: currentPage == index ? 8 : 6,
                      height: currentPage == index ? 8 : 6,
                      decoration: BoxDecoration(
                        color: currentPage == index ? Colors.blue : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),

              /// 🔹 FEED TEXT
              // Padding(
              //   padding: const EdgeInsets.all(12),
              //   child: Text(
              //     feed.feedText ?? "",
              //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              //   ),
              // ),

              /// 🔹 ACTION ROW
              Row(
                children: [
                  IconButton(
                    icon: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isLiked ? Colors.red : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        'assets/images/Clip path group (3).png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                    onPressed: () async {
                      final loginResponse = await SharedPreferenceHelper()
                          .getLoginResponse();

                      final admissionId = loginResponse?.student?.admissionId;

                      if (admissionId == null) return;
                      final newValue = !isLiked;

                      context.read<FeedCubit>().feedAction(
                        FeedActionParameter(
                          admissionId: admissionId,
                          feedId: feed.feedId!,
                          branchId: feed.branchId!,
                          type: "like",
                          value: newValue,
                        ),
                      );

                      setState(() {
                        isLiked = newValue;
                        likeCount = newValue
                            ? likeCount + 1
                            : (likeCount > 0 ? likeCount - 1 : 0);
                      });
                    },
                  ),

                  Text(likeCount.toString()),

                  IconButton(
                    onPressed: sharePost,
                    icon: Image.asset('assets/images/Clip path group (2).png'),
                  ),
                  Text(feed.shareCount.toString()),
                ],
              ),
              Html(
                data: feed.feedText!.isEmpty ? 'No Description' : feed.feedText,
              ),
            ],
          ),
      ],
    );
  }

  List<String> _getMediaUrls() {
    final urls = <String>[];

    void addUrl(String? value) {
      if (value == null) return;

      final cleaned = value.trim();

      if (cleaned.isNotEmpty) {
        urls.add(cleaned);
      }
    }

    if (widget.feed.files != null && widget.feed.files!.isNotEmpty) {
      for (final file in widget.feed.files!) {
        addUrl(file.image);
      }
    }

    if (widget.feed.image != null && widget.feed.image!.isNotEmpty) {
      for (final image in widget.feed.image!) {
        addUrl(image);
      }
    }

    if (widget.feed.videoUrl != null && widget.feed.videoUrl!.isNotEmpty) {
      for (final video in widget.feed.videoUrl!) {
        addUrl(video);
      }
    }

    final uniqueUrls = urls.toSet().toList();

    debugPrint("════════ FEED MEDIA DEBUG ════════");
    debugPrint("FEED ID: ${widget.feed.feedId}");
    debugPrint("FILES COUNT: ${widget.feed.files?.length ?? 0}");
    debugPrint("IMAGE COUNT: ${widget.feed.image?.length ?? 0}");
    debugPrint("VIDEO COUNT: ${widget.feed.videoUrl?.length ?? 0}");
    debugPrint("FINAL MEDIA COUNT: ${uniqueUrls.length}");
    debugPrint("FINAL MEDIA URLS: $uniqueUrls");
    debugPrint("══════════════════════════════════");

    return uniqueUrls;
  }

  bool _isVimeoMedia(String? value) {
    if (value == null || value.trim().isEmpty) return false;

    final cleanedUrl = feedExtractIframeVideoUrl(value);

    if (cleanedUrl.isEmpty) return false;

    final uri = Uri.tryParse(cleanedUrl);

    if (uri == null) return false;

    return uri.host.contains('vimeo.com');
  }

  String _getCleanVimeoUrl(String value) {
    final extractedUrl = feedExtractIframeVideoUrl(value);

    if (extractedUrl.isEmpty) return '';

    return feedPrepareVimeoUrl(extractedUrl);
  }

  Future<double> _getMediaAspectRatio(String mediaUrl) async {
    if (mediaUrl.trim().isEmpty) return 1.0;

    if (_isVimeoMedia(mediaUrl)) {
      return _getIframeAspectRatio(mediaUrl) ?? 9 / 16;
    }

    try {
      final size = await _getImageSize(mediaUrl);

      if (size.width <= 0 || size.height <= 0) return 1.0;

      return size.width / size.height;
    } catch (e) {
      debugPrint("Media aspect ratio error: $e");
      return 1.0;
    }
  }

  double? _getIframeAspectRatio(String value) {
    try {
      final widthMatch = RegExp(r'''width=["']?(\d+)["']?''').firstMatch(value);

      final heightMatch = RegExp(
        r'''height=["']?(\d+)["']?''',
      ).firstMatch(value);

      if (widthMatch == null || heightMatch == null) return null;

      final width = double.tryParse(widthMatch.group(1) ?? '');
      final height = double.tryParse(heightMatch.group(1) ?? '');

      if (width == null || height == null) return null;
      if (width <= 0 || height <= 0) return null;

      return width / height;
    } catch (e) {
      return null;
    }
  }

  String getGenderImage() {
    final g = (AppData.gender ?? '').toLowerCase().trim();

    if (g == 'male') {
      return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
    } else if (g == 'female') {
      return "assets/icons/1f5debb8-6e36-4d25-bde8-526f4dd89820_removalai_preview.png";
    } else {
      return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
    }
  }

  Future<Size> _getImageSize(String url) async {
    final completer = Completer<Size>();

    final image = Image.network(url);

    image.image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            final myImage = info.image;

            completer.complete(
              Size(myImage.width.toDouble(), myImage.height.toDouble()),
            );
          }),
        );

    return completer.future;
  }

  //   Future<void> sharePost() async {
  //     try {
  //       String text = widget.feed.feedText ?? "";

  //       String finalText =
  //           """
  // $text

  // *Shared From Cristal App*
  // ${AppData.branchName ?? 'School Name'}
  // ${AppData.place ?? 'School Name'}

  // """;

  //       // if (widget.feed.files != null && widget.feed.files!.isNotEmpty) {
  //       //     final imageUrl = widget.feed.files!.first.image;
  //       final images = getImages();

  //       // if (images.isNotEmpty) {
  //       //   final response = await http.get(Uri.parse(images.first));

  //       //   final bytes = response.bodyBytes;

  //       //   final dir = await getTemporaryDirectory();

  //       //   final file = File('${dir.path}/shared_image.jpg');

  //       //   await file.writeAsBytes(bytes);

  //       //   await Share.shareXFiles([XFile(file.path)], text: finalText);
  //       // } else {
  //       //   await Share.share(finalText);
  //       // }
  //       // if (images.isNotEmpty) {
  //       //   final imagePath = images.first;
  //       if (images.isNotEmpty) {
  //         final base64String = images.first;

  //         final bytes = base64Decode(base64String);

  //         final dir = await getTemporaryDirectory();

  //         final file = File('${dir.path}/shared_image.jpg');

  //         await file.writeAsBytes(bytes);

  //         await Share.shareXFiles([XFile(file.path)], text: finalText);
  //       } else {
  //         await Share.share(finalText);
  //       }
  //       // if (imagePath.startsWith('http')) {
  //       //   final response = await http.get(Uri.parse(imagePath));

  //       //   final dir = await getTemporaryDirectory();

  //       //   final file = File('${dir.path}/shared_image.jpg');

  //       //   await file.writeAsBytes(response.bodyBytes);

  //       //   await Share.shareXFiles([XFile(file.path)], text: finalText);
  //       // } else {
  //       //   await Share.shareXFiles([XFile(imagePath)], text: finalText);
  //       // }
  //     } catch (e) {
  //       debugPrint("Share error: $e");
  //     }
  //   }
  Future<void> sharePost() async {
    try {
      String text = widget.feed.feedText ?? "";

      String finalText =
          """     
$text

Shared From Cristal App
${AppData.branchName ?? 'School Name'}
${AppData.place ?? 'School Name'}

""";

      if (widget.feed.files != null && widget.feed.files!.isNotEmpty) {
        final imageUrl = widget.feed.files!.first.image;

        final response = await http.get(Uri.parse(imageUrl!));

        final bytes = response.bodyBytes;

        final dir = await getTemporaryDirectory();

        final file = File('${dir.path}/shared_image.jpg');

        await file.writeAsBytes(bytes);

        await Share.shareXFiles([XFile(file.path)], text: finalText);
      } else {
        await Share.share(finalText);
      }
    } catch (e) {
      debugPrint("Share error: $e");
    }
  }
}

class FeedVimeoThumbnailCard extends StatelessWidget {
  final String videoUrl;

  const FeedVimeoThumbnailCard({super.key, required this.videoUrl});

  String getThumbnail() {
    try {
      final uri = Uri.parse(videoUrl);
      String videoId = '';

      if (uri.host.contains('player.vimeo.com')) {
        final videoIndex = uri.pathSegments.indexOf('video');

        if (videoIndex != -1 && uri.pathSegments.length > videoIndex + 1) {
          videoId = uri.pathSegments[videoIndex + 1];
        }
      } else if (uri.host.contains('vimeo.com')) {
        videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
      }

      return videoId.isEmpty ? '' : "https://vumbnail.com/$videoId.jpg";
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = getThumbnail();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FeedFullScreenVimeoPage(url: videoUrl),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
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

            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.35)),
            ),

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
                      "Watch Fullscreen",
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

class FeedFullScreenVimeoPage extends StatefulWidget {
  final String url;

  const FeedFullScreenVimeoPage({super.key, required this.url});

  @override
  State<FeedFullScreenVimeoPage> createState() =>
      _FeedFullScreenVimeoPageState();
}

class _FeedFullScreenVimeoPageState extends State<FeedFullScreenVimeoPage> {
  late final WebViewController controller;
  bool isLandscape = false;

  @override
  void initState() {
    super.initState();

    final preparedUrl = feedPrepareVimeoUrl(widget.url);

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadHtmlString(feedBuildCleanVimeoPlayerHtml(preparedUrl));

    if (controller.platform is AndroidWebViewController) {
      final androidController = controller.platform as AndroidWebViewController;

      AndroidWebViewController.enableDebugging(true);

      androidController.setMediaPlaybackRequiresUserGesture(false);
    }
  }

  Future<void> toggleRotation() async {
    setState(() {
      isLandscape = !isLandscape;
    });

    if (isLandscape) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = isLandscape ? 16 / 9 : 9 / 16;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isLandscape
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text("Video", style: TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.screen_rotation),
                  onPressed: toggleRotation,
                ),
              ],
            ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: WebViewWidget(controller: controller),
              ),
            ),

            if (isLandscape)
              Positioned(
                top: 12,
                left: 12,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

            if (isLandscape)
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  icon: const Icon(
                    Icons.screen_lock_portrait,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: toggleRotation,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // 👈 number of shimmer cards
      padding: const EdgeInsets.only(top: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 TOP ROW
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _box(width: 120, height: 12),
                            const SizedBox(height: 6),
                            _box(width: 80, height: 10),
                          ],
                        ),
                      ),

                      _box(width: 40, height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// 🔹 IMAGE
                Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.white,
                ),

                const SizedBox(height: 10),

                /// 🔹 TEXT
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(width: double.infinity, height: 14),
                      const SizedBox(height: 8),
                      _box(width: double.infinity, height: 14),
                      const SizedBox(height: 8),
                      _box(width: 200, height: 14),
                    ],
                  ),
                ),

                /// 🔹 ACTION ROW
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      _circle(),
                      const SizedBox(width: 8),
                      _box(width: 20, height: 12),
                      const SizedBox(width: 20),
                      _circle(),
                      const SizedBox(width: 8),
                      _box(width: 20, height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _box({required double width, required double height}) {
    return Container(width: width, height: height, color: Colors.white);
  }

  Widget _circle() {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}
