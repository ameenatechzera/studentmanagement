import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/timetable/data/datasources/timetable_remote_data_source.dart';
import 'package:studentmanagement/fetaures/timetable/data/models/fetch_timetable_model.dart';
import 'package:studentmanagement/fetaures/timetable/domain/parameters/fetch_timetable_parameter.dart';
import 'package:studentmanagement/fetaures/timetable/domain/repositories/timettable_repository.dart';

class TimeTableRepositoryImpl implements TimeTableRepository {
  final TimeTableRemoteDataSource remoteDataSource;

  TimeTableRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<FetchTimeTableResponseModel> fetchTimeTable(
    FetchTimeTableParameter params,
  ) async {
    try {
      final result = await remoteDataSource.fetchTimeTable(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
