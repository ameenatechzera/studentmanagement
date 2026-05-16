// class AttendanceReportByMonthEntity {
//   final int? status;
//   final bool? error;
//   final String? message;
//   final List<AttendanceReportByMonthDetails>? data;

//   AttendanceReportByMonthEntity({
//     this.status,
//     this.error,
//     this.message,
//     this.data,
//   });
// }

// class AttendanceReportByMonthDetails {
//   final String? admno;
//   final String? name;
//   final String? gender;

//   final Map<String, String?>? days;

//   final String? totalPresent;
//   final String? totalAbsent;

//   AttendanceReportByMonthDetails({
//     this.admno,
//     this.name,
//     this.gender,
//     this.days,
//     this.totalPresent,
//     this.totalAbsent,
//   });
// }
class AttendanceReportByMonthEntity {
  final int? status;
  final bool? error;
  final String? message;

  final List<AttendanceReportByMonthDetails>? data;

  /// ✅ NEW
  final List<AttendanceDetailEntity>? attendanceDetails;

  AttendanceReportByMonthEntity({
    this.status,
    this.error,
    this.message,
    this.data,
    this.attendanceDetails,
  });
}

class AttendanceReportByMonthDetails {
  final String? admno;
  final String? name;
  final String? gender;

  /// ✅ Day1 -> Day31
  final Map<String, String?>? days;

  final String? totalPresent;
  final String? totalAbsent;

  AttendanceReportByMonthDetails({
    this.admno,
    this.name,
    this.gender,
    this.days,
    this.totalPresent,
    this.totalAbsent,
  });
}

/// ✅ attendanceDetails entity
class AttendanceDetailEntity {
  final String? date;
  final int? day;
  final String? status;
  final String? narration;

  AttendanceDetailEntity({this.date, this.day, this.status, this.narration});
}
