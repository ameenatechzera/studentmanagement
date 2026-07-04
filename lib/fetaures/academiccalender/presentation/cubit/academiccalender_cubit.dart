import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/usecases/fetchcalenderevents_usecase.dart';

part 'academiccalender_state.dart';

class AcademiccalenderCubit extends Cubit<AcademiccalenderState> {
  final FetchAcademicCalendarUseCase fetchAcademicCalendarUseCase;

  AcademiccalenderCubit({required this.fetchAcademicCalendarUseCase})
    : super(AcademiccalenderInitial());

  Future<void> fetchAcademicCalendar(FetchCalendarParameter parameter) async {
    emit(AcademiccalenderLoading());

    final result = await fetchAcademicCalendarUseCase(parameter);

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
