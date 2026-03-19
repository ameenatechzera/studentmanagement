import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/marklist/data/datasources/marklist_remote_data_source.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_examterm_model.dart';
import 'package:studentmanagement/fetaures/marklist/data/models/fetch_marklist_model.dart';
import 'package:studentmanagement/fetaures/marklist/domain/parameter/fetch_marklist_parameter.dart';
import 'package:studentmanagement/fetaures/marklist/domain/repositories/marklist_repository.dart';

class MarkListRepositoryImpl implements MarkListRepository {
  final MarkListRemoteDataSource _remoteDataSource;

  MarkListRepositoryImpl(this._remoteDataSource);

  @override
  ResultFuture<FetchExamTermResponseModel> fetchExamTerms() async {
    try {
      final result = await _remoteDataSource.fetchExamTerms();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  ResultFuture<FetchMarkListResponseModel> fetchMarkList(
    FetchMarkListParameter params,
  ) async {
    try {
      final result = await _remoteDataSource.fetchMarkList(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
