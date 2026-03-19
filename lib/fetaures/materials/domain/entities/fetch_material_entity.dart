class FetchMaterialEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<FetchMaterialDetails>? data;

  FetchMaterialEntity({this.status, this.error, this.message, this.data});
}

class FetchMaterialDetails {
  final int? materialId;
  final int? staffId;
  final int? accYear;
  final String? accYearName;
  final int? standardId;
  final int? divisionId;
  final int? subjectId;
  final String? material;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final String? documentName;
  final String? notes;
  final String? link;
  final bool? favorite;

  FetchMaterialDetails({
    this.materialId,
    this.staffId,
    this.accYear,
    this.accYearName,
    this.standardId,
    this.divisionId,
    this.subjectId,
    this.material,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.documentName,
    this.notes,
    this.link,
    this.favorite,
  });
}
