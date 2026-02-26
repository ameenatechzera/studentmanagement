import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/timetable/data/models/fetch_timetable_model.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/fetaures/timetable/domain/repositories/timettable_repository.dart';

class FetchTimeTableUseCase
    implements
        UseCaseWithParams<
          FetchTimeTableResponseModel,
          FetchTimeTableParameter
        > {
  final TimeTableRepository _timeTableRepository;

  FetchTimeTableUseCase(this._timeTableRepository);

  @override
  ResultFuture<FetchTimeTableResponseModel> call(
    FetchTimeTableParameter params,
  ) async {
    return _timeTableRepository.fetchTimeTable(params);
  }
}
