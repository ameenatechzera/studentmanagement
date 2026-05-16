import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/getschool_usecase.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/feedaction_usecase.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/fetch_feed_usecase.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

part 'feed_state.dart';

class FeedCubit extends Cubit<FeedState> {
  final FetchFeedUseCase fetchFeedUseCase;
  final FeedActionUseCase feedActionUseCase;
  final FetchSchoolUseCase fetchSchoolUseCase;

  FeedCubit({required this.fetchFeedUseCase, required this.feedActionUseCase , required this.fetchSchoolUseCase})
    : super(FeedInitial());


  Future<void> fetchVersionDetails(FetchSchoolRequest request) async {
    print('FetchSchoolRequest: ${request.toJson()}');

    emit(VersionLoading());

    try {
      final result = await fetchSchoolUseCase(request);

      result.fold(
            (failure) {
          print('❌ FetchSchool failure: ${failure.message}');
          emit(VersionFetchError(failure.message));
        },
            (response) async {
          print("schoolResponse $response");
          final pref = SharedPreferenceHelper();
          await pref.setAppStoreVersion(response.schoolDetails!.first.appStoreVersion!);
          await pref.setPlayStoreVersion(response.schoolDetails!.first.playStoreVersion!);
          emit(VersionFetchSuccess(response));
        },
      );
    } catch (e, stacktrace) {
      print('❌ Exception during fetchSchools: $e');
      print('Stacktrace: $stacktrace');
      emit(VersionFetchError('An unexpected error occurred'));
    }
  }
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
