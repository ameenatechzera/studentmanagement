import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';

abstract class AcademicCalendarRepository {
  ResultFuture<FetchCalendarResponse> fetchAcademicCalendar(
    FetchCalendarParameter parameter,
  );
}
