class FetchTimeTableParameter {
  final String accYear;
  final int standardId;
  final int divisionId;
  final int branchId;

  const FetchTimeTableParameter({
    required this.accYear,
    required this.standardId,
    required this.divisionId,
    required this.branchId,
  });
  Map<String, dynamic> toJson() {
    return {
      "AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "branchId": branchId,
    };
  }
}
