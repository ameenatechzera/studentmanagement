part of 'timetable_cubit.dart';

sealed class TimetableState extends Equatable {
  const TimetableState();

  @override
  List<Object> get props => [];
}

final class TimetableInitial extends TimetableState {}

class TimetableLoading extends TimetableState {}

class TimetableLoaded extends TimetableState {
  final FetchTimeTableResponseModel response;

  const TimetableLoaded({required this.response});
}

class TimetableError extends TimetableState {
  final String message;

  const TimetableError({required this.message});
}
