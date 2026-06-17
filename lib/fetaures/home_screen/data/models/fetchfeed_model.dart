import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

class FetchFeedResponseModel extends FetchFeedEntity {
  FetchFeedResponseModel({
    super.status,
    super.error,
    List<FeedDetailsModel>? super.data,
    super.pagination,
    super.message,
  });

  factory FetchFeedResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchFeedResponseModel(
      status: json['status'] as int?,
      error: json['error'] as bool?,
      message: json['message']?.toString(),
      data: json['data'] == null
          ? []
          : (json['data'] as List)
                .map(
                  (x) => FeedDetailsModel.fromJson(x as Map<String, dynamic>),
                )
                .toList(),
      pagination: json['pagination'] != null
          ? FeedPaginationModel.fromJson(json['pagination'])
          : null,
    );
  }
}

class FeedDetailsModel extends FeedDetails {
  FeedDetailsModel({
    super.feedId,
    super.feedText,
    super.feedTarget,
    List<StandardDivisionModel>? super.standardId,
    super.userId,
    super.branchId,
    super.accYear,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
    List<FeedFileModel>? super.files,
    super.image,
    super.videoUrl,
    super.postedBy,
    super.designationName,
    super.likeCount,
    super.shareCount,
    super.isLiked,
    super.createdDateFormatted,
    super.createdTime,
    super.modifiedDateFormatted,
    super.modifiedTime,
    super.classStandardId,
    super.classDivisionId,
    super.classStandardName,
    super.classDivisionName,
    super.subjects,
  });
  factory FeedDetailsModel.fromJson(Map<String, dynamic> json) {
    print("🧩 FROM JSON → IsLiked: ${json['IsLiked']}");

    return FeedDetailsModel(
      feedId: json['feedId'] as int?,
      feedText: json['feedText']?.toString(),

      // ✅ FIXED WITH SAFE CASTING
      likeCount: (json['LikeCount'] ?? 0) as int,
      shareCount: (json['ShareCount'] ?? 0) as int,
      isLiked: (json['IsLiked'] ?? false) == true,

      // rest same...
      feedTarget: json['feedTarget']?.toString(),
      standardId: json['StandardId'] is List
          ? (json['StandardId'] as List)
                .map(
                  (x) =>
                      StandardDivisionModel.fromJson(x as Map<String, dynamic>),
                )
                .toList()
          : [],

      userId: json['userId']?.toString(),
      branchId: json['branchId'] as int?,
      accYear: json['AccYear']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
      modifiedDate: json['ModifiedDate']?.toString(),
      modifiedUser: json['ModifiedUser']?.toString(),
      files: json['Files'] == null
          ? []
          : (json['Files'] as List)
                .map((x) => FeedFileModel.fromJson(x))
                .toList(),
      image: json['Image'] == null
          ? []
          : json['Image'] is List
          ? List<String>.from(json['Image'])
          : json['Image'].toString().isNotEmpty
          ? [json['Image'].toString()]
          : [],

      videoUrl: json['videoUrl'] == null
          ? []
          : json['videoUrl'] is List
          ? List<String>.from(json['videoUrl'])
          : json['videoUrl'].toString().isNotEmpty
          ? [json['videoUrl'].toString()]
          : [],

      postedBy: json['PostedBy']?.toString(),
      designationName: json['DesignationName'],
      createdDateFormatted: json['CreatedDateFormatted']?.toString(),
      createdTime: json['CreatedTime']?.toString(),
      modifiedDateFormatted: json['ModifiedDateFormatted']?.toString(),
      modifiedTime: json['ModifiedTime']?.toString(),
      classStandardId: json['ClassStandardId'],
      classDivisionId: json['ClassDivisionId'],
      classStandardName: json['ClassStandardName']?.toString(),
      classDivisionName: json['ClassDivisionName']?.toString(),

      subjects: json['Subjects'] == null
          ? []
          : (json['Subjects'] as List)
                .map((e) => FeedSubjectModel.fromJson(e))
                .toList(),
    );
  }
}
//   factory FeedDetailsModel.fromJson(Map<String, dynamic> json) {
//     return FeedDetailsModel(
//       feedId: json['feedId'] as int?,
//       feedText: json['feedText']?.toString(),
//       feedTarget: json['feedTarget']?.toString(),
//       standardId: json['StandardId'] == null
//           ? []
//           : (json['StandardId'] as List)
//                 .map(
//                   (x) =>
//                       StandardDivisionModel.fromJson(x as Map<String, dynamic>),
//                 )
//                 .toList(),
//       userId: json['userId']?.toString(),
//       branchId: json['branchId'] as int?,
//       accYear: json['AccYear']?.toString(),
//       createdDate: json['CreatedDate']?.toString(),
//       createdUser: json['CreatedUser']?.toString(),
//       modifiedDate: json['ModifiedDate']?.toString(),
//       modifiedUser: json['ModifiedUser']?.toString(),
//       files: json['Files'] == null
//           ? []
//           : (json['Files'] as List)
//                 .map((x) => FeedFileModel.fromJson(x as Map<String, dynamic>))
//                 .toList(),
//       createdDateFormatted: json['CreatedDateFormatted']?.toString(),
//       createdTime: json['CreatedTime']?.toString(),
//       modifiedDateFormatted: json['ModifiedDateFormatted']?.toString(),
//       modifiedTime: json['ModifiedTime']?.toString(),
//       postedBy: json['PostedBy']?.toString(),
//       likeCount: json['LikeCount'],
//       shareCount: json['ShareCount'],
//       isLiked: json['IsLiked'],
//     );
//   }
// }

class StandardDivisionModel extends StandardDivision {
  StandardDivisionModel({super.standardId, super.divisionId});

  factory StandardDivisionModel.fromJson(Map<String, dynamic> json) {
    return StandardDivisionModel(
      standardId: json['StandardId'] as int?,
      divisionId: json['DivisionId'] as int?,
    );
  }
}

class FeedFileModel extends FeedFile {
  FeedFileModel({
    super.fileId,
    super.image,
    super.createdDate,
    super.createdUser,
  });

  factory FeedFileModel.fromJson(Map<String, dynamic> json) {
    return FeedFileModel(
      fileId: json['FileId'] as int?,
      image: json['Image']?.toString(),
      createdDate: json['CreatedDate']?.toString(),
      createdUser: json['CreatedUser']?.toString(),
    );
  }
}

class FeedSubjectModel extends FeedSubject {
  FeedSubjectModel({super.subjectId, super.subjectName, super.shortName});

  factory FeedSubjectModel.fromJson(Map<String, dynamic> json) {
    return FeedSubjectModel(
      subjectId: json['SubjectId'],
      subjectName: json['SubjectName'],
      shortName: json['ShortName'],
    );
  }
}

class FeedPaginationModel extends FeedPagination {
  FeedPaginationModel({
    super.total,
    super.perPage,
    super.currentPage,
    super.lastPage,
    super.from,
    super.to,
  });

  factory FeedPaginationModel.fromJson(Map<String, dynamic> json) {
    return FeedPaginationModel(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      from: json['from'],
      to: json['to'],
    );
  }
}
