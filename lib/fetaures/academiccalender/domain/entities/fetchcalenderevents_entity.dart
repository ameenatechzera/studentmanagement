class AcademicCalendarResponse {
  final int? status;
  final bool? error;
  final List<AcademicCalendarDetails>? data;

  AcademicCalendarResponse({this.status, this.error, this.data});
}

class AcademicCalendarDetails {
  final int? eventId;
  final String? accYear;
  final int? categoryId;
  final String? categoryName;
  final String? eventDate;
  final String? eventTitle;
  final String? eventDescription;
  final String? image;
  final String? standardIds;
  final String? standardNames;
  final String? isHoliday;
  final String? isNotificationSent;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;

  AcademicCalendarDetails({
    this.eventId,
    this.accYear,
    this.categoryId,
    this.categoryName,
    this.eventDate,
    this.eventTitle,
    this.eventDescription,
    this.image,
    this.standardIds,
    this.standardNames,
    this.isHoliday,
    this.isNotificationSent,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
  });
}
