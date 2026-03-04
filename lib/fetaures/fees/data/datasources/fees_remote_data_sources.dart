import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paidFeeResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class FeesRemoteDataSource {
  Future<PaidFeeResult> fetchPaidFees(PaidFeesRequest request,);
}
  class FeesRemoteDataSourceImpl implements FeesRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<PaidFeeResult> fetchPaidFees(PaidFeesRequest request) async {
    // Load base URL safely
    final baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.isEmpty) {}

    final url = ApiConstants.getFeesPaidServerPath(baseUrl!);
    final token = await SharedPreferenceHelper().getToken() ?? "";
    print('Register URL: $url');
    print('Request Body: ${request.toJson()}');

    final response = await dio.post(
      ApiConstants.getFeesPaidServerPath(baseUrl),
      options: Options(contentType: "application/json",
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },),
      data: request.toJson(),
    );
    print(response.data);
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.data}');
    if (response.statusCode == 200) {
      return PaidFeeResult.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

}