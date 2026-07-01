import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/repository/academiccalender_repository.dart';

class FetchAcademicCalendarUseCase
    implements
        UseCaseWithParams<FetchCalendarResponse, FetchCalendarParameter> {
  final AcademicCalendarRepository _academicCalendarRepository;

  FetchAcademicCalendarUseCase(this._academicCalendarRepository);

  @override
  ResultFuture<FetchCalendarResponse> call(
    FetchCalendarParameter parameter,
  ) async {
    return _academicCalendarRepository.fetchAcademicCalendar(parameter);
  }
}
