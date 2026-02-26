import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/timetable/data/models/fetch_timetable_model.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class TimeTableRemoteDataSource {
  Future<FetchTimeTableResponseModel> fetchTimeTable(
    FetchTimeTableParameter params,
  );
}

class TimeTableRemoteDataSourceImpl implements TimeTableRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchTimeTableResponseModel> fetchTimeTable(
    FetchTimeTableParameter params,
  ) async {
    print('📘 Fetch TimeTable Called');

    try {
      /// 🔹 Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      /// 🔹 Build API URL
      final url = ApiConstants.getTimeTablePath(baseUrl);

      /// 🔹 Get Headers Data
      // final dbName = await SharedPreferenceHelper().getDatabaseName();
      final token = await SharedPreferenceHelper().getToken() ?? "";

      // if (token.isEmpty) {
      //   throw Exception("Token missing! Please login again.");
      // }

      /// 🔹 GET Request
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
        return FetchTimeTableResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchTimeTable: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
