import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/usecases/fetch_diary_usecase.dart';

part 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  final FetchDiaryUseCase fetchDiaryUseCase;
  DiaryCubit({required this.fetchDiaryUseCase}) : super(DiaryInitial());
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
}
