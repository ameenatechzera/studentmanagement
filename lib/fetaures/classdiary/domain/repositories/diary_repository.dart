import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/diarystatusSaveRequest.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';

abstract class DiaryRepository {
  ResultFuture<FetchDiaryResponseModel> fetchDiary(FetchDiaryParameter params);
  ResultFuture<CommonResponseModel> saveDiaryStatus(SaveDiaryStatusParameter params);
}
