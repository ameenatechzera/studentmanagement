import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/device_register_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/register_server_response_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/register_server_params.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class AuthRemoteDataSource {
  Future<RegisterResponseResult> registerServer(
    RegisterServerRequest registerServerParams,
  );
  Future<LoginResponseResult> loginServer(LoginRequest loginRequest);
  Future<DeviceRegisterResult> checkDeviceRegisterStatus(
    DeviceRegisterRequest request,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<RegisterResponseResult> registerServer(
    RegisterServerRequest registerServerParams,
  ) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getRegisterServerPath(baseUrl!);
    print('Register URL: $url');
    print('Request Body: ${registerServerParams.toJson()}');

    print(registerServerParams);
    final response = await dio.post(
      ApiConstants.getRegisterServerPath(baseUrl),
      options: Options(contentType: "application/json"),
      data: registerServerParams.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    if (response.statusCode == 200) {
      return RegisterResponseResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<LoginResponseResult> loginServer(LoginRequest params) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }
      final dbName = await SharedPreferenceHelper().getDatabaseName();
      final url = ApiConstants.getLoginPath(baseUrl);
      print('🔹 Login URL: $url');
      print('🔹 Request Body: ${params.toJson()}');
      print('🔹 dbName: $dbName');
      print('🔹 token: $dbName');

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {"Accept": "application/json", "X-Database-Name": dbName},
        ),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return LoginResponseResult.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during loginServer: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

  @override
  Future<DeviceRegisterResult> checkDeviceRegisterStatus(
    DeviceRegisterRequest request,
  ) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();
      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }
      final dbName = await SharedPreferenceHelper().getDatabaseName();
      final url = ApiConstants.getDeviceRegisterStatusPath(baseUrl);
      print('🔹 Login URL: $url');
      print('🔹 Request Body: ${request.toJson()}');
      print('🔹 dbName: $dbName');

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {"Accept": "application/json", "X-Database-Name": dbName},
        ),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return DeviceRegisterModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during loginServer: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
