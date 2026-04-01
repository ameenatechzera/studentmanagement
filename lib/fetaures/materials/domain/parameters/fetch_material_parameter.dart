class FetchMaterialParameter {
  final int branchId;
  final String accYear;
  final String standardId;
  final String divisionId;

  FetchMaterialParameter({
    required this.branchId,
    required this.accYear,
    required this.standardId,
    required this.divisionId,
  });

  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "accYear": accYear,
      "standardId": standardId,
      "divisionId": divisionId,
    };
  }
}
