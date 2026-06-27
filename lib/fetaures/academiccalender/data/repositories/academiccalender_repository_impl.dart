import 'package:dartz/dartz.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/datasources/academiccalender_remote_data_source.dart';
import 'package:studentmanagement/fetaures/academiccalender/data/models/fetchcalenderevents_model.dart';
import 'package:studentmanagement/fetaures/academiccalender/domain/repository/academiccalender_repository.dart';

class AcademicCalendarRepositoryImpl implements AcademicCalendarRepository {
  final AcademicCalendarRemoteDataSource remoteDataSource;

  AcademicCalendarRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<AcademicCalendarResponseModel> fetchAcademicCalendar() async {
    try {
      final result = await remoteDataSource.fetchAcademicCalendar();

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.statusMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
