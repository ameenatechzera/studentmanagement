import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/data/models/common_response_model.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/earlygo/data/datasources/earlygo_remote_data_source.dart';
import 'package:studentmanagement/fetaures/earlygo/data/models/fetch_earlygorequest_model.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/fetch_earlygo_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/repositories/earlygo_repository.dart';

class EarlyLeaveRepositoryImpl implements EarlyLeaveRepository {
  final EarlyLeaveRemoteDataSource _remoteDataSource;

  EarlyLeaveRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<FetchEarlyLeaveResponseModel> fetchEarlyLeave(FetchEarlyGoParameter request) async {
    try {
      final result = await _remoteDataSource.fetchEarlyLeave(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<CommonResponseModel> saveEarlyLeave(
    SaveEarlyLeaveParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.saveEarlyLeave(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
