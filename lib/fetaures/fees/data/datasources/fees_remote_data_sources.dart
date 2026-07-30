import 'package:dio/dio.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/domain/entities/common_response_entity.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/core/network/dio_client.dart';
import 'package:studentmanagement/fetaures/fees/data/models/accYearListModel.dart';
import 'package:studentmanagement/fetaures/fees/data/models/checkFeeExistResultModel.dart';
import 'package:studentmanagement/fetaures/fees/data/models/feeProcessingModel.dart';
import 'package:studentmanagement/fetaures/fees/data/models/paymentGatewayResultModel.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeExistCheckResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeProcessingResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paymentGatewayDetails.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/feePayExistRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/offlinePaymentSaveRequest.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class FeesRemoteDataSource {
  Future<PaidFeeResult> fetchPaidFees(PaidFeesRequest request);
  Future<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request);
  Future<AccYearResult> fetchAccYearsList();
  Future<FeeSaveResult> saveFeeDetails(FeeSaveRequest request);
  Future<FeeSaveResult> saveOfflineFeeDetails(OfflineFeePayRequest request);
  Future<FeePaymentExistResult> checkFeePayExistStatus(
    FeePaymentExistRequest request,
  );
  Future<FeeProcessingResult> fetchProcessingFeeList(PaidFeesRequest request);
  Future<FeePaymentGatewayDetails> fetchPaymentGatewayDetails();
}

class FeesRemoteDataSourceImpl implements FeesRemoteDataSource {
  final Dio dio = DioClient.dio;
  @override
  Future<PaidFeeResult> fetchPaidFees(PaidFeesRequest request) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeesPaidServerPath(baseUrl!);
    //final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getFeesPaidServerPath(baseUrl),
      options: options,
      // options: Options(
      //   contentType: "application/json",
      //   headers: {
      //     "Accept": "application/json",
      //     "Authorization": "Bearer $token",
      //   },
      // ),
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data : ${response.data}');
    if (response.statusCode == 200) {
      return PaidFeeResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  // @override
  // Future<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request) async {
  //   // Load base URL safely
  //   final baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //   if (baseUrl == null || baseUrl.isEmpty) {}

  //   final url = ApiConstants.getFeesUnPaidServerPath(baseUrl!);
  //   // final token = await SharedPreferenceHelper().getToken() ?? "";
  //   print('Register URL: $url');
  //   // print(' token: $token');
  //   print('Request Body: ${request.toJson()}');
  //   final options = await ApiHelper.getAuthOptions(withToken: true);

  //   final response = await dio.post(
  //     ApiConstants.getFeesUnPaidServerPath(baseUrl),
  //     options: options,
  //     // options: Options(
  //     //   contentType: "application/json",
  //     //   headers: {
  //     //     "Accept": "application/json",
  //     //     "Authorization": "Bearer $token",
  //     //   },
  //     // ),
  //     data: request.toJson(),
  //   );
  //   print(response.data);
  //   print('Status Code: ${response.statusCode}');
  //   print('Response Data fetched pending: ${response.data}');
  //   if (response.statusCode == 200) {
  //     return UnpaidFeeResult.fromJson(response.data);
  //   } else {
  //     throw ServerException(
  //       errorMessageModel: ErrorMessageModel.fromJson(response.data),
  //     );
  //   }
  // }
  @override
  Future<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      print("BASE URL = $baseUrl");

      final options = await ApiHelper.getAuthOptions(withToken: true);

      final response = await dio.post(
        ApiConstants.getFeesUnPaidServerPath(baseUrl!),
        data: request.toJson(),
        options: options,
      );

      print("STATUS = ${response.statusCode}");
      print("DATA = ${response.data}");

      return UnpaidFeeResult.fromJson(response.data);
    } on DioException catch (e) {
      print("========== DIO ERROR ==========");
      print(e.type);
      print(e.message);
      print(e.error);
      print(e.response?.statusCode);
      print(e.response?.data);
      print("===============================");

      rethrow;
    } catch (e) {
      print("GENERAL ERROR = $e");
      rethrow;
    }
  }

  @override
  Future<AccYearResult> fetchAccYearsList() async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getAccYearsServerPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('AccYear URL: $url');
    // print(' token: $token');

    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.get(
      ApiConstants.getAccYearsServerPath(baseUrl),
      options: options,
      // options: Options(
      //   contentType: "application/json",
      //   headers: {
      //     "Accept": "application/json",
      //     "Authorization": "Bearer $token",
      //   },
      // ),
      //data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return AccYearListModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<FeeSaveResult> saveFeeDetails(FeeSaveRequest request) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeesSaveServerPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    // print(' token: $token');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getFeesSaveServerPath(baseUrl),
      options: options,
      // options: Options(
      //   contentType: "application/json",
      //   headers: {
      //     "Accept": "application/json",
      //     "Authorization": "Bearer $token",
      //   },
      // ),
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return FeeSaveResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<FeeSaveResult> saveOfflineFeeDetails(
    OfflineFeePayRequest request,
  ) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getOfflineFeesSaveServerPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    // print(' token: $token');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getOfflineFeesSaveServerPath(baseUrl),
      options: options,
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return FeeSaveResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<FeePaymentExistResult> checkFeePayExistStatus(
    FeePaymentExistRequest request,
  ) async {
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeePaymentExistPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    // print(' token: $token');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getFeePaymentExistPath(baseUrl),
      options: options,
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return CheckFeeExistResultModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<FeeProcessingResult> fetchProcessingFeeList(
    PaidFeesRequest request,
  ) async {
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeeProcessingListPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    // print(' token: $token');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getFeeProcessingListPath(baseUrl),
      options: options,
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return FeeProcessingModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<FeePaymentGatewayDetails> fetchPaymentGatewayDetails() async {
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getPaymentGatewayDetailsPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('AccYear URL: $url');
    // print(' token: $token');

    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.get(
      ApiConstants.getPaymentGatewayDetailsPath(baseUrl),
      options: options,
    );
    print(response.data);
    print('StatusGateway Code: ${response.statusCode}');
    print('Response Data fetched pending: ${response.data}');
    if (response.statusCode == 200) {
      return FeePaymentGatewayDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
