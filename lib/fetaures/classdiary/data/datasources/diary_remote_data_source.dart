import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/diarystatusSaveRequest.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class DiaryRemoteDataSource {
  Future<FetchDiaryResponseModel> fetchDiary(FetchDiaryParameter params);
  Future<CommonResponseModel> saveDiaryStatus(SaveDiaryStatusParameter params);

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
      // final token = await SharedPreferenceHelper().getToken() ?? "";
      //  print('token $token');
      print('url $url');
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// 🔹 POST Request
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,

      );

      print('📘 Status Code: ${response.statusCode}');
      final responseString = jsonEncode(response.data);

      const chunkSize = 800;

      for (int i = 0; i < responseString.length; i += chunkSize) {
        print(
          responseString.substring(
            i,
            i + chunkSize > responseString.length
                ? responseString.length
                : i + chunkSize,
          ),
        );
      }
      // print(jsonEncode(response.data));
      // print('📘 Response Data: ${response.data}');
      // print("REQUEST BODY: ${params.toJson()}");
      // print("FULL URL: $url");

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

  @override
  Future<CommonResponseModel> saveDiaryStatus(SaveDiaryStatusParameter params) async {
    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getDiaryStatusSavePath(baseUrl);
      // final token = await SharedPreferenceHelper().getToken() ?? "";
      //  print('token $token');
      print('url $url');
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// 🔹 POST Request
      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,

      );

      print('📘 Status Code: ${response.statusCode}');
      final responseString = jsonEncode(response.data);

      const chunkSize = 800;

      for (int i = 0; i < responseString.length; i += chunkSize) {
        print(
          responseString.substring(
            i,
            i + chunkSize > responseString.length
                ? responseString.length
                : i + chunkSize,
          ),
        );
      }
      // print(jsonEncode(response.data));
      // print('📘 Response Data: ${response.data}');
      // print("REQUEST BODY: ${params.toJson()}");
      // print("FULL URL: $url");

      /// 🔹 Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommonResponseModel.fromJson(response.data);
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
