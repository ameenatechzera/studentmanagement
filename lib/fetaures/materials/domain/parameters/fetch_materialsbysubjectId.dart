class FetchMaterialBySubjectIdParameter {
  final int branchId;
  final String userId;
  final String subjectId;
  final String standardId;
  final String divisionId;

  FetchMaterialBySubjectIdParameter({
    required this.branchId,
    required this.userId,
    required this.subjectId,
    required this.standardId,
    required this.divisionId
  });

  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "userId": userId,
      "subjectId": subjectId,
      "subjectId": subjectId,
      "divisionId": divisionId,
    };
  }
}
