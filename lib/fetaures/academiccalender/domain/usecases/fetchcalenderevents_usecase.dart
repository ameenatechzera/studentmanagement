import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/repository/academiccalender_repository.dart';

class FetchAcademicCalendarUseCase
    implements UseCaseWithoutParams<AcademicCalendarResponseModel> {
  final AcademicCalendarRepository _academicCalendarRepository;

  FetchAcademicCalendarUseCase(this._academicCalendarRepository);

  @override
  ResultFuture<AcademicCalendarResponseModel> call() async {
    return _academicCalendarRepository.fetchAcademicCalendar();
  }
}
