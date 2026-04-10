import 'package:studentmanagement/core/utils/typedef.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbydate_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbydate_parameter.dart';
import 'package:studentmanagement/fetaures/attendence/domain/parameters/attendence_reportbymonth_parameter.dart';

abstract class AttendanceRepository {
  ResultFuture<AttendanceReportByDateEntity> getAttendanceReportByDate(
    AttendanceReportByDateParameter params,
  );
  // ✅ NEW (Add this)
  ResultFuture<AttendanceReportByMonthEntity> getAttendanceReportByMonth(
    AttendanceReportByMonthParameter params,
  );
}
