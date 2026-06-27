import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/core/network/apihelper.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class AcademicCalendarRemoteDataSource {
  Future<AcademicCalendarResponseModel> fetchAcademicCalendar();
}

class AcademicCalendarRemoteDataSourceImpl
    implements AcademicCalendarRemoteDataSource {
  final Dio dio = Dio();

  @override
  Future<AcademicCalendarResponseModel> fetchAcademicCalendar() async {
    print('📘 Fetch Academic Calendar Called');

    try {
      /// Get Base URL
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      print('baseUrl => $baseUrl');

      /// Build API URL
      final url = ApiConstants.getAcademicCalendarPath(baseUrl);

      print('url => $url');

      /// Auth Options
      final options = await ApiHelper.getAuthOptions(withToken: true);

      /// API Call
      final response = await dio.get(url, options: options);

      print('📘 Status Code: ${response.statusCode}');
      print('📘 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AcademicCalendarResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception in fetchAcademicCalendar: $e');
      print(stacktrace);
      rethrow;
    }
  }
}
