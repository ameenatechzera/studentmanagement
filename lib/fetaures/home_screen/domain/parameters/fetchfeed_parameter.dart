class FetchFeedParameter {
  //final String accYear;
  final String standardId;
  final String divisionId;

  FetchFeedParameter({
   // required this.accYear,
    required this.standardId,
    required this.divisionId,
  });

  Map<String, dynamic> toJson() {
    return {
      //"AccYear": accYear,
      "StandardId": standardId,
      "DivisionId": divisionId,
    };
  }
}
