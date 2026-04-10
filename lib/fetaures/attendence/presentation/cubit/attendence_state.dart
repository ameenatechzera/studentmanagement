part of 'attendence_cubit.dart';

abstract class AttendenceState extends Equatable {
  const AttendenceState();

  @override
  List<Object?> get props => [];
}

class AttendenceInitial extends AttendenceState {}

class AttendenceLoading extends AttendenceState {}

class AttendenceLoaded extends AttendenceState {
  final AttendanceReportByDateEntity response;

  const AttendenceLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class AttendenceError extends AttendenceState {
  final String message;

  const AttendenceError(this.message);

  @override
  List<Object?> get props => [message];
}

class AttendenceMonthLoading extends AttendenceState {}

class AttendenceMonthLoaded extends AttendenceState {
  final AttendanceReportByMonthEntity data;

  const AttendenceMonthLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class AttendenceMonthError extends AttendenceState {
  final String message;

  const AttendenceMonthError(this.message);

  @override
  List<Object?> get props => [message];
}
