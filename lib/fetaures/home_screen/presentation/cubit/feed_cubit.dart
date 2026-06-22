import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studentmanagement/core/database/app_database.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/getschool_usecase.dart';
import 'package:studentmanagement/fetaures/home_screen/data/local/dao/feed_dao.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
import 'package:studentmanagement/fetaures/home_screen/data/repositories/feed_local_repository.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
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
  final FeedLocalRepository feedLocalRepository;
  FeedCubit({
    required this.fetchFeedUseCase,
    required this.feedActionUseCase,
    required this.fetchSchoolUseCase,
    required this.feedLocalRepository,
  }) : super(FeedInitial());

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
          await pref.setAppStoreVersion(
            response.schoolDetails!.first.appStoreVersion!,
          );
          await pref.setPlayStoreVersion(
            response.schoolDetails!.first.playStoreVersion!,
          );
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
      (response) async {
        // ✅ API SUCCESS → SAVE TO LOCAL DB

        // await feedLocalRepository.clearFeeds();
        // await feedLocalRepository.saveFeeds(response.data ?? []);

        emit(FeedLoaded(response: response));
      },
    );
  }
  // Future<void> fetchFeeds(FetchFeedParameter params) async {
  //   emit(FeedLoading());

  //   final result = await fetchFeedUseCase(params);

  //   await result.fold(
  //     (failure) async {
  //       print("API FAILED: ${failure.message}");

  //       final localData = await feedLocalRepository.getFeeds();
  //       print("LOCAL FALLBACK COUNT: ${localData.length}");

  //       emit(FeedError(message: failure.message));
  //     },
  //     (response) async {
  //       final apiFeeds = response.data ?? [];

  //       print("API FEEDS COUNT: ${apiFeeds.length}");

  //       if (apiFeeds.isNotEmpty) {
  //         //await feedLocalRepository.clearFeeds();
  //         await feedLocalRepository.saveFeeds(apiFeeds);
  //       } else {
  //         print("API EMPTY. KEEPING OLD LOCAL DATA.");
  //       }

  //       final localData = await feedLocalRepository.getFeeds();
  //       print("LOCAL DB COUNT AFTER SAVE: ${localData.length}");

  //       emit(FeedLoaded(response: response));
  //     },
  //   );
  // }

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
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
// import 'package:studentmanagement/fetaures/authentication/domain/usecases/getschool_usecase.dart';
// import 'package:studentmanagement/fetaures/home_screen/data/models/feedaction_model.dart';
// import 'package:studentmanagement/fetaures/home_screen/data/models/fetchfeed_model.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/parameters/feedaction_parameter.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/parameters/fetchfeed_parameter.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/usecases/feedaction_usecase.dart';
// import 'package:studentmanagement/fetaures/home_screen/domain/usecases/fetch_feed_usecase.dart';
// import 'package:studentmanagement/fetaures/home_screen/data/repositories/feed_local_repository.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';

// part 'feed_state.dart';

// class FeedCubit extends Cubit<FeedState> {
//   final FetchFeedUseCase fetchFeedUseCase;
//   final FeedActionUseCase feedActionUseCase;
//   final FetchSchoolUseCase fetchSchoolUseCase;
//   final FeedLocalRepository feedLocalRepository;

//   FeedCubit({
//     required this.fetchFeedUseCase,
//     required this.feedActionUseCase,
//     required this.fetchSchoolUseCase,
//     required this.feedLocalRepository,
//   }) : super(FeedInitial());

//   // =====================================================
//   // 🌐 1. API ONLY
//   // =====================================================
//   Future<List<FeedDetails>> fetchFeedsFromApi(FetchFeedParameter params) async {
//     final result = await fetchFeedUseCase(params);

//     return result.fold(
//       (failure) {
//         throw Exception(failure.message);
//       },
//       (response) {
//         return response.data ?? [];
//       },
//     );
//   }

