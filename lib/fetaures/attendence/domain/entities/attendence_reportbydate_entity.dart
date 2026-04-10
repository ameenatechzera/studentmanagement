class AttendanceReportByDateEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<AttendanceReportByDateDetails>? data;

  AttendanceReportByDateEntity({
    this.status,
    this.error,
    this.message,
    this.data,
  });
}

class AttendanceReportByDateDetails {
  final String? admno;
  final String? name;
  final String? gender;
  final String? status;

  AttendanceReportByDateDetails({
    this.admno,
    this.name,
    this.gender,
    this.status,
  });
}
