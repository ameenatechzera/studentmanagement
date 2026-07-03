import 'package:dio/dio.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/earlygo/data/models/fetch_earlygorequest_model.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/fetch_earlygo_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class EarlyLeaveRemoteDataSource {
  Future<FetchEarlyLeaveResponseModel> fetchEarlyLeave(FetchEarlyGoParameter request);
  Future<CommonResponseModel> saveEarlyLeave(SaveEarlyLeaveParameter params);
}

class EarlyLeaveRemoteDataSourceImpl implements EarlyLeaveRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchEarlyLeaveResponseModel> fetchEarlyLeave(FetchEarlyGoParameter request) async {
    print('📘 Fetch Early Leave Called');
    print('FetchEarlyGoParameter ${request.toJson()}');
    try {
      /// Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print('baseUrl => $baseUrl');

      /// Build API URL
      final url = ApiConstants.getEarlyLeavePath(baseUrl);

      print('url => $url');

      /// Auth Options
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.post(url, data: request.toJson(), options: options);

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      /// Parse Response
      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchEarlyLeaveResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchEarlyLeave: $e');
      print(stacktrace);
      rethrow;
    }
  }

  @override
  Future<CommonResponseModel> saveEarlyLeave(
    SaveEarlyLeaveParameter params,
  ) async {
    print('📘 Save Early Leave Called');
    print('📘 Params: ${params.toJson()}');

    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.saveEarlyLeavePath(baseUrl);

      print('📘 URL: $url');

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in saveEarlyLeave: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
