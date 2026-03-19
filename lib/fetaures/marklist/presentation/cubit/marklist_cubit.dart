import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_examterm_model.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_marklist_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/domain/usecases/fetch_examterms_usecase.dart';
import 'package:studentmanagement/fetaures/marklist/domain/usecases/fetch_marklist_parameter.dart';

part 'marklist_state.dart';

class MarklistCubit extends Cubit<MarklistState> {
  final FetchExamTermsUseCase fetchExamTermsUseCase;
  final FetchMarkListUseCase fetchMarkListUseCase;
  MarklistCubit({
    required this.fetchExamTermsUseCase,
    required this.fetchMarkListUseCase,
  }) : super(MarklistInitial());

  Future<void> fetchExamTerms() async {
    emit(ExamTermsLoading());

    final result = await fetchExamTermsUseCase();

    result.fold(
      (failure) {
        emit(ExamTermsError(message: failure.message));
      },
      (response) {
        emit(ExamTermsLoaded(response: response));
      },
    );
  }

  /// 🔹 Fetch MarkList (with params)
  Future<void> fetchMarkList(FetchMarkListParameter params) async {
    emit(MarkListLoading());

    final result = await fetchMarkListUseCase(params);

    result.fold(
      (failure) {
        emit(MarkListError(message: failure.message));
      },
      (response) {
        emit(MarkListLoaded(response: response));
      },
    );
  }
}
