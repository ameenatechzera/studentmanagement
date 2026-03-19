import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/fetch_feed_usecase.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchFeedUseCase fetchFeedUseCase;

  FeedCubit({required this.fetchFeedUseCase}) : super(FeedInitial());

  Future<void> fetchFeeds(FetchFeedParameter params) async {
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
}
