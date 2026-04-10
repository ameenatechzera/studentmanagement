import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/error_message_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/network/api_endpoints.dart';
import 'package:studentmanagement/fetaures/attendence/data/models/attendence_reportbydate_model.dart';
import 'package:studentmanagement/fetaures/attendence/data/models/attendence_reportbymonth_model.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceReportByDateEntity> getAttendanceReportByDate(
    AttendanceReportByDateParameter params,
  );
  Future<AttendanceReportByMonthEntity> getAttendanceReportByMonth(
    AttendanceReportByMonthParameter params,
  );
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  Dio dio = Dio();

  @override
  Future<AttendanceReportByDateEntity> getAttendanceReportByDate(
    AttendanceReportByDateParameter params,
  ) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final dbName = await SharedPreferenceHelper().getDatabaseName();
      final token = await SharedPreferenceHelper().getToken() ?? "";
      final url = ApiConstants.getAttendanceReportByDatePath(baseUrl);

      print('🔹 Attendance URL: $url');
      print('🔹 Request Body: ${params.toJson()}');
      print('🔹 dbName: $dbName');

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

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return AttendanceReportByDateModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during getAttendanceReportByDate: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }

  @override
  Future<AttendanceReportByMonthEntity> getAttendanceReportByMonth(
    AttendanceReportByMonthParameter params,
  ) async {
    try {
      final baseUrl = await SharedPreferenceHelper().getBaseUrl();

      if (baseUrl == null || baseUrl.isEmpty) {
        throw Exception("Base URL not set");
      }

      final token = await SharedPreferenceHelper().getToken() ?? "";
      final url = ApiConstants.getAttendanceReportByMonthPath(
        baseUrl,
      ); // ✅ new endpoint

      print('🔹 Month Attendance URL: $url');
      print('🔹 Request Body: ${params.toJson()}');

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

      print('🔹 Status Code: ${response.statusCode}');
      print('🔹 Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return AttendanceReportByMonthModel.fromJson(response.data);
      } else {
        throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data),
        );
      }
    } catch (e, stacktrace) {
      print('❌ Exception during getAttendanceReportByMonth: $e');
      print('Stacktrace: $stacktrace');
      rethrow;
    }
  }
}
