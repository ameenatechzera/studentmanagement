import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/device_register_result.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getbranch_entitiy.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/getschool_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_status_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/register_server_response_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/device_register_request.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/fetchschool_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_status_parameter.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/register_server_params.dart';
import 'package:studentmanagement/fetaures/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<RegisterResponseResult> registerServer(
    RegisterServerRequest registerServerParams,
  ) async {
    try {
      final result = await remoteDataSource.registerServer(
        registerServerParams,
      );

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<LoginResponseResult> loginServer(
    LoginRequest loginRequest,
  ) async {
    try {
      final result = await remoteDataSource.loginServer(loginRequest);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<DeviceRegisterResult> deviceRegister(
    DeviceRegisterRequest request,
  ) async {
    try {
      final result = await remoteDataSource.checkDeviceRegisterStatus(request);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<FetchSchoolEntity> fetchSchools(
    FetchSchoolRequest request,
  ) async {
    try {
      final result = await remoteDataSource.fetchSchools(request);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<GetBranchEntity> getBranchDetails() async {
    try {
      final result = await remoteDataSource.getBranchDetails();

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<LoginStatusEntity> loginStatus(
    LoginStatusParameter request,
  ) async {
    try {
      final result = await remoteDataSource.loginStatus(request);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }
}
