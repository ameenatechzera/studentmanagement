import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/diarystatusSaveRequest.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/usecases/fetch_diary_usecase.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/usecases/saveDiaryStatusUseCase.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final FetchDiaryUseCase fetchDiaryUseCase;
  final SaveDiaryStatusUseCase saveDiaryStatusUseCase;
  DiaryCubit({required this.fetchDiaryUseCase , required this.saveDiaryStatusUseCase}) : super(DiaryInitial());
  Future<void> fetchDiary(FetchDiaryParameter params) async {
    emit(DiaryLoading());

    final result = await fetchDiaryUseCase(params);

    result.fold(
      (failure) {
        emit(DiaryError(message: failure.message));
      },
      (response) {
        emit(DiaryLoaded(response: response));
      },
    );
  }
  Future<void> saveDiaryStatus(SaveDiaryStatusParameter params) async {
    print('SaveDiaryStatusParameter ${params.toJson()}');
    emit(DiarySaveStatusLoading());

    final result = await saveDiaryStatusUseCase(params);

    result.fold(
          (failure) {
        emit(DiarySaveStatusError(message: failure.message));
      },
          (response) {
        emit(DiaryStatusCompleted(response: response));
      },
    );
  }
}
