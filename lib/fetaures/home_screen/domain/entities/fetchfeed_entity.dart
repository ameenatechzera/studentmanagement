class FetchFeedEntity {
  final int? status;
  final bool? error;
  final List<FeedDetails>? data;
  final FeedPagination? pagination;
  final String? message;

  FetchFeedEntity({
    this.status,
    this.error,
    this.data,
    this.pagination,
    this.message,
  });
}

class FeedDetails {
  final int? feedId;
  final String? feedText;
  final String? feedTarget;
  final List<StandardDivision>? standardId;
  final String? userId;
  final int? branchId;
  final String? accYear;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final List<FeedFile>? files;
  final List<String>? image;
  final List<String>? videoUrl;
  final String? postedBy;
  final dynamic designationName;
  final int? classStandardId;
  final int? classDivisionId;
  final String? classStandardName;
  final String? classDivisionName;
  final List<FeedSubject>? subjects;
  final int? likeCount;
  final int? shareCount;
  final bool? isLiked;
  final String? createdDateFormatted;
  final String? createdTime;
  final String? modifiedDateFormatted;
  final String? modifiedTime;

  FeedDetails({
    this.feedId,
    this.feedText,
    this.feedTarget,
    this.standardId,
    this.userId,
    this.branchId,
    this.accYear,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.files,
    this.image,
    this.videoUrl,
    this.postedBy,
    this.designationName,
    this.classStandardId,
    this.classDivisionId,
    this.classStandardName,
    this.classDivisionName,
    this.subjects,
    this.likeCount,
    this.shareCount,
    this.isLiked,
    this.createdDateFormatted,
    this.createdTime,
    this.modifiedDateFormatted,
    this.modifiedTime,
  });
  Map<String, dynamic> toJson() {
    return {
      "feedId": feedId,
      "feedText": feedText,
      "feedTarget": feedTarget,
      "standardId": standardId?.map((e) => e.toJson()).toList(),
      "userId": userId,
      "branchId": branchId,
      "accYear": accYear,
      "createdDate": createdDate,
      "createdUser": createdUser,
      "modifiedDate": modifiedDate,
      "modifiedUser": modifiedUser,
      "files": files?.map((e) => e.toJson()).toList(),
      "image": image,
      "videoUrl": videoUrl,
      "postedBy": postedBy,
      "designationName": designationName,
      "classStandardId": classStandardId,
      "classDivisionId": classDivisionId,
      "classStandardName": classStandardName,
      "classDivisionName": classDivisionName,
      "subjects": subjects?.map((e) => e.toJson()).toList(),
      "likeCount": likeCount,
      "shareCount": shareCount,
      "isLiked": isLiked,
      "createdDateFormatted": createdDateFormatted,
      "createdTime": createdTime,
      "modifiedDateFormatted": modifiedDateFormatted,
      "modifiedTime": modifiedTime,
    };
  }

  factory FeedDetails.fromJson(Map<String, dynamic> json) {
    return FeedDetails(
      feedId: json['feedId'],
      feedText: json['feedText'],
      feedTarget: json['feedTarget'],

      standardId: (json['standardId'] as List?)
          ?.map(
            (e) => StandardDivision(
              standardId: e['StandardId'],
              divisionId: e['DivisionId'],
            ),
          )
          .toList(),

      userId: json['userId'],
      branchId: json['branchId'],
      accYear: json['accYear'],
      createdDate: json['createdDate'],
      createdUser: json['createdUser'],
      modifiedDate: json['modifiedDate'],
      modifiedUser: json['modifiedUser'],

      files: (json['files'] as List?)
          ?.map(
            (e) => FeedFile(
              fileId: e['FileId'],
              image: e['Image'],
              createdDate: e['CreatedDate'],
              createdUser: e['CreatedUser'],
            ),
          )
          .toList(),

      image: (json['image'] as List?)?.cast<String>(),
      videoUrl: (json['videoUrl'] as List?)?.cast<String>(),

      postedBy: json['postedBy'],
      designationName: json['designationName'],

      classStandardId: json['classStandardId'],
      classDivisionId: json['classDivisionId'],
      classStandardName: json['classStandardName'],
      classDivisionName: json['classDivisionName'],

      subjects: (json['subjects'] as List?)
          ?.map(
            (e) => FeedSubject(
              subjectId: e['subjectId'],
              subjectName: e['subjectName'],
              shortName: e['shortName'],
            ),
          )
          .toList(),

      likeCount: json['likeCount'],
      shareCount: json['shareCount'],
      isLiked: json['isLiked'],

      createdDateFormatted: json['createdDateFormatted'],
      createdTime: json['createdTime'],
      modifiedDateFormatted: json['modifiedDateFormatted'],
      modifiedTime: json['modifiedTime'],
    );
  }
}

class StandardDivision {
  final int? standardId;
  final int? divisionId;

  StandardDivision({this.standardId, this.divisionId});
  Map<String, dynamic> toJson() => {
    'standardId': standardId,
    'divisionId': divisionId,
  };
}

class FeedFile {
  final int? fileId;
  final String? image;
  final String? createdDate;
  final String? createdUser;

  FeedFile({this.fileId, this.image, this.createdDate, this.createdUser});
  Map<String, dynamic> toJson() => {
    'fileId': fileId,
    'image': image,
    'createdDate': createdDate,
    'createdUser': createdUser,
  };
  factory FeedFile.fromJson(Map<String, dynamic> json) {
    return FeedFile(
      fileId: json['fileId'],
      image: json['image'],
      createdDate: json['createdDate'],
      createdUser: json['createdUser'],
    );
  }
}

class FeedSubject {
  final int? subjectId;
  final String? subjectName;
  final String? shortName;

  FeedSubject({this.subjectId, this.subjectName, this.shortName});
  Map<String, dynamic> toJson() => {
    'subjectId': subjectId,
    'subjectName': subjectName,
    'shortName': shortName,
  };
}

class FeedPagination {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final int? from;
  final int? to;

  FeedPagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.from,
    this.to,
  });
}
