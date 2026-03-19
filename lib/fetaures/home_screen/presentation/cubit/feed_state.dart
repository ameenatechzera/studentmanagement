part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final FetchFeedResponseModel response;

  const FeedLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class FeedError extends FeedState {
  final String message;

  const FeedError({required this.message});

  @override
  List<Object?> get props => [message];
}
