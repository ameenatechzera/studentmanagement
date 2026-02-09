import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/deviceRegisterResult.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/register_server_response_entity.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/deviceRegisterRequest.dart';
import 'package:studentmanagement/fetaures/authentication/domain/parameters/login_params.dart';
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
  ResultFuture<DeviceRegisterResult> deviceRegister(DeviceRegisterRequest request) async {
    try {
      final result = await remoteDataSource.checkDeviceRegisterStatus(
        request,
      );

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }
}
