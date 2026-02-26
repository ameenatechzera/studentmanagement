import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/repositories/diary_repository.dart';

class FetchDiaryUseCase
    implements UseCaseWithParams<FetchDiaryResponseModel, FetchDiaryParameter> {
  final DiaryRepository _diaryRepository;

  FetchDiaryUseCase(this._diaryRepository);

  @override
  ResultFuture<FetchDiaryResponseModel> call(
    FetchDiaryParameter params,
  ) async => _diaryRepository.fetchDiary(params);
}
