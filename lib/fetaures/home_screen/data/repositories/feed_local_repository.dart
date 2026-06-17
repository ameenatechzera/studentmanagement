import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

import '../local/entity/feed_table.dart';
import '../local/dao/feed_dao.dart';

class FeedLocalRepository {
  final FeedDao dao;

  FeedLocalRepository(this.dao);
  // 👇 ADD THIS METHOD HERE
  // Future<String?> downloadImage(String url) async {
  //   try {
  //     final dir = await getApplicationDocumentsDirectory();

  //     final fileName = url.split('/').last;

  //     final filePath = '${dir.path}/$fileName';

  //     final response = await Dio().download(url, filePath);

  //     if (response.statusCode == 200) {
  //       print("✅ IMAGE DOWNLOADED => $filePath");
  //       return filePath;
  //     }

  //     return null;
  //   } catch (e) {
  //     print("❌ DOWNLOAD ERROR => $e");
  //     return null;
  //   }
  // }
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
  // Future<void> saveFeeds(List<FeedDetails> feeds) async {
  //   print("🔥 SAVE FEEDS CALLED: ${feeds.length}");

  //   for (final feed in feeds) {
  //     print("➡️ LOOP ENTERED: ${feed.feedId}");

  //     final entity = FeedTable(
  //       feedId: feed.feedId ?? 0,
  //       feedJson: jsonEncode(feed.toJson()),
  //     );

  //     print("💾 INSERTING: ${entity.feedId}");

  //     try {
  //       await dao.insertFeed(entity);
  //       print("✅ INSERT SUCCESS: ${entity.feedId}");
  //     } catch (e) {
  //       print("❌ INSERT ERROR: $e");
  //     }
  //   }

  //   final result = await dao.getAllFeeds();
  //   print("📦 FINAL DB COUNT: ${result.length}");
  // }
  // Future<void> saveFeeds(List<FeedDetails> feeds) async {
  //   print("🔥 ================= SAVE FEEDS START =================");
  //   print("📥 INPUT FEEDS COUNT: ${feeds.length}");

  //   for (int i = 0; i < feeds.length; i++) {
  //     final feed = feeds[i];

  //     print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  //     print("➡️ INDEX: $i");
  //     print("🆔 RAW FEED ID: ${feed.feedId}");
  //     print("📝 FEED TEXT: ${feed.feedText}");
  //     print("🖼 IMAGE COUNT: ${feed.image?.length ?? 0}");

  //     // ⚠️ CRITICAL CHECK
  //     if (feed.feedId == null) {
  //       print("❌ SKIPPED: feedId is NULL (this will break DB)");
  //       continue;
  //     }

  //     final entity = FeedTable(
  //       feedId: feed.feedId!, // safer now
  //       feedJson: jsonEncode(feed.toJson()),
  //     );

  //     print("💾 ENTITY CREATED");
  //     print("➡️ ENTITY ID: ${entity.feedId}");
  //     print("📦 JSON SIZE: ${entity.feedJson.length}");

  //     try {
  //       await dao.insertFeed(entity);
  //       print("✅ INSERT SUCCESS: ID ${entity.feedId}");
  //     } catch (e) {
  //       print("❌ INSERT FAILED FOR ID ${entity.feedId}");
  //       print("❌ ERROR: $e");
  //     }
  //   }

  //   print("\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
  //   print("🔍 VERIFYING DATABASE CONTENT...");

  //   final result = await dao.getAllFeeds();

  //   print("📦 FINAL DB COUNT: ${result.length}");

  //   for (var i = 0; i < result.length; i++) {
  //     final item = result[i];
  //     print("➡️ DB[$i] ID: ${item.feedId}");
  //   }

  //   print("🔥 ================= SAVE FEEDS END =================\n");
  // }
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
  // Future<void> saveFeeds(List<FeedDetails> feeds) async {
  //   for (var feed in feeds) {
  //     List<String> localImages = [];

