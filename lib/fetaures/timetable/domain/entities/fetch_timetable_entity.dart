class FetchTimeTableResponse {
  final int? status;
  final bool? error;
  final List<FetchTimeTableDetails>? data;

  FetchTimeTableResponse({this.status, this.error, this.data});
}

class FetchTimeTableDetails {
  final int? timeTableMasterId;
  final String? accYearOut;
  final int? standardIdOut;
  final int? divisionIdOut;
  final String? dayName;
  final String? periodNo; // FIXED
  final int? subjectId;
  final String? subjectName;
  final String? shortName;
  final bool? status;

  FetchTimeTableDetails({
    this.timeTableMasterId,
    this.accYearOut,
    this.standardIdOut,
    this.divisionIdOut,
    this.dayName,
    this.periodNo,
    this.subjectId,
    this.subjectName,
    this.shortName,
    this.status,
  });
}
