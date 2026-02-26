import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/classdiary/data/datasources/diary_remote_data_source.dart';
import 'package:studentmanagement/fetaures/classdiary/data/models/fetch_diary_model.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/parameters/fetch_diary_parameter.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/repositories/diary_repository.dart';

class DiaryRepositoryImpl implements DiaryRepository {
  final DiaryRemoteDataSource remoteDataSource;

  DiaryRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<FetchDiaryResponseModel> fetchDiary(
    FetchDiaryParameter params,
  ) async {
    try {
      final result = await remoteDataSource.fetchDiary(params);
      return Right(result);
    } on ServerException catch (e) {
      throw ServerFailure(e.errorMessageModel.statusMessage);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
