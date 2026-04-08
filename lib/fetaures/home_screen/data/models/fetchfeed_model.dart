// import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

// class FetchFeedResponseModel extends FetchFeedEntity {
//   FetchFeedResponseModel({
//     super.status,
//     super.error,
//     List<FeedDetailsModel>? super.data,
//     super.message,
//   });

//   factory FetchFeedResponseModel.fromJson(Map<String, dynamic> json) {
//     return FetchFeedResponseModel(
//       status: json['status'],
//       error: json['error'],
//       message: json['message'],

//       /// ✅ FIXED: Proper type check + null safety
//       data: json['data'] != null && json['data'] is List
//           ? List<FeedDetailsModel>.from(
//               (json['data'] as List).map((x) => FeedDetailsModel.fromJson(x)),
//             )
//           : null,
//     );
//   }
// }

// class FeedDetailsModel extends FeedDetails {
//   FeedDetailsModel({
//     super.feedId,
//     super.feedText,
//     super.feedTarget,
//     List<StandardDivisionModel>? super.standardId,
//     super.userId,
//     super.branchId,
//     super.accYear,
//     super.createdDate,
//     super.createdUser,
//     super.modifiedDate,
//     super.modifiedUser,
//     List<FeedFileModel>? super.files,
//     super.createdDateFormatted,
//     super.createdTime,
//     super.modifiedDateFormatted,
//     super.modifiedTime,
//   });

//   factory FeedDetailsModel.fromJson(Map<String, dynamic> json) {
//     return FeedDetailsModel(
//       feedId: json['feedId'],
//       feedText: json['feedText'],
//       feedTarget: json['feedTarget'],

//       /// ✅ FIXED: Safe list parsing
//       standardId: json['StandardId'] != null && json['StandardId'] is List
//           ? List<StandardDivisionModel>.from(
//               (json['StandardId'] as List).map(
//                 (x) => StandardDivisionModel.fromJson(x),
//               ),
//             )
//           : [],

//       userId: json['userId'],
//       branchId: json['branchId'],
//       accYear: json['AccYear'],
//       createdDate: json['CreatedDate'],
//       createdUser: json['CreatedUser'],
//       modifiedDate: json['ModifiedDate'],
//       modifiedUser: json['ModifiedUser'],

//       /// ✅ FIXED: Safe list parsing
//       files: json['Files'] != null && json['Files'] is List
//           ? List<FeedFileModel>.from(
//               (json['Files'] as List).map((x) => FeedFileModel.fromJson(x)),
//             )
//           : [],

//       createdDateFormatted: json['CreatedDateFormatted'],
//       createdTime: json['CreatedTime'],
//       modifiedDateFormatted: json['ModifiedDateFormatted'],
//       modifiedTime: json['ModifiedTime'],
//     );
//   }
// }

// class StandardDivisionModel extends StandardDivision {
//   StandardDivisionModel({super.standardId, super.divisionId});

//   factory StandardDivisionModel.fromJson(Map<String, dynamic> json) {
//     return StandardDivisionModel(
//       standardId: json['StandardId'],
//       divisionId: json['DivisionId'],
//     );
//   }
// }

// class FeedFileModel extends FeedFile {
//   FeedFileModel({
//     super.fileId,
//     super.image,
//     super.createdDate,
//     super.createdUser,
//   });

//   factory FeedFileModel.fromJson(Map<String, dynamic> json) {
//     return FeedFileModel(
//       fileId: json['FileId'],
//       image: json['Image'],
//       createdDate: json['CreatedDate'],
//       createdUser: json['CreatedUser'],
//     );
//   }
// }
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
    super.createdDateFormatted,
    super.createdTime,
    super.modifiedDateFormatted,
    super.modifiedTime,
  });

  factory FeedDetailsModel.fromJson(Map<String, dynamic> json) {
    return FeedDetailsModel(
      feedId: json['feedId'] as int?,
      feedText: json['feedText']?.toString(),
      feedTarget: json['feedTarget']?.toString(),
      standardId: json['StandardId'] == null
          ? []
          : (json['StandardId'] as List)
                .map(
                  (x) =>
                      StandardDivisionModel.fromJson(x as Map<String, dynamic>),
                )
                .toList(),
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
                .map((x) => FeedFileModel.fromJson(x as Map<String, dynamic>))
                .toList(),
      createdDateFormatted: json['CreatedDateFormatted']?.toString(),
      createdTime: json['CreatedTime']?.toString(),
      modifiedDateFormatted: json['ModifiedDateFormatted']?.toString(),
      modifiedTime: json['ModifiedTime']?.toString(),
    );
  }
}

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
