import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/fees/data/datasources/fees_remote_data_sources.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/paidFeeResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/entities/unpaidFeeResult.dart';
import 'package:studentmanagement/fetaures/fees/domain/parameters/paidFees_request.dart';
import 'package:studentmanagement/fetaures/fees/domain/repositories/fees_repository.dart';

class FeesRepositoryImpl implements FeesRepository {
  final FeesRemoteDataSource remoteDataSource;

  FeesRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<PaidFeeResult> fetchPaidFees(PaidFeesRequest request) async {
    try {
      final result =
      await remoteDataSource.fetchPaidFees(
        request,
      );

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<UnpaidFeeResult> fetchUnPaidFees(PaidFeesRequest request) async {
    try {
      final result =
          await remoteDataSource.fetchUnPaidFees(
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