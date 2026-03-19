import 'package:studentmanagement/fetaures/materials/domain/entities/fetch_material_entity.dart';

class FetchMaterialResponseModel extends FetchMaterialEntity {
  FetchMaterialResponseModel({
    super.status,
    super.error,
    super.message,
    List<FetchMaterialDetailsModel>? super.data,
  });

  factory FetchMaterialResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchMaterialResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: json['data'] != null
          ? List<FetchMaterialDetailsModel>.from(
              json['data'].map((x) => FetchMaterialDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class FetchMaterialDetailsModel extends FetchMaterialDetails {
  FetchMaterialDetailsModel({
    super.materialId,
    super.staffId,
    super.accYear,
    super.accYearName,
    super.standardId,
    super.divisionId,
    super.subjectId,
    super.material,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    super.documentName,
    super.notes,
    super.link,
    super.favorite,
  });

  factory FetchMaterialDetailsModel.fromJson(Map<String, dynamic> json) {
    return FetchMaterialDetailsModel(
      materialId: json['materialId'],
      staffId: json['StaffId'],
      accYear: json['AccYear'],
      accYearName: json['AccYearName'],
      standardId: json['StandardId'],
      divisionId: json['DivisionId'],
      subjectId: json['SubjectId'],
      material: json['Material'],
      branchId: json['branchId'],
      createdDate: json['CreatedDate'],
      createdUser: json['CreatedUser'],
      modifiedDate: json['ModifiedDate'],
      modifiedUser: json['ModifiedUser'],
      documentName: json['documentName'],
      notes: json['notes'],
      link: json['link'],
      favorite: json['favorite'],
    );
  }
}
