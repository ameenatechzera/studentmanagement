import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

import '../local/entity/feed_table.dart';
import '../local/dao/feed_dao.dart';

class FeedLocalRepository {
  final FeedDao dao;

  FeedLocalRepository(this.dao);

  Future<String?> downloadImage(String url) async {
    try {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        return base64Encode(response.data);
      }

      return null;
    } catch (e) {
      print("❌ DOWNLOAD ERROR => $e");
      return null;
    }
  }

  Future<void> saveFeeds(List<FeedDetails> feeds) async {
    print("🔥 SAVE FEEDS CALLED: ${feeds.length}");

    for (final feed in feeds) {
      print("➡️ FEED ID: ${feed.feedId}");

      if (feed.feedId == null) {
        print("❌ SKIPPED NULL ID");
        continue;
      }

      //List<String> localImages = [];
      List<String> base64Images = [];
      // 🔥 DOWNLOAD IMAGES FIRST
      if (feed.image != null && feed.image!.isNotEmpty) {
        for (final url in feed.image!) {
          print("🌐 DOWNLOADING IMAGE: $url");

          final base64Image = await downloadImage(url);

          if (base64Image != null) {
            base64Images.add(base64Image);
          } else {
            print("❌ DOWNLOAD FAILED: $url");
          }
        }
      }

      final updatedFeed = FeedDetails(
        feedId: feed.feedId!,
        feedText: feed.feedText,
        feedTarget: feed.feedTarget,
        standardId: feed.standardId,
        userId: feed.userId,
        branchId: feed.branchId,
        accYear: feed.accYear,
        createdDate: feed.createdDate,
        createdUser: feed.createdUser,
        modifiedDate: feed.modifiedDate,
        modifiedUser: feed.modifiedUser,
        files: feed.files,
        image: base64Images, // ✅ LOCAL PATHS ONLY
        videoUrl: feed.videoUrl,
        postedBy: feed.postedBy,
        designationName: feed.designationName,
        classStandardId: feed.classStandardId,
        classDivisionId: feed.classDivisionId,
        classStandardName: feed.classStandardName,
        classDivisionName: feed.classDivisionName,
        subjects: feed.subjects,
        likeCount: feed.likeCount,
        shareCount: feed.shareCount,
        isLiked: feed.isLiked,
        createdDateFormatted: feed.createdDateFormatted,
        createdTime: feed.createdTime,
        modifiedDateFormatted: feed.modifiedDateFormatted,
        modifiedTime: feed.modifiedTime,
      );

      final entity = FeedTable(
        feedId: updatedFeed.feedId!,
        feedJson: jsonEncode(updatedFeed.toJson()),
      );

      try {
        await dao.insertFeed(entity);
        print("✅ SAVED WITH LOCAL IMAGE: ${entity.feedId}");
        print("BASE64 START => ${base64Images.first.substring(0, 50)}");
      } catch (e) {
        print("❌ INSERT ERROR: $e");
      }
    }

    final result = await dao.getAllFeeds();
    print("📦 FINAL DB COUNT: ${result.length}");
  }

  Future<List<FeedDetails>> getFeeds() async {
    final result = await dao.getAllFeeds();

    print("========== DAO ORDER ==========");
    for (final item in result) {
      print("DAO FEED ID => ${item.feedId}");
    }

    final feeds = result.map((e) {
      final json = jsonDecode(e.feedJson);
      return FeedDetails.fromJson(json);
    }).toList();

    print("========== AFTER MAPPING ==========");
    for (final item in feeds) {
      print("FEED ID => ${item.feedId}");
    }

    return feeds;
  }

  Future<void> clearFeeds() async {
    await dao.clearFeeds();
  }
}
