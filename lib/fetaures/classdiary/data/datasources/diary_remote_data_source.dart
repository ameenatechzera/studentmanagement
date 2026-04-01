import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class DiaryRemoteDataSource {
  Future<FetchDiaryResponseModel> fetchDiary(FetchDiaryParameter params);
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchDiaryResponseModel> fetchDiary(FetchDiaryParameter params) async {
    print('📘 Fetch Diary Called');
    print('FetchDiaryParameter ${params.toJson()}');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getDiaryFetchPath(baseUrl);
      final token = await SharedPreferenceHelper().getToken() ?? "";
      print('token $token');
      print('url $url');

      /// 🔹 POST Request
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
      print("REQUEST BODY: ${params.toJson()}");
      print("FULL URL: $url");

      /// 🔹 Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchDiaryResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchDiary: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
