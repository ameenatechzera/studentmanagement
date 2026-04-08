// class FetchFeedEntity {
//   final int? status;
//   final bool? error;
//   final List<FeedDetails>? data;
//   final String? message;

//   FetchFeedEntity({this.status, this.error, this.data, this.message});
// }

// class FeedDetails {
//   final int? feedId;
//   final String? feedText;
//   final String? feedTarget;
//   final List<StandardDivision>? standardId;
//   final String? userId;
//   final int? branchId;
//   final String? accYear;
//   final String? createdDate;
//   final String? createdUser;
//   final String? modifiedDate;
//   final String? modifiedUser;
//   final List<FeedFile>? files;
//   final String? createdDateFormatted;
//   final String? createdTime;
//   final String? modifiedDateFormatted;
//   final String? modifiedTime;

//   FeedDetails({
//     this.feedId,
//     this.feedText,
//     this.feedTarget,
//     this.standardId,
//     this.userId,
//     this.branchId,
//     this.accYear,
//     this.createdDate,
//     this.createdUser,
//     this.modifiedDate,
//     this.modifiedUser,
//     this.files,
//     this.createdDateFormatted,
//     this.createdTime,
//     this.modifiedDateFormatted,
//     this.modifiedTime,
//   });
// }

// class StandardDivision {
//   final int? standardId;
//   final int? divisionId;

//   StandardDivision({this.standardId, this.divisionId});
// }

// class FeedFile {
//   final int? fileId;
//   final String? image;
//   final String? createdDate;
//   final String? createdUser;

//   FeedFile({this.fileId, this.image, this.createdDate, this.createdUser});
// }
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
  final String? postedBy;
  final int? classStandardId;
  final int? classDivisionId;
  final String? classStandardName;
  final String? classDivisionName;
  final List<FeedSubject>? subjects;
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
    this.postedBy,
    this.classStandardId,
    this.classDivisionId,
    this.classStandardName,
    this.classDivisionName,
    this.subjects,
    this.createdDateFormatted,
    this.createdTime,
    this.modifiedDateFormatted,
    this.modifiedTime,
  });
}

class StandardDivision {
  final int? standardId;
  final int? divisionId;

  StandardDivision({this.standardId, this.divisionId});
}

class FeedFile {
  final int? fileId;
  final String? image;
  final String? createdDate;
  final String? createdUser;

  FeedFile({this.fileId, this.image, this.createdDate, this.createdUser});
}

class FeedSubject {
  final int? subjectId;
  final String? subjectName;
  final String? shortName;

  FeedSubject({this.subjectId, this.subjectName, this.shortName});
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
