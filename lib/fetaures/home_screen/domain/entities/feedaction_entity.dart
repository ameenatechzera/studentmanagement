class FeedActionEntity {
  final bool? success;
  final FeedActionData? data;

  FeedActionEntity({this.success, this.data});
}

class FeedActionData {
  final int? feedId;
  final int? admissionId;
  final int? branchId;
  final String? type;
  final bool? isLiked;
  final bool? isShared;
  final int? likeCount;
  final int? shareCount;

  FeedActionData({
    this.feedId,
    this.admissionId,
    this.branchId,
    this.type,
    this.isLiked,
    this.isShared,
    this.likeCount,
    this.shareCount,
  });
}
