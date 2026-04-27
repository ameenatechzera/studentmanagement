import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class FeedRemoteDataSource {
  Future<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params);
  Future<FeedActionResponseModel> feedAction(FeedActionParameter params);
}

// class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
//   final Dio dio = Dio();

//   @override
//   Future<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params) async {
//     print('📘 Fetch Feed Called ${params.toJson()}');

//     try {
//       /// 🔹 Get Base URL
//       final baseUrl = await SharedPreferenceHelper().getBaseUrl();
//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception("Base URL not set");
//       }

//       /// 🔹 Build API URL
//       final url = ApiConstants.getFeedPath(baseUrl);
//       print('path $url');

//       /// 🔹 Get Token
//       final token = await SharedPreferenceHelper().getToken() ?? "";
//       print(token);

//       /// 🔹 API CALL (GET or POST → based on your backend)
//       final response = await dio.post(
//         url,
//         data: params.toJson(),
//         options: Options(
//           contentType: "application/json",
//           headers: {
//             "Accept": "application/json",
//             "Authorization": "Bearer $token",
//           },
//         ),
//       );

//       // print('📘 Status Code: ${response.statusCode}');
//       // print('📘 Response Data: ${response.data}');
//       // print("FULL URL: $url");

//       /// 🔹 Parse Response
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // print("URL: $url");
//         // print("BODY: ${params.toJson()}");
//         // print("TOKEN: $token");
//         print("RESPONSE: ${response.data}");
//         return FetchFeedResponseModel.fromJson(response.data);
//       } else {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(response.data),
//         );
//       }
//     } catch (e, stacktrace) {
//       print('❌ Exception in fetchFeeds: $e');
//       print(stacktrace);
//       rethrow;
//     }
//   }

//   @override
//   Future<FeedActionResponseModel> feedAction(FeedActionParameter params) async {
//     print('📘 Feed Action Called ${params.toString()}');

//     try {
//       /// 🔹 Base URL
//       final baseUrl = await SharedPreferenceHelper().getBaseUrl();
//       if (baseUrl == null || baseUrl.isEmpty) {
//         throw Exception("Base URL not set");
//       }

//       /// 🔹 URL (add your endpoint here)
//       final url = ApiConstants.feedActionPath(baseUrl);

//       print('📘 URL: $url');

//       /// 🔹 Token
//       final token = await SharedPreferenceHelper().getToken() ?? "";
//       print('TOKEN: $token');

//       /// 🔹 API CALL
//       final response = await dio.post(
//         url,
//         data: params,
//         options: Options(
//           contentType: "application/json",
//           headers: {
//             "Accept": "application/json",
//             "Authorization": "Bearer $token",
//           },
//         ),
//       );

//       print('📘 Status Code: ${response.statusCode}');
//       print('📘 Response: ${response.data}');

//       /// 🔹 Success
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         return FeedActionResponseModel.fromJson(response.data);
//       } else {
//         throw ServerException(
//           errorMessageModel: ErrorMessageModel.fromJson(response.data),
//         );
//       }
//     } catch (e, stacktrace) {
//       print('❌ Feed Action Exception: $e');
//       print(stacktrace);
//       rethrow;
//     }
//   }
// }
class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params) async {
    print('\n📘 Fetch Feed Called ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getFeedPath(baseUrl);
      print('🌐 URL: $url');

      final token = await SharedPreferenceHelper().getToken() ?? "";
      print('🔐 TOKEN: $token');
      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
        // options: Options(
        //   contentType: "application/json",
        //   headers: {
        //     "Accept": "application/json",
        //     "Authorization": "Bearer $token",
        //   },
        // ),
      );

      print('\n🔥 RAW RESPONSE TYPE: ${response.data.runtimeType}');
      print('🔥 RAW RESPONSE FULL: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dataList = response.data['data'];

        print('\n📦 TOTAL ITEMS: ${dataList.length}');

        /// 🔥 LOOP ALL ITEMS
        for (var item in dataList) {
          print(
            "➡️ RAW ITEM → feedId: ${item['feedId']} | IsLiked: ${item['IsLiked']} | TYPE: ${item['IsLiked'].runtimeType}",
          );
        }

        /// 🔥 CHECK SPECIFIC ITEM (feedId: 2)
        try {
          final feed2 = dataList.firstWhere((e) => e['feedId'] == 2);

          print('\n🎯 CHECK feedId 2:');
          print("FULL ITEM: $feed2");
          print("IsLiked VALUE: ${feed2['IsLiked']}");
          print("IsLiked TYPE: ${feed2['IsLiked'].runtimeType}");
        } catch (e) {
          print("⚠️ feedId 2 NOT FOUND");
        }

        print('\n✅ SENDING TO MODEL PARSE');

        return FetchFeedResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchFeeds: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<FeedActionResponseModel> feedAction(FeedActionParameter params) async {
    print('\n📘 Feed Action Called ${params.toString()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.feedActionPath(baseUrl);
      print('🌐 ACTION URL: $url');

      final token = await SharedPreferenceHelper().getToken() ?? "";
      print('🔐 TOKEN: $token');

      print('📤 REQUEST BODY: ${params.toJson()}');
      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
        // options: Options(
        //   contentType: "application/json",
        //   headers: {
        //     "Accept": "application/json",
        //     "Authorization": "Bearer $token",
        //   },
        // ),
      );

      print('\n🔥 ACTION RAW RESPONSE: ${response.data}');
      print('🔥 ACTION STATUS: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];

        print('\n❤️ ACTION PARSED:');
        print("feedId: ${data['feedId']}");
        print("is_Liked: ${data['is_Liked']}");
        print("like_count: ${data['like_count']}");

        return FeedActionResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Feed Action Exception: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
