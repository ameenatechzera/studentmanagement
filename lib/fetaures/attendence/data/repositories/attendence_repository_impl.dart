import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/exceptions.dart';
import 'package:studentmanagement/core/errors/failure.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/attendence/data/datasources/attendencereport_remote_data_source.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/repositories/attendence_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  ResultFuture<AttendanceReportByDateEntity> getAttendanceReportByDate(
    AttendanceReportByDateParameter params,
  ) async {
    try {
      final result = await remoteDataSource.getAttendanceReportByDate(params);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }

  @override
  ResultFuture<AttendanceReportByMonthEntity> getAttendanceReportByMonth(
    AttendanceReportByMonthParameter params,
  ) async {
    try {
      final result = await remoteDataSource.getAttendanceReportByMonth(params);

      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    } on DioException catch (failure) {
      return Left(ServerFailure(failure.message.toString()));
    }
  }
}
