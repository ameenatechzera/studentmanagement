// import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';

// class AttendanceReportByMonthModel extends AttendanceReportByMonthEntity {
//   AttendanceReportByMonthModel({
//     super.status,
//     super.error,
//     super.message,
//     List<AttendanceReportByMonthDetailsModel>? super.data,
//   });

//   factory AttendanceReportByMonthModel.fromJson(Map<String, dynamic> json) {
//     return AttendanceReportByMonthModel(
//       status: json['status'],
//       error: json['error'],
//       message: json['message'],
//       data: json['data'] != null
//           ? List<AttendanceReportByMonthDetailsModel>.from(
//               json['data'].map(
//                 (x) => AttendanceReportByMonthDetailsModel.fromJson(x),
//               ),
//             )
//           : [],
//     );
//   }
// }

// class AttendanceReportByMonthDetailsModel
//     extends AttendanceReportByMonthDetails {
//   AttendanceReportByMonthDetailsModel({
//     super.admno,
//     super.name,
//     super.gender,
//     super.days,
//     super.totalPresent,
//     super.totalAbsent,
//   });

//   factory AttendanceReportByMonthDetailsModel.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     // ✅ Extract Day1 → Day31 dynamically
//     Map<String, String?> daysMap = {};

//     for (int i = 1; i <= 31; i++) {
//       String key = "Day$i";
//       daysMap[key] = json[key];
//     }

//     return AttendanceReportByMonthDetailsModel(
//       admno: json['Admno'],
//       name: json['Name'],
//       gender: json['Gender'],
//       days: daysMap,
//       totalPresent: json['TotalPresent'],
//       totalAbsent: json['TotalAbsent'],
//     );
//   }
// }
import 'package:studentmanagement/fetaures/attendence/domain/entities/attendence_reportbymonth_entity.dart';

class AttendanceReportByMonthModel extends AttendanceReportByMonthEntity {
  AttendanceReportByMonthModel({
    super.status,
    super.error,
    super.message,
    List<AttendanceReportByMonthDetailsModel>? super.data,
    List<AttendanceDetailModel>? super.attendanceDetails,
  });

  factory AttendanceReportByMonthModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportByMonthModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],

      /// ✅ STUDENT DATA
      data: json['data'] != null
          ? List<AttendanceReportByMonthDetailsModel>.from(
              json['data'].map(
                (x) => AttendanceReportByMonthDetailsModel.fromJson(x),
              ),
            )
          : [],

      /// ✅ ATTENDANCE DETAILS
      attendanceDetails: json['attendanceDetails'] != null
          ? List<AttendanceDetailModel>.from(
              json['attendanceDetails'].map(
                (x) => AttendanceDetailModel.fromJson(x),
              ),
            )
          : [],
    );
  }
}

class AttendanceReportByMonthDetailsModel
    extends AttendanceReportByMonthDetails {
  AttendanceReportByMonthDetailsModel({
    super.admno,
    super.name,
    super.gender,
    super.days,
    super.totalPresent,
    super.totalAbsent,
  });

  factory AttendanceReportByMonthDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    /// ✅ EXTRACT Day1 -> Day31
    Map<String, String?> daysMap = {};

    for (int i = 1; i <= 31; i++) {
      final key = "Day$i";
      daysMap[key] = json[key];
    }

    return AttendanceReportByMonthDetailsModel(
      admno: json['Admno'],
      name: json['Name'],
      gender: json['Gender'],
      days: daysMap,
      totalPresent: json['TotalPresent'],
      totalAbsent: json['TotalAbsent'],
    );
  }
}

/// ✅ ATTENDANCE DETAIL MODEL
class AttendanceDetailModel extends AttendanceDetailEntity {
  AttendanceDetailModel({super.date, super.day, super.status, super.narration});

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      date: json['date'],
      day: json['day'],
      status: json['status'],
      narration: json['narration'],
    );
  }
}
