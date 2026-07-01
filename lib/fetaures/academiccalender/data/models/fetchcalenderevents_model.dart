import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';

class FetchCalendarResponseModel extends FetchCalendarResponse {
  FetchCalendarResponseModel({
    super.status,
    super.error,
    List<CalendarMonthDetailsModel>? super.data,
  });

  factory FetchCalendarResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchCalendarResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] != null
          ? List<CalendarMonthDetailsModel>.from(
              json['data'].map((x) => CalendarMonthDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class CalendarMonthDetailsModel extends CalendarMonthDetails {
  CalendarMonthDetailsModel({
    super.month,
    super.monthNo,
    List<CalendarEventDetailsModel>? super.events,
  });

  factory CalendarMonthDetailsModel.fromJson(Map<String, dynamic> json) {
    return CalendarMonthDetailsModel(
      month: json['month'],
      monthNo: json['monthNo'],
      events: json['events'] != null
          ? List<CalendarEventDetailsModel>.from(
              json['events'].map((x) => CalendarEventDetailsModel.fromJson(x)),
            )
          : [],
    );
  }
}

class CalendarEventDetailsModel extends CalendarEventDetails {
  CalendarEventDetailsModel({
    super.eventId,
    super.eventDate,
    super.eventTitle,
    super.eventDescription,
    super.image,
    super.isHoliday,
    super.categoryId,
    super.categoryName,
    super.colorCode,
    super.icon,
  });

  factory CalendarEventDetailsModel.fromJson(Map<String, dynamic> json) {
    return CalendarEventDetailsModel(
      eventId: json['eventId'],
      eventDate: json['eventDate'],
      eventTitle: json['eventTitle'],
      eventDescription: json['eventDescription'],
      image: json['image'],
      isHoliday: json['isHoliday'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      colorCode: json['colorCode'],
      icon: json['icon'],
    );
  }
}
