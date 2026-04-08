import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/helper/homescreen_helper.dart';

class PostCard extends StatelessWidget {
  final FeedDetails feed;

  const PostCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final imageUrl = feed.files != null && feed.files!.isNotEmpty
        ? feed.files!.first.image
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Top Row
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/fsp_logo.png'),
                ),

                const SizedBox(width: 10),

                /// TEXT SECTION
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "FSP",
                        style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        TimeAgoHelper.getFeedTime(
                          createdDate: feed.createdDate,
                          modifiedDate: feed.modifiedDate,
                        ),
                        style: const TextStyle(
                          fontSize: 12,
                          // color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                /// RIGHT SIDE TIME (optional)
                Text(
                  feed.createdTime ?? "",
                  style: TextStyle(
                    fontSize: 12,
                    // color: Colors.white,
                  ), // Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),

        /// 🔹 Image (only if exists)
        if (imageUrl != null)
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

        /// 🔹 Text
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  feed.feedText ?? "",
                  style: const TextStyle(
                    //color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // const Icon(Icons.favorite_border),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
              // color: Colors.white,
            ),
            Text('30k'), // style: TextStyle(color: Colors.white)),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                sharePost();
              },
            ),
            Text('20'), //style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }

  Future<void> sharePost() async {
    try {
      String text = feed.feedText ?? "";

      String finalText =
          """
$text

*Shared From Cristal App* 
FSP School, Saudi Arabia
""";

      if (feed.files != null && feed.files!.isNotEmpty) {
        final imageUrl = feed.files!.first.image;

        // Download image
        final response = await http.get(Uri.parse(imageUrl!));
        final bytes = response.bodyBytes;

        // Save to temp file
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/shared_image.jpg');
        await file.writeAsBytes(bytes);

        // Share image + text
        await Share.shareXFiles([XFile(file.path)], text: finalText);
      } else {
        // Share only text
        await Share.share(finalText);
      }
    } catch (e) {
      print("Share error: $e");
    }
  }
}
