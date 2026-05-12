
import 'package:studentmanagement/fetaures/materials/domain/entities/materialsBySubject_entity.dart';

class FetchMaterialsbySubjectModel extends MaterialsbysubjectResult{
  FetchMaterialsbySubjectModel({required super.status, required super.error, required super.data});

  factory FetchMaterialsbySubjectModel.fromJson(Map<String, dynamic> json){
    return FetchMaterialsbySubjectModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<MaterialList>.from(json["data"]!.map((x) => MaterialList.fromJson(x))),
    );
  }
}