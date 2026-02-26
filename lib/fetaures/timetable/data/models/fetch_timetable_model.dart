import 'package:studentmanagement/fetaures/timetable/domain/entities/fetch_timetable_entity.dart';

class FetchTimeTableResponseModel extends FetchTimeTableResponse {
  FetchTimeTableResponseModel({
    super.status,
    super.error,
    List<FetchTimeTableDetailsModel>? super.data,
  });

  factory FetchTimeTableResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchTimeTableResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] != null
          ? List<FetchTimeTableDetailsModel>.from(
              json['data'].map((x) => FetchTimeTableDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class FetchTimeTableDetailsModel extends FetchTimeTableDetails {
  FetchTimeTableDetailsModel({
    super.timeTableMasterId,
    super.accYearOut,
    super.standardIdOut,
    super.divisionIdOut,
    super.dayName,
    super.periodNo,
    super.subjectId,
    super.subjectName,
    super.shortName,
    super.status,
  });

  factory FetchTimeTableDetailsModel.fromJson(Map<String, dynamic> json) {
    return FetchTimeTableDetailsModel(
      timeTableMasterId: json['timeTableMasterId'],
      accYearOut: json['AccYear_out'],
      standardIdOut: json['StandardId_out'],
      divisionIdOut: json['DivisionId_out'],
      dayName: json['DayName'],
      periodNo: json['PeriodNo'],
      subjectId: json['SubjectId'],
      subjectName: json['SubjectName'],
      shortName: json['ShortName'],
      status: json['Status'],
    );
  }
}
