part of 'academiccalender_cubit.dart';

sealed class AcademiccalenderState extends Equatable {
  const AcademiccalenderState();

  @override
  List<Object> get props => [];
}

final class AcademiccalenderInitial extends AcademiccalenderState {}

class AcademiccalenderLoading extends AcademiccalenderState {}

class AcademiccalenderLoaded extends AcademiccalenderState {
  final FetchCalendarResponse response;

  const AcademiccalenderLoaded(this.response);
}

class AcademiccalenderError extends AcademiccalenderState {
  final String message;

  const AcademiccalenderError(this.message);
}
