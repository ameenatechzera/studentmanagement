import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';

class AcademicCalendarResponseModel extends AcademicCalendarResponse {
  AcademicCalendarResponseModel({
    super.status,
    super.error,
    List<AcademicCalendarDetailsModel>? super.data,
  });

  factory AcademicCalendarResponseModel.fromJson(Map<String, dynamic> json) {
    return AcademicCalendarResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] != null
          ? List<AcademicCalendarDetailsModel>.from(
              json['data'].map((x) => AcademicCalendarDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class AcademicCalendarDetailsModel extends AcademicCalendarDetails {
  AcademicCalendarDetailsModel({
    super.eventId,
    super.accYear,
    super.categoryId,
    super.categoryName,
    super.eventDate,
    super.eventTitle,
    super.eventDescription,
    super.image,
    super.standardIds,
    super.standardNames,
    super.isHoliday,
    super.isNotificationSent,
    super.branchId,
    super.createdDate,
    super.createdUser,
    super.modifiedDate,
    super.modifiedUser,
  });

  factory AcademicCalendarDetailsModel.fromJson(Map<String, dynamic> json) {
    return AcademicCalendarDetailsModel(
      eventId: json['eventId'],
      accYear: json['AccYear'],
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
      eventDate: json['eventDate'],
      eventTitle: json['eventTitle'],
      eventDescription: json['eventDescription'],
      image: json['image'],
      standardIds: json['StandardIds'],
      standardNames: json['StandardNames'],
      isHoliday: json['isHoliday'],
      isNotificationSent: json['isNotificationSent'],
      branchId: json['branchId'],
      createdDate: json['CreatedDate'],
      createdUser: json['CreatedUser'],
      modifiedDate: json['ModifiedDate'],
      modifiedUser: json['ModifiedUser'],
    );
  }
}
