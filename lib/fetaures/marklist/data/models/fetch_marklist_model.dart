// // import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_marklist_entity.dart';

// // class FetchMarkListResponseModel extends FetchMarkListEntity {
// //   FetchMarkListResponseModel({
// //     super.status,
// //     super.error,
// //     super.message,
// //     List<FetchMarkListDetailsModel>? super.data,
// //   });

// //   factory FetchMarkListResponseModel.fromJson(Map<String, dynamic> json) {
// //     return FetchMarkListResponseModel(
// //       status: json['status'],
// //       error: json['error'],
// //       message: json['message'],
// //       data: json['data'] != null
// //           ? List<FetchMarkListDetailsModel>.from(
// //               json['data'].map((x) => FetchMarkListDetailsModel.fromJson(x)),
// //             )
// //           : [],
// //     );
// //   }
// // }

// // class FetchMarkListDetailsModel extends FetchMarkListDetails {
// //   FetchMarkListDetailsModel({
// //     super.admno,
// //     super.te,
// //     super.ce,
// //     super.grade,
// //     super.absent,
// //     super.status,
// //     super.narration,
// //     super.name,
// //     super.gender,
// //     super.subjectName,
// //   });

// //   factory FetchMarkListDetailsModel.fromJson(Map<String, dynamic> json) {
// //     return FetchMarkListDetailsModel(
// //       admno: json['Admno'] ?? '',
// //       te: json['TE'] ?? '',
// //       ce: json['CE'] ?? '',
// //       grade: json['GRADE'] ?? '',
// //       absent: json['Absent'] ?? '',
// //       status: json['Status'] ?? '',
// //       narration: json['Narration'] ?? '',
// //       name: json['Name'] ?? '',
// //       gender: json['Gender'] ?? '',
// //       subjectName: json['SubjectName'] ?? '',
// //     );
// //   }
// // }
// import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_marklist_entity.dart';

// class FetchMarkListResponseModel extends FetchMarkListEntity {
//   FetchMarkListResponseModel({
//     super.status,
//     super.error,
//     super.message,
//     List<FetchMarkListDetailsModel>? super.data,
//   });

//   factory FetchMarkListResponseModel.fromJson(Map<String, dynamic> json) {
//     return FetchMarkListResponseModel(
//       status: json['status'],
//       error: json['error'],
//       message: json['message'],
//       data: json['data'] != null
//           ? List<FetchMarkListDetailsModel>.from(
//               json['data'].map((x) => FetchMarkListDetailsModel.fromJson(x)),
//             )
//           : [],
//     );
//   }
// }

// class FetchMarkListDetailsModel extends FetchMarkListDetails {
//   FetchMarkListDetailsModel({
//     SummaryModel? summary,
//     List<SubjectModel>? subjects,
//     StudentInfoModel? studentInfo,
//   }) : super(summary: summary, subjects: subjects, studentInfo: studentInfo);

//   factory FetchMarkListDetailsModel.fromJson(Map<String, dynamic> json) {
//     return FetchMarkListDetailsModel(
//       summary: json['summary'] != null
//           ? SummaryModel.fromJson(json['summary'])
//           : null,
//       subjects: json['subjects'] != null
//           ? List<SubjectModel>.from(
//               json['subjects'].map((x) => SubjectModel.fromJson(x)),
//             )
//           : [],
//       studentInfo: json['studentInfo'] != null
//           ? StudentInfoModel.fromJson(json['studentInfo'])
//           : null,
//     );
//   }
// }

// class SummaryModel extends SummaryEntity {
//   SummaryModel({
//     super.attendance,
//     super.percentage,
//     super.maximumMarks,
//     super.overallGrade,
//     super.overallMarks,
//   });

//   factory SummaryModel.fromJson(Map<String, dynamic> json) {
//     return SummaryModel(
//       attendance: (json['attendance'] as num?)?.toDouble(),
//       percentage: (json['percentage'] as num?)?.toDouble(),
//       maximumMarks: json['maximumMarks'],
//       overallGrade: json['overallGrade'],
//       overallMarks: json['overallMarks'],
//     );
//   }
// }

// class SubjectModel extends SubjectEntity {
//   SubjectModel({
//     super.ce,
//     super.te,
//     super.grade,
//     super.absent,
//     super.maxMark,
//     super.narration,
//     super.percentage,
//     super.subjectName,
//     super.markOutOf25,
//     super.marksObtained,
//   });

//   factory SubjectModel.fromJson(Map<String, dynamic> json) {
//     return SubjectModel(
//       ce: json['ce'],
//       te: json['te'],
//       grade: json['GRADE'],
//       absent: json['Absent'],
//       maxMark: json['max_mark'],
//       narration: json['Narration'],
//       percentage: (json['percentage'] as num?)?.toDouble(),
//       subjectName: json['SubjectName'],
//       markOutOf25: (json['mark_out_of_25'] as num?)?.toDouble(),
//       marksObtained: json['marks_obtained'],
//     );
//   }
// }

// class StudentInfoModel extends StudentInfoEntity {
//   StudentInfoModel({
//     super.dob,
//     super.name,
//     super.admno,
//     super.father,
//     super.gender,
//     super.mobile,
//     super.mother,
//     super.address,
//     super.division,
//     super.standard,
//   });

//   factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
//     return StudentInfoModel(
//       dob: json['DOB'],
//       name: json['Name'],
//       admno: json['Admno'],
//       father: json['Father'],
//       gender: json['Gender'],
//       mobile: json['Mobile'],
//       mother: json['Mother'],
//       address: json['address'],
//       division: json['Division'],
//       standard: json['Standard'],
//     );
//   }
// }
import 'package:studentmanagement/fetaures/marklist/domain/entities/fetch_marklist_entity.dart';

