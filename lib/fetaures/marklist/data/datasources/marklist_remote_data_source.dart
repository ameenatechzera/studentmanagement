import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_examterm_model.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_marklist_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class MarkListRemoteDataSource {
  Future<FetchExamTermResponseModel> fetchExamTerms();
  Future<FetchMarkListResponseModel> fetchMarkList(
    FetchMarkListParameter params,
  );
}

class MarkListRemoteDataSourceImpl implements MarkListRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchExamTermResponseModel> fetchExamTerms() async {
    print('📘 Fetch Exam Terms Called');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getExamTermPath(baseUrl);

      /// 🔹 Get Token
      final token = await SharedPreferenceHelper().getToken() ?? "";

      /// 🔹 API Call
      final response = await dio.get(
        url,
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
        return FetchExamTermResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchExamTerms: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<FetchMarkListResponseModel> fetchMarkList(
    FetchMarkListParameter params,
  ) async {
    print('📘 Fetch MarkList Called');
    print('FetchMarkListParameter ${params.toJson()}');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getMarkListPath(baseUrl);

      /// 🔹 Get Token
      final token = await SharedPreferenceHelper().getToken() ?? "";

      /// 🔹 Request Body (important 🔥)

      /// 🔹 API Call (usually POST for this type)
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

      /// 🔹 Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchMarkListResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchMarkList: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
