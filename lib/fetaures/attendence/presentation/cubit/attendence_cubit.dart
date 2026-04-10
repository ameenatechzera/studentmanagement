import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/usecases/attendence_reportbydate_usecase.dart';
import 'package:studentmanagement/fetaures/attendence/domain/usecases/attendence_reportbymonth_usecase.dart';

part 'attendence_state.dart';

class AttendenceCubit extends Cubit<AttendenceState> {
  final AttendanceReportByDateUseCase dateUseCase;
  final AttendanceReportByMonthUseCase monthUseCase;

  AttendenceCubit({required this.dateUseCase, required this.monthUseCase})
    : super(AttendenceInitial());

  Future<void> getAttendanceReportByDate(
    AttendanceReportByDateParameter params,
  ) async {
    emit(AttendenceLoading());

    final result = await dateUseCase(params);

    result.fold(
      (failure) => emit(AttendenceError(failure.message)),
      (data) => emit(AttendenceLoaded(data)),
    );
  }

  Future<void> getAttendanceReportByMonth(
    AttendanceReportByMonthParameter params,
  ) async {
    emit(AttendenceMonthLoading());

    final result = await monthUseCase(params);

    result.fold(
      (failure) => emit(AttendenceMonthError(failure.message)),
      (data) => emit(AttendenceMonthLoaded(data)),
    );
  }
}
