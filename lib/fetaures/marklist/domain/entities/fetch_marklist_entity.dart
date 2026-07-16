// // class FetchMarkListEntity {
// //   final int? status;
// //   final bool? error;
// //   final String? message;
// //   final List<FetchMarkListDetails>? data;

// //   FetchMarkListEntity({this.status, this.error, this.message, this.data});
// // }

// // class FetchMarkListDetails {
// //   final String? admno;
// //   final String? te;
// //   final String? ce;
// //   final String? grade;
// //   final String? absent;
// //   final String? status;
// //   final String? narration;
// //   final String? name;
// //   final String? gender;
// //   final String? subjectName;

// //   FetchMarkListDetails({
// //     this.admno,
// //     this.te,
// //     this.ce,
// //     this.grade,
// //     this.absent,
// //     this.status,
// //     this.narration,
// //     this.name,
// //     this.gender,
// //     this.subjectName,
// //   });
// // }
// class FetchMarkListEntity {
//   final int? status;
//   final bool? error;
//   final String? message;
//   final List<FetchMarkListDetails>? data;

//   FetchMarkListEntity({this.status, this.error, this.message, this.data});
// }

// class FetchMarkListDetails {
//   final SummaryEntity? summary;
//   final List<SubjectEntity>? subjects;
//   final StudentInfoEntity? studentInfo;

//   FetchMarkListDetails({this.summary, this.subjects, this.studentInfo});
// }

// class SummaryEntity {
//   final double? attendance;
//   final double? percentage;
//   final int? maximumMarks;
//   final String? overallGrade;
//   final int? overallMarks;

//   SummaryEntity({
//     this.attendance,
//     this.percentage,
//     this.maximumMarks,
//     this.overallGrade,
//     this.overallMarks,
//   });
// }

// class SubjectEntity {
//   final int? ce;
//   final int? te;
//   final String? grade;
//   final String? absent;
//   final int? maxMark;
//   final String? narration;
//   final double? percentage;
//   final String? subjectName;
//   final double? markOutOf25;
//   final int? marksObtained;

//   SubjectEntity({
//     this.ce,
//     this.te,
//     this.grade,
//     this.absent,
//     this.maxMark,
//     this.narration,
//     this.percentage,
//     this.subjectName,
//     this.markOutOf25,
//     this.marksObtained,
//   });
// }

// class StudentInfoEntity {
//   final String? dob;
//   final String? name;
//   final String? admno;
//   final String? father;
//   final String? gender;
//   final String? mobile;
//   final String? mother;
//   final String? address;
//   final String? division;
//   final String? standard;

//   StudentInfoEntity({
//     this.dob,
//     this.name,
//     this.admno,
//     this.father,
//     this.gender,
//     this.mobile,
//     this.mother,
//     this.address,
//     this.division,
//     this.standard,
//   });
// }
class FetchMarkListEntity {
  final int? status;
  final bool? error;
  final String? message;
  final List<FetchMarkListDetails>? data;

  FetchMarkListEntity({this.status, this.error, this.message, this.data});
}

class FetchMarkListDetails {
  final SummaryEntity? summary;
  final List<SubjectEntity>? subjects;
  final StudentInfoEntity? studentInfo;

  FetchMarkListDetails({this.summary, this.subjects, this.studentInfo});
}

class SummaryEntity {
  final double? attendance;
  final double? percentage;
  final int? maximumMarks;
  final String? overallGrade;
  final int? overallMarks;

  SummaryEntity({
    this.attendance,
    this.percentage,
    this.maximumMarks,
    this.overallGrade,
    this.overallMarks,
  });
}

class SubjectEntity {
  final int? subjectId;
  final String? subjectName;

  final int? ce;
  final int? te;

  final int? maxCe;
  final int? maxTe;
  final int? maxMark;

  final double? percentage;
  final double? markOutOf25;
  final int? marksObtained;

  final String? grade;
  final String? absent;
  final String? narration;

  SubjectEntity({
    this.subjectId,
    this.subjectName,
    this.ce,
    this.te,
    this.maxCe,
    this.maxTe,
    this.maxMark,
    this.percentage,
    this.markOutOf25,
    this.marksObtained,
    this.grade,
    this.absent,
    this.narration,
  });
}

class StudentInfoEntity {
  final String? dob;
  final String? name;
  final String? admno;
  final String? father;
  final String? gender;
  final String? mobile;
  final String? mother;
  final String? address;
  final String? division;
  final String? standard;

  StudentInfoEntity({
    this.dob,
    this.name,
    this.admno,
    this.father,
    this.gender,
    this.mobile,
    this.mother,
    this.address,
    this.division,
    this.standard,
  });
}