//   // =====================================================
//   // 💾 2. LOCAL SAVE ONLY
//   // =====================================================
//   Future<void> syncFeedsToLocal(List<FeedDetails> apiFeeds) async {
//     if (apiFeeds.isNotEmpty) {
//       print("1️⃣ BEFORE CLEAR");

//       await feedLocalRepository.clearFeeds();
//       print("2️⃣ BEFORE SAVE");
//       await feedLocalRepository.saveFeeds(apiFeeds);
//       print("3️⃣ AFTER SAVE");
//     }
//   }

//   // =====================================================
//   // 📥 3. LOCAL READ ONLY
//   // =====================================================
//   Future<List<FeedDetails>> loadFeedsFromLocal() async {
//     return await feedLocalRepository.getFeeds();
//   }

//   // =====================================================
//   // 🚀 4. MAIN FLOW (OFFLINE-FIRST)
//   // =====================================================
//   // Future<void> fetchFeeds(FetchFeedParameter params) async {
//   //   emit(FeedLoading());

//   //   try {
//   //     // 1️⃣ CHECK LOCAL FIRST
//   //     final localData = await loadFeedsFromLocal();

//   //     if (localData.isNotEmpty) {
//   //       emit(FeedLoadedFromLocal(localData));
//   //       return;
//   //     }

//   //     // 2️⃣ API CALL
//   //     final apiFeeds = await fetchFeedsFromApi(params);

//   //     // 3️⃣ SAVE TO LOCAL
//   //     await syncFeedsToLocal(apiFeeds);

//   //     // 4️⃣ LOAD FROM LOCAL AGAIN (SOURCE OF TRUTH)
//   //     final updatedLocal = await loadFeedsFromLocal();

//   //     emit(FeedLoadedFromLocal(updatedLocal));
//   //   } catch (e) {
//   //     emit(FeedError(message: e.toString()));
//   //   }
//   // }
//   Future<void> fetchFeeds(FetchFeedParameter params) async {
//     print("🔥 CUBIT fetchFeeds START");

//     emit(FeedLoading());

//     try {
//       final localData = await loadFeedsFromLocal();

//       if (localData.isNotEmpty) {
//         emit(FeedLoadedFromLocal(localData));
//         return;
//       }
//       print("A");

//       final apiFeeds = await fetchFeedsFromApi(params);
//       print("B");
//       print("✅ API SUCCESS");

//       print("API Feed Image => ${apiFeeds.first.image}");

//       await syncFeedsToLocal(apiFeeds);
//       print("C");
//       final updatedLocal = await loadFeedsFromLocal();
//       print("D");
//       print("LOCAL Feed Image => ${updatedLocal.first.image}");

//       emit(FeedLoadedFromLocal(updatedLocal));
//     } catch (e) {
//       print("❌ API ERROR: $e");
//       emit(FeedError(message: e.toString()));
//       print("E");
//     }
//   }

//   // =====================================================
//   // 🔄 REFRESH (FOR PULL TO REFRESH)
//   // =====================================================
//   Future<void> refreshFeeds(FetchFeedParameter params) async {
//     emit(FeedLoading());

//     try {
//       final apiFeeds = await fetchFeedsFromApi(params);

//       await syncFeedsToLocal(apiFeeds);

//       final updatedLocal = await loadFeedsFromLocal();

//       emit(FeedLoadedFromLocal(updatedLocal));
//     } catch (e) {
//       emit(FeedError(message: e.toString()));
//     }
//   }

//   // =====================================================
//   // ❤️ FEED ACTION (LIKE / SHARE)
//   // =====================================================
//   Future<void> feedAction(FeedActionParameter params) async {
//     emit(FeedActionLoading());

//     final result = await feedActionUseCase(params);

//     result.fold(
//       (failure) => emit(FeedActionError(message: failure.message)),
//       (response) => emit(FeedActionSuccess(response: response)),
//     );
//   }
// }
