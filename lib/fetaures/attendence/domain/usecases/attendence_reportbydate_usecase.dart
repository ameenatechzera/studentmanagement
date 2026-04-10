import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/repositories/attendence_repository.dart';

class AttendanceReportByDateUseCase
    implements
        UseCaseWithParams<
          AttendanceReportByDateEntity,
          AttendanceReportByDateParameter
        > {
  final AttendanceRepository _repository;

  AttendanceReportByDateUseCase(this._repository);

  @override
  ResultFuture<AttendanceReportByDateEntity> call(
    AttendanceReportByDateParameter params,
  ) async => _repository.getAttendanceReportByDate(params);
}
