import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';

class AttendanceReportByDateModel extends AttendanceReportByDateEntity {
  AttendanceReportByDateModel({
    super.status,
    super.error,
    super.message,
    List<AttendanceReportByDateDetailsModel>? super.data,
  });

  factory AttendanceReportByDateModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportByDateModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AttendanceReportByDateDetailsModel.fromJson(e))
          .toList(),
    );
  }
}

class AttendanceReportByDateDetailsModel extends AttendanceReportByDateDetails {
  AttendanceReportByDateDetailsModel({
    super.admno,
    super.name,
    super.gender,
    super.status,
  });

  factory AttendanceReportByDateDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AttendanceReportByDateDetailsModel(
      admno: json['Admno'] ?? 0,
      name: json['Name'] ?? '',
      gender: json['Gender'] ?? '',
      status: json['Status'] ?? '',
    );
  }
}
