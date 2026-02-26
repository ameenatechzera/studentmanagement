import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/timetable/data/models/fetch_timetable_model.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/fetaures/timetable/domain/usecases/fetch_timetable_usecase.dart';

part 'timetable_state.dart';

class TimetableCubit extends Cubit<TimetableState> {
  final FetchTimeTableUseCase fetchTimeTableUseCase;
  TimetableCubit({required this.fetchTimeTableUseCase})
    : super(TimetableInitial());
  Future<void> fetchTimeTable(FetchTimeTableParameter params) async {
    emit(TimetableLoading());

    final result = await fetchTimeTableUseCase(params);

    result.fold(
      (failure) {
        emit(TimetableError(message: failure.message));
      },
      (response) {
        emit(TimetableLoaded(response: response));
      },
    );
  }
}
