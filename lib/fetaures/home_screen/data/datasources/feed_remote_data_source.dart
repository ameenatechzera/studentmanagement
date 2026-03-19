import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class FeedRemoteDataSource {
  Future<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params);
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchFeedResponseModel> fetchFeeds(FetchFeedParameter params) async {
    print('📘 Fetch Feed Called');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getFeedPath(baseUrl);

      /// 🔹 Get Token
      final token = await SharedPreferenceHelper().getToken() ?? "";

      /// 🔹 API CALL (GET or POST → based on your backend)
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');
      print("FULL URL: $url");

      /// 🔹 Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("URL: $url");
        print("BODY: ${params.toJson()}");
        print("TOKEN: $token");
        print("RESPONSE: ${response.data}");
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
}
