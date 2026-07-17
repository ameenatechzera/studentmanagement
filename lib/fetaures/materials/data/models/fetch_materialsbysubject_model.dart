// import 'package:studentmanagement/fetaures/materials/domain/entities/materialsBySubject_entity.dart';

// class FetchMaterialsbySubjectModel extends MaterialsbysubjectResult{
//   FetchMaterialsbySubjectModel({required super.status, required super.error, required super.data});

//   factory FetchMaterialsbySubjectModel.fromJson(Map<String, dynamic> json){
//     return FetchMaterialsbySubjectModel(
//       status: json["status"] ?? 0,
//       error: json["error"] ?? false,
//       data: json["data"] == null ? [] : List<MaterialList>.from(json["data"]!.map((x) => MaterialList.fromJson(x))),
//     );
//   }
// }
import 'package:studentmanagement/fetaures/materials/domain/entities/materialsBySubject_entity.dart';

class FetchMaterialsbySubjectModel extends MaterialsbysubjectResult {
  const FetchMaterialsbySubjectModel({
    required super.status,
    required super.error,
    required super.data,
  });

  factory FetchMaterialsbySubjectModel.fromJson(Map<String, dynamic> json) {
    final entity = MaterialsbysubjectResult.fromJson(json);

    return FetchMaterialsbySubjectModel(
      status: entity.status,
      error: entity.error,
      data: entity.data,
    );
  }
}
