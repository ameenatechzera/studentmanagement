import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    isLiked = widget.feed.isLiked ?? false;
    likeCount = widget.feed.likeCount ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final feed = widget.feed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 TOP ROW
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(AppData.logo!),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    (AppData.profileUrl != null &&
                        AppData.profileUrl!.isNotEmpty)
                    ? NetworkImage(AppData.profileUrl!)
                    : null,
                child:
                    (AppData.profileUrl == null || AppData.profileUrl!.isEmpty)
                    ? ClipOval(
                        child: Image.asset(
                          getGenderImage(),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      )
                    : null,
              ),
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

        /// 🔹 IMAGE SECTION
        if (feed.files != null && feed.files!.isNotEmpty)
          Column(
            children: [
              FutureBuilder<Size>(
                future: _getImageSize(feed.files!.first.image ?? ""),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final size = snapshot.data!;
                  final aspectRatio = size.width / size.height;

                  return AspectRatio(
                    aspectRatio: aspectRatio,
                    child: PageView.builder(
                      itemCount: feed.files!.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final imageUrl = feed.files![index].image;

                        return Image.network(
                          imageUrl ?? "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  );
                },
              ),

              /// 🔹 DOT INDICATOR
              if (feed.files!.length > 1)
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
            ],
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
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            feed.feedText ?? "",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
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

  Future<void> sharePost() async {
    try {
      String text = widget.feed.feedText ?? "";

      String finalText =
          """     
$text

*Shared From Cristal App*
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
