part of 'earlygo_cubit.dart';

sealed class EarlygoState extends Equatable {
  const EarlygoState();

  @override
  List<Object> get props => [];
}

final class EarlygoInitial extends EarlygoState {}

class EarlyLeaveLoading extends EarlygoState {}

class EarlyLeaveLoaded extends EarlygoState {
  final FetchEarlyLeaveResponseModel response;

  const EarlyLeaveLoaded({required this.response});
}

class EarlyLeaveError extends EarlygoState {
  final String message;

  const EarlyLeaveError({required this.message});
}

class SaveEarlyLeaveLoading extends EarlygoState {}

class SaveEarlyLeaveSuccess extends EarlygoState {
  final CommonResponseModel response;

  const SaveEarlyLeaveSuccess({required this.response});
}

class SaveEarlyLeaveError extends EarlygoState {
  final String message;

  const SaveEarlyLeaveError({required this.message});
}
