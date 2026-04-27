import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/feedaction_usecase.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/fetch_feed_usecase.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchFeedUseCase fetchFeedUseCase;
  final FeedActionUseCase feedActionUseCase;

  FeedCubit({required this.fetchFeedUseCase, required this.feedActionUseCase})
    : super(FeedInitial());

  Future<void> fetchFeeds(FetchFeedParameter params) async {
    print('fetchFeeds ${params.toJson()}');
    emit(FeedLoading());

    final result = await fetchFeedUseCase(params);

    result.fold(
      (failure) {
        emit(FeedError(message: failure.message));
      },
      (response) {
        emit(FeedLoaded(response: response));
      },
    );
  }

  Future<void> feedAction(FeedActionParameter params) async {
    print('feedAction ${params.toJson()}');
    emit(FeedActionLoading());

    final result = await feedActionUseCase(params);

    result.fold(
      (failure) {
        emit(FeedActionError(message: failure.message));
      },
      (response) {
        emit(FeedActionSuccess(response: response));
      },
    );
  }
}
