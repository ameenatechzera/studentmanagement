class FetchCalendarParameter {
  final String accYear;
  final int branchId;
  final String admno;

  FetchCalendarParameter({
    required this.accYear,
    required this.branchId,
    required this.admno,
  });

  Map<String, dynamic> toJson() {
    return {"accYear": accYear, "branchId": branchId, "admno": admno};
  }
}
