import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';

abstract class AcademicCalendarRepository {
  ResultFuture<AcademicCalendarResponseModel> fetchAcademicCalendar();
}
