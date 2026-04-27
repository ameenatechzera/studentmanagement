class FeedActionParameter {
  final int admissionId;
  final int feedId;
  final int branchId;
  final String type;
  final bool value;

  FeedActionParameter({
    required this.admissionId,
    required this.feedId,
    required this.branchId,
    required this.type,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      "admission_id": admissionId,
      "feed_id": feedId,
      "branch_id": branchId,
      "type": type,
      "value": value,
    };
  }
}
