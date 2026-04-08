class FetchFeedParameter {
  //final String accYear;
  final String standardId;
  final String divisionId;
  final String fromDateTime;
  final int page;
  final int perPage;

  FetchFeedParameter({
    // required this.accYear,
    required this.standardId,
    required this.divisionId,
    required this.fromDateTime,
    required this.page,
    required this.perPage,
  });

  Map<String, dynamic> toJson() {
    return {
      //"AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
      "FromDateTime": fromDateTime,
      "page": page,
      "per_page": perPage,
    };
  }
}
