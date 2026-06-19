import 'package:studentmanagement/fetaures/fees/domain/entities/accyearResult.dart';

class AccYearListModel extends AccYearResult{
  AccYearListModel({required super.status, required super.error, required super.data});

  factory AccYearListModel.fromJson(Map<String, dynamic> json){
    return AccYearListModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}