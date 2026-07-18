import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/diarystatusSaveRequest.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/repositories/diary_repository.dart';

class SaveDiaryStatusUseCase
    implements UseCaseWithParams<CommonResponseModel, SaveDiaryStatusParameter> {
  final DiaryRepository _diaryRepository;

  SaveDiaryStatusUseCase(this._diaryRepository);

  @override
  ResultFuture<CommonResponseModel> call(
      SaveDiaryStatusParameter params,
      ) async => _diaryRepository.saveDiaryStatus(params);
}
