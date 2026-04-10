import 'package:studentmanagement/core/usecases/general_usecases.dart';
import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/repositories/attendence_repository.dart';

class AttendanceReportByMonthUseCase
    implements
        UseCaseWithParams<
          AttendanceReportByMonthEntity,
          AttendanceReportByMonthParameter
        > {
  final AttendanceRepository _repository;

  AttendanceReportByMonthUseCase(this._repository);

  @override
  ResultFuture<AttendanceReportByMonthEntity> call(
    AttendanceReportByMonthParameter params,
  ) async => _repository.getAttendanceReportByMonth(params);
}
