import 'package:get_it/get_it.dart';
import 'package:studentmanagement/fetaures/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:studentmanagement/fetaures/authentication/data/repositories/auth_repository_impl.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/deviceRegisterUseCase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/classdiary/data/datasources/diary_remote_data_source.dart';
import 'package:studentmanagement/fetaures/classdiary/data/repositories/diary_repository_impl.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/repositories/diary_repository.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/usecases/fetch_diary_usecase.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:studentmanagement/fetaures/timetable/data/datasources/timetable_remote_data_source.dart';
import 'package:studentmanagement/fetaures/timetable/data/repositories/timetable_repository_impl.dart';
import 'package:studentmanagement/fetaures/timetable/domain/repositories/timettable_repository.dart';
import 'package:studentmanagement/fetaures/timetable/domain/usecases/fetch_timetable_usecase.dart';
import 'package:studentmanagement/fetaures/timetable/presentation/cubit/timetable_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // ------------------- AUTH -------------------
    //  Cubit
    sl.registerFactory(
      () => LoginCubit(
        loginServerUseCase: sl(),
        checkDeviceRegisterStatusUseCase: sl(),
      ),
    );
    // usecase

    sl.registerLazySingleton(() => LoginServerUseCase(sl()));
    sl.registerLazySingleton(() => CheckDeviceRegisterStatusUseCase(sl()));

    // Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );

    // ------------------- TIMETABLE -------------------

    sl.registerFactory(() => TimetableCubit(fetchTimeTableUseCase: sl()));

    sl.registerLazySingleton(() => FetchTimeTableUseCase(sl()));

    sl.registerLazySingleton<TimeTableRemoteDataSource>(
      () => TimeTableRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<TimeTableRepository>(
      () => TimeTableRepositoryImpl(remoteDataSource: sl()),
    );
    // ------------------- DIARY -------------------

    /// Cubit
    sl.registerFactory(() => DiaryCubit(fetchDiaryUseCase: sl()));

    /// UseCase
    sl.registerLazySingleton(() => FetchDiaryUseCase(sl()));

    /// Remote Data Source
    sl.registerLazySingleton<DiaryRemoteDataSource>(
      () => DiaryRemoteDataSourceImpl(),
    );

    /// Repository
    sl.registerLazySingleton<DiaryRepository>(
      () => DiaryRepositoryImpl(remoteDataSource: sl()),
    );
  }
}
