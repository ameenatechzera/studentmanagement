

import 'package:get_it/get_it.dart';
import 'package:studentmanagement/fetaures/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:studentmanagement/fetaures/authentication/data/repositories/auth_repository_impl.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';
import 'package:studentmanagement/fetaures/authentication/domain/usecases/login_usecase.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/bloc/logincubit/login_cubit.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // ------------------- AUTH -------------------
    //  Cubit
    sl.registerFactory(() => LoginCubit(loginServerUseCase: sl()));
    // usecase

    sl.registerLazySingleton(() => LoginServerUseCase(sl()));
    // Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );

    // repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );




  }
}
