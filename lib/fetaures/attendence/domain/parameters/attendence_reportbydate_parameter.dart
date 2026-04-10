class AttendanceReportByDateParameter {
  final String? admno;
  final String? date;
  final String? accYear;
  final int? branchId;

  AttendanceReportByDateParameter({
    this.admno,
    this.date,
    this.accYear,
    this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "admno": admno,
      "date": date,
      "accYear": accYear,
      "branchId": branchId,
    };
  }
}
