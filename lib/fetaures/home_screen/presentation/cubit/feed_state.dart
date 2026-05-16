part of 'feed_cubit.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class VersionLoading extends FeedState {}

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


class VersionFetchError extends FeedState {
  final String message;

  const VersionFetchError(this.message);
}

class VersionFetchSuccess extends FeedState {
  final FetchSchoolEntity response;

  const VersionFetchSuccess(this.response);
}

class FeedActionLoading extends FeedState {
  const FeedActionLoading();

  @override
  List<Object?> get props => [];
}

class FeedActionSuccess extends FeedState {
  final FeedActionResponseModel response;

  const FeedActionSuccess({required this.response});

  @override
  List<Object?> get props => [response];
}

class FeedActionError extends FeedState {
  final String message;

  const FeedActionError({required this.message});

  @override
  List<Object?> get props => [message];
}
