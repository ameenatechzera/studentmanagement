import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/fees/data/models/accYearListModel.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/feeSaveResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaid%20fee_result.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paymentSaveRequest.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class FeesRemoteDataSource {
  Future<PaidFeeResult> fetchPaidFees(PaidFeesRequest request);
  Future<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request);
  Future<AccYearResult> fetchAccYearsList();
  Future<FeeSaveResult> saveFeeDetails(FeeSaveRequest request);


}

class FeesRemoteDataSourceImpl implements FeesRemoteDataSource {
  Dio dio = Dio();

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

  @override
  Future<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeesUnPaidServerPath(baseUrl!);
    // final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    // print(' token: $token');
    print('Request Body: ${request.toJson()}');
    final options = await ApiHelper.getAuthOptions(withToken: true);

    final response = await dio.post(
      ApiConstants.getFeesUnPaidServerPath(baseUrl),
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
      return UnpaidFeeResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
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
}
