import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/timetable/data/models/fetch_timetable_model.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';

abstract class TimeTableRepository {
  ResultFuture<FetchTimeTableResponseModel> fetchTimeTable(
    FetchTimeTableParameter params,
  );
}
