part of 'marklist_cubit.dart';

abstract class MarklistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MarklistInitial extends MarklistState {}

class ExamTermsLoading extends MarklistState {}

class ExamTermsLoaded extends MarklistState {
  final FetchExamTermResponseModel response;

  ExamTermsLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class ExamTermsError extends MarklistState {
  final String message;

  ExamTermsError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MarkListLoading extends MarklistState {}

class MarkListLoaded extends MarklistState {
  final FetchMarkListResponseModel response;

  MarkListLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class MarkListError extends MarklistState {
  final String message;

  MarkListError({required this.message});

  @override
  List<Object?> get props => [message];
}
