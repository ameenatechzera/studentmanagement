class FetchExamTermEntity {
  final int? status;
  final bool? error;
  final List<FetchExamTermDetails>? data;

  FetchExamTermEntity({this.status, this.error, this.data});
}

class FetchExamTermDetails {
  final String? examTermId;
  final String? examTermName;
  final bool? status;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  FetchExamTermDetails({
    this.examTermId,
    this.examTermName,
    this.status,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}
