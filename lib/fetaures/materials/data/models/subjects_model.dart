import 'package:studentmanagement/fetaures/materials/domain/entities/subjects_entity.dart';

class SubjectsModel extends SubjectsResult{
  SubjectsModel({required super.status, required super.error, required super.data});

  factory SubjectsModel.fromJson(Map<String, dynamic> json){
    return SubjectsModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<SubjectList>.from(json["data"]!.map((x) => SubjectList.fromJson(x))),
    );
  }

}