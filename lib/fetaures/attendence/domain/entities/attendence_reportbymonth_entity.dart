class AttendanceReportByMonthEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<AttendanceReportByMonthDetails>? data;

  AttendanceReportByMonthEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class AttendanceReportByMonthDetails {
  final String? admno;
  final String? name;
  final String? gender;

  // ✅ Store all days in Map (BEST APPROACH)
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
