import 'package:get_it/get_it.dart';
import 'package:studentmanagement/fetaures/attendence/data/datasources/attendencereport_remote_data_source.dart';
import 'package:studentmanagement/fetaures/attendence/data/repositories/attendence_repository_impl.dart';
import 'package:studentmanagement/fetaures/attendence/domain/repositories/attendence_repository.dart';
import 'package:studentmanagement/fetaures/attendence/domain/usecases/attendence_reportbydate_usecase.dart';
import 'package:studentmanagement/fetaures/attendence/domain/usecases/attendence_reportbymonth_usecase.dart';
import 'package:studentmanagement/fetaures/attendence/presentation/cubit/attendence_cubit.dart';
import 'package:studentmanagement/fetaures/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:studentmanagement/fetaures/authentication/data/repositories/auth_repository_impl.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/device_register_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';
import 'package:studentmanagement/fetaures/classdiary/data/datasources/diary_remote_data_source.dart';
import 'package:studentmanagement/fetaures/classdiary/data/repositories/diary_repository_impl.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/repositories/diary_repository.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/usecases/fetch_diary_usecase.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/cubit/diary_cubit.dart';
import 'package:studentmanagement/fetaures/fees/data/datasources/fees_remote_data_sources.dart';
import 'package:studentmanagement/fetaures/fees/data/repositories/fees_repository_impl.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchPaidFeesDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/domain/usecases/fetchUnpaidFeeDetailsUseCase.dart';
import 'package:studentmanagement/fetaures/fees/presentation/bloc/fees_cubit.dart';
import 'package:studentmanagement/fetaures/fees/presentation/unPaidFee/un_paid_fee_cubit.dart';
import 'package:studentmanagement/fetaures/home_screen/data/datasources/feed_remote_data_source.dart';
import 'package:studentmanagement/fetaures/home_screen/data/repositories/feed_repository_impl.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/repositories/feed_repository.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/usecases/fetch_feed_usecase.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/cubit/feed_cubit.dart';
import 'package:studentmanagement/fetaures/marklist/data/datasources/marklist_remote_data_source.dart';
import 'package:studentmanagement/fetaures/marklist/data/repositories/marklist_repository_impl.dart';
import 'package:studentmanagement/fetaures/marklist/domain/repositories/marklist_repository.dart';
import 'package:studentmanagement/fetaures/marklist/domain/usecases/fetch_examterms_usecase.dart';
import 'package:studentmanagement/fetaures/marklist/domain/usecases/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/cubit/marklist_cubit.dart';
import 'package:studentmanagement/fetaures/materials/data/datasources/materials_remote_data_source.dart';
import 'package:studentmanagement/fetaures/materials/data/repositories/material_repository_impl.dart';
import 'package:studentmanagement/fetaures/materials/domain/repositories/material_repository.dart';
import 'package:studentmanagement/fetaures/materials/domain/usecases/fetch_materials_usecase.dart';
import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';
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

    /// Cubit
    sl.registerFactory(() => FeesCubit(fetchPaidFeesDetailsUseCase: sl()));

    /// Cubit
    sl.registerFactory(
      () => UnPaidFeeCubit(fetchUnPaidFeesDetailsUseCase: sl()),
    );

    /// UseCase
    sl.registerLazySingleton(() => FetchPaidFeesDetailsUseCase(sl()));
    sl.registerLazySingleton(() => FetchUnPaidFeesDetailsUseCase(sl()));

    /// Remote Data Source
    sl.registerLazySingleton<FeesRemoteDataSource>(
      () => FeesRemoteDataSourceImpl(),
    );

    /// Repository
    sl.registerLazySingleton<FeesRepository>(
      () => FeesRepositoryImpl(remoteDataSource: sl()),
    );
    // ------------------- FEED -------------------

    sl.registerFactory(() => FeedCubit(fetchFeedUseCase: sl()));

    sl.registerLazySingleton(() => FetchFeedUseCase(sl()));

    sl.registerLazySingleton<FeedRemoteDataSource>(
      () => FeedRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(remoteDataSource: sl()),
    ); // ------------------- MARKLIST -------------------

    sl.registerFactory(
      () => MarklistCubit(
        fetchExamTermsUseCase: sl(),
        fetchMarkListUseCase: sl(),
      ),
    );

    sl.registerLazySingleton(() => FetchExamTermsUseCase(sl()));
    sl.registerLazySingleton(() => FetchMarkListUseCase(sl()));

    sl.registerLazySingleton<MarkListRemoteDataSource>(
      () => MarkListRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<MarkListRepository>(
      () => MarkListRepositoryImpl(sl()),
    );

    /// ------------------- MATERIALS -------------------

    sl.registerFactory(() => MaterialCubit(fetchMaterialUseCase: sl()));

    sl.registerLazySingleton(() => FetchMaterialUseCase(sl()));

    sl.registerLazySingleton<MaterialRemoteDataSource>(
      () => MaterialRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<MaterialRepository>(
      () => MaterialRepositoryImpl(sl()),
    );

    /// ------------------- ATTENDECE BY DATE -------------------
    // ✅ Cubit
    sl.registerFactory(
      () => AttendenceCubit(
        dateUseCase: sl(),
        monthUseCase: sl(), // AttendanceReportByDateUseCase
        // AttendanceReportByMonthUseCase
      ),
    );

    sl.registerLazySingleton(() => AttendanceReportByDateUseCase(sl()));
    sl.registerLazySingleton(() => AttendanceReportByMonthUseCase(sl()));

    sl.registerLazySingleton<AttendanceRemoteDataSource>(
      () => AttendanceRemoteDataSourceImpl(),
    );

    sl.registerLazySingleton<AttendanceRepository>(
      () => AttendanceRepositoryImpl(remoteDataSource: sl()),
    );
  }
}
