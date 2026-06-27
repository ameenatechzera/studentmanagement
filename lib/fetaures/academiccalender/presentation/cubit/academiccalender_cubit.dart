import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/usecases/fetchcalenderevents_usecase.dart';

part 'academiccalender_state.dart';

class AcademiccalenderCubit extends Cubit<AcademiccalenderState> {
  final FetchAcademicCalendarUseCase fetchAcademicCalendarUseCase;
  AcademiccalenderCubit({required this.fetchAcademicCalendarUseCase})
    : super(AcademiccalenderInitial());
  Future<void> fetchAcademicCalendar() async {
    emit(AcademiccalenderLoading());

    final result = await fetchAcademicCalendarUseCase();

    result.fold(
      (failure) {
        emit(AcademiccalenderError(failure.message));
      },
      (response) {
        emit(AcademiccalenderLoaded(response));
      },
    );
  }
}
