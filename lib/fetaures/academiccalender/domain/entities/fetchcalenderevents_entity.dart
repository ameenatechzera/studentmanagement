class FetchCalendarResponse {
  final int? status;
  final bool? error;
  final List<CalendarMonthDetails>? data;

  FetchCalendarResponse({this.status, this.error, this.data});
}

class CalendarMonthDetails {
  final String? month;
  final int? monthNo;
  final List<CalendarEventDetails>? events;

  CalendarMonthDetails({this.month, this.monthNo, this.events});
}

class CalendarEventDetails {
  final int? eventId;
  final String? eventDate;
  final String? eventTitle;
  final String? eventDescription;
  final String? image;
  final String? isHoliday;
  final int? categoryId;
  final String? categoryName;
  final String? colorCode;
  final String? icon;

  CalendarEventDetails({
    this.eventId,
    this.eventDate,
    this.eventTitle,
    this.eventDescription,
    this.image,
    this.isHoliday,
    this.categoryId,
    this.categoryName,
    this.colorCode,
    this.icon,
  });
}
