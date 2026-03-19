class FetchFeedEntity {
  final int? status;
  final bool? error;
  final List<FeedDetails>? data;
  final String? message;

  FetchFeedEntity({this.status, this.error, this.data, this.message});
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
