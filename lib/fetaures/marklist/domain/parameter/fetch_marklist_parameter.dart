class FetchMarkListParameter {
  final int branchId;
  final String accYear;
  final String standardId;
  final String divisionId;
  final String examTermId;
  final String admno;

  FetchMarkListParameter({
    required this.branchId,
    required this.accYear,
    required this.standardId,
    required this.divisionId,
    required this.examTermId,
    required this.admno,
  });

  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "accYear": accYear,
      "standardId": standardId,
      "divisionId": divisionId,
      "examTermId": examTermId,
      "admno": admno,
    };
  }
}
