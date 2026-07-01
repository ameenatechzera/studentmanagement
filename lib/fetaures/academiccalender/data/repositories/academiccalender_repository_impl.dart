import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/datasources/academiccalender_remote_data_source.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/entities/fetchcalenderevents_entity.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/parameters/fetchcalender_parameter.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/repository/academiccalender_repository.dart';

class AcademicCalendarRepositoryImpl implements AcademicCalendarRepository {
  final AcademicCalendarRemoteDataSource remoteDataSource;

  AcademicCalendarRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<FetchCalendarResponse> fetchAcademicCalendar(
    FetchCalendarParameter parameter,
  ) async {
    try {
      final result = await remoteDataSource.fetchAcademicCalendar(parameter);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
