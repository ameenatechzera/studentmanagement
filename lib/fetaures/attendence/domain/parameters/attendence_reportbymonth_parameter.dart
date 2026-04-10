class AttendanceReportByMonthParameter {
  final String admno;
  final int month;
  final String accYear;
  final int branchId;

  AttendanceReportByMonthParameter({
    required this.admno,
    required this.month,
    required this.accYear,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "admno": admno,
      "month": month,
      "accYear": accYear,
      "branchId": branchId,
    };
  }
}