class FetchMarkListResponseModel extends FetchMarkListEntity {
  FetchMarkListResponseModel({
    int? status,
    bool? error,
    String? message,
    List<FetchMarkListDetailsModel>? data,
  }) : super(status: status, error: error, message: message, data: data);

  factory FetchMarkListResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchMarkListResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
      data: json['data'] == null
          ? []
          : (json['data'] as List)
                .map((e) => FetchMarkListDetailsModel.fromJson(e))
                .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data
        ?.map((e) => (e as FetchMarkListDetailsModel).toJson())
        .toList(),
  };
}

class FetchMarkListDetailsModel extends FetchMarkListDetails {
  FetchMarkListDetailsModel({
    SummaryModel? summary,
    List<SubjectModel>? subjects,
    StudentInfoModel? studentInfo,
  }) : super(summary: summary, subjects: subjects, studentInfo: studentInfo);

  factory FetchMarkListDetailsModel.fromJson(Map<String, dynamic> json) {
    return FetchMarkListDetailsModel(
      summary: json['summary'] != null
          ? SummaryModel.fromJson(json['summary'])
          : null,
      subjects: json['subjects'] == null
          ? []
          : (json['subjects'] as List)
                .map((e) => SubjectModel.fromJson(e))
                .toList(),
      studentInfo: json['studentInfo'] != null
          ? StudentInfoModel.fromJson(json['studentInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "summary": (summary as SummaryModel?)?.toJson(),
    "subjects": subjects?.map((e) => (e as SubjectModel).toJson()).toList(),
    "studentInfo": (studentInfo as StudentInfoModel?)?.toJson(),
  };
}

class SummaryModel extends SummaryEntity {
  SummaryModel({
    double? attendance,
    double? percentage,
    int? maximumMarks,
    String? overallGrade,
    int? overallMarks,
  }) : super(
         attendance: attendance,
         percentage: percentage,
         maximumMarks: maximumMarks,
         overallGrade: overallGrade,
         overallMarks: overallMarks,
       );

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      attendance: (json['attendance'] as num?)?.toDouble(),
      percentage: (json['percentage'] as num?)?.toDouble(),
      maximumMarks: json['maximumMarks'],
      overallGrade: json['overallGrade'],
      overallMarks: json['overallMarks'],
    );
  }

  Map<String, dynamic> toJson() => {
    "attendance": attendance,
    "percentage": percentage,
    "maximumMarks": maximumMarks,
    "overallGrade": overallGrade,
    "overallMarks": overallMarks,
  };
}

class SubjectModel extends SubjectEntity {
  SubjectModel({
    int? subjectId,
    String? subjectName,
    int? ce,
    int? te,
    int? maxCe,
    int? maxTe,
    int? maxMark,
    double? percentage,
    double? markOutOf25,
    int? marksObtained,
    String? grade,
    String? absent,
    String? narration,
  }) : super(
         subjectId: subjectId,
         subjectName: subjectName,
         ce: ce,
         te: te,
         maxCe: maxCe,
         maxTe: maxTe,
         maxMark: maxMark,
         percentage: percentage,
         markOutOf25: markOutOf25,
         marksObtained: marksObtained,
         grade: grade,
         absent: absent,
         narration: narration,
       );

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      subjectId: json['SubjectId'],
      subjectName: json['SubjectName'],
      ce: json['ce'],
      te: json['te'],
      maxCe: json['max_ce'],
      maxTe: json['max_te'],
      maxMark: json['max_mark'],
      percentage: (json['percentage'] as num?)?.toDouble(),
      markOutOf25: (json['mark_out_of_25'] as num?)?.toDouble(),
      marksObtained: json['marks_obtained'],
      grade: json['GRADE'],
      absent: json['Absent'],
      narration: json['Narration'],
    );
  }

  Map<String, dynamic> toJson() => {
    "SubjectId": subjectId,
    "SubjectName": subjectName,
    "ce": ce,
    "te": te,
    "max_ce": maxCe,
    "max_te": maxTe,
    "max_mark": maxMark,
    "percentage": percentage,
    "mark_out_of_25": markOutOf25,
    "marks_obtained": marksObtained,
    "GRADE": grade,
    "Absent": absent,
    "Narration": narration,
  };
}

class StudentInfoModel extends StudentInfoEntity {
  StudentInfoModel({
    String? dob,
    String? name,
    String? admno,
    String? father,
    String? gender,
    String? mobile,
    String? mother,
    String? address,
    String? division,
    String? standard,
  }) : super(
         dob: dob,
         name: name,
         admno: admno,
         father: father,
         gender: gender,
         mobile: mobile,
         mother: mother,
         address: address,
         division: division,
         standard: standard,
       );

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      dob: json['DOB'],
      name: json['Name'],
      admno: json['Admno'],
      father: json['Father'],
      gender: json['Gender'],
      mobile: json['Mobile'],
      mother: json['Mother'],
      address: json['address'],
      division: json['Division'],
      standard: json['Standard'],
    );
  }

  Map<String, dynamic> toJson() => {
    "DOB": dob,
    "Name": name,
    "Admno": admno,
    "Father": father,
    "Gender": gender,
    "Mobile": mobile,
    "Mother": mother,
    "address": address,
    "Division": division,
    "Standard": standard,
  };
}
