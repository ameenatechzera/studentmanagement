part of 'diary_cubit.dart';

sealed class DiaryState extends Equatable {
  const DiaryState();

  @override
  List<Object> get props => [];
}

final class DiaryInitial extends DiaryState {}

class DiaryLoading extends DiaryState {}

class DiaryLoaded extends DiaryState {
  final FetchDiaryResponseModel response;

  const DiaryLoaded({required this.response});
}

class DiaryError extends DiaryState {
  final String message;

  const DiaryError({required this.message});
}