  //     if (feed.image != null) {
  //       for (final url in feed.image!) {
  //         final localPath = await downloadImage(url);

  //         if (localPath != null) {
  //           localImages.add(localPath);
  //         }
  //       }
  //     }

  //     final updatedFeed = FeedDetails(
  //       feedId: feed.feedId,
  //       feedText: feed.feedText,
  //       feedTarget: feed.feedTarget,
  //       standardId: feed.standardId,
  //       userId: feed.userId,
  //       branchId: feed.branchId,
  //       accYear: feed.accYear,
  //       createdDate: feed.createdDate,
  //       createdUser: feed.createdUser,
  //       modifiedDate: feed.modifiedDate,
  //       modifiedUser: feed.modifiedUser,
  //       files: feed.files,
  //       image: localImages, // <-- LOCAL PATHS
  //       videoUrl: feed.videoUrl,
  //       postedBy: feed.postedBy,
  //       designationName: feed.designationName,
  //       classStandardId: feed.classStandardId,
  //       classDivisionId: feed.classDivisionId,
  //       classStandardName: feed.classStandardName,
  //       classDivisionName: feed.classDivisionName,
  //       subjects: feed.subjects,
  //       likeCount: feed.likeCount,
  //       shareCount: feed.shareCount,
  //       isLiked: feed.isLiked,
  //       createdDateFormatted: feed.createdDateFormatted,
  //       createdTime: feed.createdTime,
  //       modifiedDateFormatted: feed.modifiedDateFormatted,
  //       modifiedTime: feed.modifiedTime,
  //     );

  //     await dao.insertFeed(
  //       FeedTable(
  //         feedId: feed.feedId!,
  //         feedJson: jsonEncode(updatedFeed.toJson()),
  //       ),
  //     );
  //   }
  // }
  // Future<void> saveFeeds(List<FeedDetails> feeds) async {
  //   for (var feed in feeds) {
  //     print("FEED ID => ${feed.feedId}");

  //     // 👇 ADD THIS HERE
  //     if (feed.image != null && feed.image!.isNotEmpty) {
  //       final localPath = await downloadImage(feed.image!.first);

  //       print("🌟 LOCAL PATH => $localPath");
  //     }

  //     final jsonString = jsonEncode(feed.toJson());

  //     await dao.insertFeed(
  //       FeedTable(feedId: feed.feedId!, feedJson: jsonString),
  //     );
  //   }
  // }

  // Future<List<FeedDetails>> getFeeds() async {
  //   final result = await dao.getAllFeeds();

  //   return result.map((e) {
  //     final json = jsonDecode(e.feedJson);

  //     return FeedDetails(
  //       feedId: json['feedId'],
  //       feedText: json['feedText'],
  //       image: (json['image'] as List?)?.cast<String>(),
  //       videoUrl: (json['videoUrl'] as List?)?.cast<String>(),
  //       likeCount: json['likeCount'],
  //       shareCount: json['shareCount'],
  //       isLiked: json['isLiked'],
  //       createdDateFormatted: json['createdDateFormatted'],
  //       createdTime: json['createdTime'],
  //     );
  //   }).toList();
  // }
  // Future<List<FeedDetails>> getFeeds() async {
  //   final result = await dao.getAllFeeds();

  //   return result.map((e) {
  //     final json = jsonDecode(e.feedJson);

  //     return FeedDetails.fromJson(json); // 🔥 FULL RESTORE
  //   }).toList();
  // }
  // Future<List<FeedDetails>> getFeeds() async {
  //   final result = await dao.getAllFeeds();

  //   return result.map((e) {
  //     final json = jsonDecode(e.feedJson);

  //     print("🔥 RAW FLOOR JSON => $json");

  //     final feed = FeedDetails.fromJson(json);

  //     print("🔥 RESTORED IMAGE => ${feed.image}");

  //     return feed;
  //   }).toList();
  // }
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
