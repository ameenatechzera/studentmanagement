import 'package:studentmanagement/fetaures/home_screen/domain/entities/feedaction_entity.dart';

class FeedActionResponseModel extends FeedActionEntity {
  FeedActionResponseModel({super.success, FeedActionDataModel? super.data});

  factory FeedActionResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedActionResponseModel(
      success: json['success'] as bool?,
      data: json['data'] != null
          ? FeedActionDataModel.fromJson(json['data'])
          : null,
    );
  }
}

class FeedActionDataModel extends FeedActionData {
  FeedActionDataModel({
    super.feedId,
    super.admissionId,
    super.branchId,
    super.type,
    super.isLiked,
    super.isShared,
    super.likeCount,
    super.shareCount,
  });

  factory FeedActionDataModel.fromJson(Map<String, dynamic> json) {
    return FeedActionDataModel(
      feedId: json['feedId'] as int?,
      admissionId: json['AdmissionId'] as int?,
      branchId: json['branchId'] as int?,
      type: json['type']?.toString(),
      isLiked: json['is_Liked'] as bool?,
      isShared: json['is_shared'] as bool?,
      likeCount: json['like_count'] as int?,
      shareCount: json['share_count'] as int?,
    );
  }
}
