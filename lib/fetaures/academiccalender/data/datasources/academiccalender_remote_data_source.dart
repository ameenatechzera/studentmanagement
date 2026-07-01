import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class AcademicCalendarRemoteDataSource {
  Future<FetchCalendarResponseModel> fetchAcademicCalendar(
    FetchCalendarParameter parameter,
  );
}

class AcademicCalendarRemoteDataSourceImpl
    implements AcademicCalendarRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<FetchCalendarResponseModel> fetchAcademicCalendar(
    FetchCalendarParameter parameter,
  ) async {
    print('📘 Fetch Academic Calendar Called');

    try {
      /// Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print("Base URL => $baseUrl");

      /// API URL
      final url = ApiConstants.getAcademicCalendarPath(baseUrl);

      print("URL => $url");

      /// Authorization
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Request
      final response = await dio.post(
        url,
        data: parameter.toJson(),
        options: options,
      );

      print("Status Code => ${response.statusCode}");
      print("Response => ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FetchCalendarResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } on DioException catch (e) {
      print("Dio Exception => ${e.response?.data}");
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(e.response?.data ?? {}),
      );
    } catch (e, stackTrace) {
      print("Exception => $e");
      print(stackTrace);
      rethrow;
    }
  }
}
