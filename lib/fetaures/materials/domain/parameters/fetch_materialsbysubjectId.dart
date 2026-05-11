class FetchMaterialBySubjectIdParameter {
  final int branchId;
  final String userId;
  final String subjectId;

  FetchMaterialBySubjectIdParameter({
    required this.branchId,
    required this.userId,
    required this.subjectId
  });

  Map<String, dynamic> toJson() {
    return {
      "branchId": branchId,
      "userId": userId,
      "subjectId": subjectId
    };
  }
}
