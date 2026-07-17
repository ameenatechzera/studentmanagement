import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/device_register_model.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/getbranch_model.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/getschool_model.dart';
import 'package:studentmanagement/fetaures/authentication/data/models/login_status_model.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getbranch_entitiy.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/register_server_response_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_status_parameter.dart';
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
  Future<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request);
  Future<GetBranchEntity> getBranchDetails();
  Future<LoginStatusModel> loginStatus(LoginStatusParameter parameter);
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

  // @override
  // Future<LoginResponseResult> loginServer(LoginRequest params) async {
  //   try {
  //     final baseUrl = await SharedPreferenceHelper().getBaseUrl();
  //     if (baseUrl == null || baseUrl.isEmpty) {
  //       throw Exception("Base URL not set");
  //     }
  //     // final dbName = await SharedPreferenceHelper().getDatabaseName();
  //     // final url = ApiConstants.getLoginPath(baseUrl);
  //     final url = ApiConstants.getLoginPath(baseUrl);
  //     final options = await ApiHelper.getAuthOptions();

  //     print('🔹 Login URL: $url');
  //     print('🔹 Request Body: ${params.toJson()}');
  //     //  print('🔹 dbName: $dbName');
  //     // print('🔹 token: $dbName');

  //     final response = await dio.post(
  //       url,
  //       data: params.toJson(),
  //       options: options,
  //       // options: Options(
  //       //   contentType: "application/json",
  //       //   headers: {"Accept": "application/json", "X-Database-Name": dbName},
  //       // ),
  //     );
  //     debugPrint(response.data.toString(), wrapWidth: 1024);

  //     print('🔹 Status Code: ${response.statusCode}');
  //     print('🔹 ResponseLogin Data: ${response.data}');

  //     if (response.statusCode == 200) {
  //       return LoginResponseResult.fromJson(response.data);
  //     } else {
  //       if (response.statusCode == 401) {
  //         throw ServerException(
  //           errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //         );
  //       }
  //       throw ServerException(
  //         errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //       );
  //     }
  //   } catch (e, stacktrace) {
  //     print('❌ Exception during loginServer: $e');
  //     print('Stacktrace: $stacktrace');
  //     rethrow;
  //   }
  // }
  @override
  Future<LoginResponseResult> loginServer(LoginRequest params) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getLoginPath(baseUrl);
      final options = await ApiHelper.getAuthOptions();

      print("\n================ LOGIN REQUEST ================");
      print("URL            : $url");
      print("Method         : POST");
      print("Headers        : ${options.headers}");
      print("Content Type   : ${options.contentType}");
      print("Request Body   : ${params.toJson()}");
      print("===============================================\n");

      final response = await dio.post(
        url,
        data: params.toJson(),
        options: options,
      );

      print("\n================ LOGIN RESPONSE ================");
      print("Status Code    : ${response.statusCode}");
      print("Status Message : ${response.statusMessage}");
      print("Response Header: ${response.headers}");
      print("Response Data  : ${response.data}");
      print("===============================================\n");

      if (response.statusCode == 200) {
        return LoginResponseResult.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e, stackTrace) {
      print("\n================ DIO EXCEPTION =================");
      print("Error Type      : ${e.type}");
      print("Message         : ${e.message}");

      print("\n--------------- REQUEST ----------------");
      print("URL             : ${e.requestOptions.uri}");
      print("Method          : ${e.requestOptions.method}");
      print("Headers         : ${e.requestOptions.headers}");
      print("Request Data    : ${e.requestOptions.data}");

      if (e.response != null) {
        print("\n--------------- RESPONSE ----------------");
        print("Status Code     : ${e.response?.statusCode}");
        print("Status Message  : ${e.response?.statusMessage}");
        print("Headers         : ${e.response?.headers}");
        print("Response Data   : ${e.response?.data}");
      } else {
        print("\nNo response received from server.");
      }

      print("\n--------------- STACKTRACE ---------------");
      print(stackTrace);
      print("===============================================\n");

      rethrow;
    } catch (e, stackTrace) {
      print("\n============== GENERAL EXCEPTION ==============");
      print("Exception       : $e");
      print("StackTrace      : $stackTrace");
      print("==============================================\n");

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

  @override
  Future<FetchSchoolEntity> fetchSchools(FetchSchoolRequest request) async {
    try {
      // final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      // if (baseUrl == null || baseUrl.isEmpty) {
      //   throw Exception("Base URL not set");
      // }

      //  final url = ApiConstants.getFetchSchoolPath(baseUrl);
      final url = "https://online.cristaledu.com/Api/public/api/get-school";
      print('🔹 Fetch School URL: $url');
      print('🔹 Request Body: ${request.toJson()}');

      final response = await dio.post(
        url,
        data: request.toJson(),
        options: Options(
          contentType: "application/json",
          headers: {"Accept": "application/json"},
        ),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return FetchSchoolResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during fetchSchools: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

  @override
  Future<GetBranchEntity> getBranchDetails() async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }
      print('baseUrlBranch $baseUrl');

      // final dbName = await SharedPreferenceHelper().getDatabaseName();

      // final url = ApiConstants.getBranchDetailsPath(baseUrl);
      // final url = ApiConstants.getBranchDetailsPath(baseUrl);
      // final url =
      //     "https://online.cristaledu.com/Api/public/api/app/branch-byid/1";
      final url = baseUrl + "app/branch-byid/1";
      final options = await ApiHelper.getAuthOptions();

      print('🔹 Get Branch URL: $url');
      // print('🔹 Get Branch URL: $url');
      // print('🔹 dbName: $dbName');

      final response = await dio.get(
        url,
        options: options,
        // options: Options(
        //   contentType: "application/json",
        //   headers: {
        //     "Accept": "application/json",
        //     "X-Database-Name": dbName, // ✅ IMPORTANT
        //   },
        // ),
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return GetBranchResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during getBranchDetails: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

  @override
  Future<LoginStatusModel> loginStatus(LoginStatusParameter parameter) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final url = ApiConstants.getSaveLoginStatusPath(baseUrl);
      final options = await ApiHelper.getAuthOptions();

      final response = await dio.post(
        url,
        data: parameter.toJson(),
        options: options,
      );

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return LoginStatusModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during getBranchDetails: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
