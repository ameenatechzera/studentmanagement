// // // import 'package:studentmanagement/fetaures/classdiary/domain/entities/fetch_diary_entity.dart';

// // // class FetchDiaryResponseModel extends FetchDiaryResponse {
// // //   FetchDiaryResponseModel({
// // //     super.status,
// // //     super.error,
// // //     List<FetchDiaryDetailsModel>? super.data,
// // //   });

// // //   factory FetchDiaryResponseModel.fromJson(Map<String, dynamic> json) {
// // //     return FetchDiaryResponseModel(
// // //       status: json['status'],
// // //       error: json['error'],
// // //       data: json['data'] != null
// // //           ? List<FetchDiaryDetailsModel>.from(
// // //               json['data'].map((x) => FetchDiaryDetailsModel.fromJson(x)),
// // //             )
// // //           : [],
// // //     );
// // //   }
// // // }

// // // class FetchDiaryDetailsModel extends FetchDiaryDetails {
// // //   FetchDiaryDetailsModel({
// // //     super.admno,
// // //     super.admissionId,
// // //     super.accYear,
// // //     super.sectionName,
// // //     super.name,
// // //     super.gender,
// // //     super.aadharNo,
// // //     super.father,
// // //     super.mother,
// // //     super.guardian,
// // //     super.relation,
// // //     super.occupation,
// // //     super.houseName,
// // //     super.street,
// // //     super.place,
// // //     super.post,
// // //     super.nationality,
// // //     super.state,
// // //     super.district,
// // //     super.landPhone,
// // //     super.mobile,
// // //     super.email,
// // //     super.preTcNo,
// // //     super.preTcDate,
// // //     super.pretcSchool,
// // //     super.doj,
// // //     super.dob,
// // //     super.bloodGroup,
// // //     super.religion,
// // //     super.category,
// // //     super.caste,
// // //     super.stdonAdm,
// // //     super.divonAdm,
// // //     super.madrassaAdmNo,
// // //     super.madrassaStd,
// // //     super.madrassaDiv,
// // //     super.medium,
// // //     super.firstLan,
// // //     super.secondLan,
// // //     super.motherTongue,
// // //     super.deformity,
// // //     super.identityMark1,
// // //     super.identityMark2,
// // //     super.consessionType,
// // //     super.relativeStatus,
// // //     super.busStatus,
// // //     super.activeStatus,
// // //     super.vaccinationDate,
// // //     super.motherMobile,
// // //     super.bankName,
// // //     super.accountNo,
// // //     super.artsSchool,
// // //     super.artsDistrict,
// // //     super.artsState,
// // //     super.artsNational,
// // //     super.sportsSchool,
// // //     super.sportsDistrict,
// // //     super.sportsState,
// // //     super.sportsNational,
// // //     super.previousClass,
// // //     super.dobInWords,
// // //     super.placeofBirth,
// // //     super.branchId,
// // //     super.createdDate,
// // //     super.createdUser,
// // //     super.modifiedDate,
// // //     super.modifiedUser,
// // //     super.stdIdOnAdm,
// // //     super.divIdOnAdm,
// // //     super.diaryId,
// // //     super.accYearCd,
// // //     super.standardId,
// // //     super.divisionId,
// // //     super.subjectId,
// // //     super.employeeId,
// // //     super.diaryType,
// // //     super.diaryTitle,
// // //     super.description,
// // //     super.diaryDate,
// // //     super.dueDate,
// // //     super.isActive,
// // //     super.isFavourite,
// // //     super.branchIdCd,
// // //     super.createdDateCd,
// // //     super.createdUserCd,
// // //     super.modifedDate,
// // //     super.modifedUser,
// // //     super.files,
// // //   });

// // //   factory FetchDiaryDetailsModel.fromJson(Map<String, dynamic> json) {
// // //     return FetchDiaryDetailsModel(
// // //       admno: json['Admno'],
// // //       admissionId: json['AdmissionId'],
// // //       accYear: json['AccYear'],
// // //       sectionName: json['SectionName'],
// // //       name: json['Name'],
// // //       gender: json['Gender'],
// // //       aadharNo: json['AadharNo'],
// // //       father: json['Father'],
// // //       mother: json['Mother'],
// // //       guardian: json['Guardian'],
// // //       relation: json['Relation'],
// // //       occupation: json['Occupation'],
// // //       houseName: json['HouseName'],
// // //       street: json['Street'],
// // //       place: json['Place'],
// // //       post: json['Post'],
// // //       nationality: json['Nationality'],
// // //       state: json['State'],
// // //       district: json['District'],
// // //       landPhone: json['LandPhone'],
// // //       mobile: json['Mobile'],
// // //       email: json['Email'],
// // //       preTcNo: json['PreTcNo'],
// // //       preTcDate: json['PreTcDate'],
// // //       pretcSchool: json['PretcSchool'],
// // //       doj: json['DOJ'],
// // //       dob: json['DOB'],
// // //       bloodGroup: json['BloodGroup'],
// // //       religion: json['Religion'],
// // //       category: json['Category'],
// // //       caste: json['Caste'],
// // //       stdonAdm: json['StdonAdm'],
// // //       divonAdm: json['DivonAdm'],
// // //       madrassaAdmNo: json['MadrassaAdmNo'],
// // //       madrassaStd: json['MadrassaStd'],
// // //       madrassaDiv: json['MadrassaDiv'],
// // //       medium: json['Medium'],
// // //       firstLan: json['FirstLan'],
// // //       secondLan: json['SecondLan'],
// // //       motherTongue: json['MotherTongue'],
// // //       deformity: json['Deformity'],
// // //       identityMark1: json['IdentityMark1'],
// // //       identityMark2: json['IdentityMark2'],
// // //       consessionType: json['ConsessionType'],
// // //       relativeStatus: json['RelativeStatus'],
// // //       busStatus: json['BusStatus'],
// // //       activeStatus: json['ActiveStatus'],
// // //       vaccinationDate: json['VaccinationDate'],
// // //       motherMobile: json['MotherMobile'],
// // //       bankName: json['BankName'],
// // //       accountNo: json['AccountNo'],
// // //       artsSchool: json['ArtsSchool'],
// // //       artsDistrict: json['ArtsDistrict'],
// // //       artsState: json['ArtsState'],
// // //       artsNational: json['ArtsNational'],
// // //       sportsSchool: json['SportsSchool'],
// // //       sportsDistrict: json['SportsDistrict'],
// // //       sportsState: json['SportsState'],
// // //       sportsNational: json['SportsNational'],
// // //       previousClass: json['PreviousClass'],
// // //       dobInWords: json['DOBInWords'],
// // //       placeofBirth: json['PlaceofBirth'],
// // //       branchId: json['branchId'],
// // //       createdDate: json['CreatedDate'],
// // //       createdUser: json['CreatedUser'],
// // //       modifiedDate: json['ModifiedDate'],
// // //       modifiedUser: json['ModifiedUser'],
// // //       stdIdOnAdm: json['StdIdOnAdm'],
// // //       divIdOnAdm: json['DivIdOnAdm'],
// // //       diaryId: json['diaryId'],
// // //       accYearCd: json['AccYear_cd'],
// // //       standardId: json['StandardId'],
// // //       divisionId: json['DivisionId'],
// // //       subjectId: json['SubjectId'],
// // //       employeeId: json['EmployeeId'],
// // //       diaryType: json['diaryType'],
// // //       diaryTitle: json['diaryTitle'],
// // //       description: json['Description'],
// // //       diaryDate: json['diaryDate'],
// // //       dueDate: json['dueDate'],
// // //       isActive: json['isActive'],
// // //       isFavourite: json['isFavourite'],
// // //       branchIdCd: json['branchId_cd'],
// // //       createdDateCd: json['CreatedDate_cd'],
// // //       createdUserCd: json['CreatedUser_cd'],
// // //       modifedDate: json['ModifedDate'],
// // //       modifedUser: json['ModifedUser'],
// // //       files: json['files'],
// // //     );
// // //   }
// // // }
// // import 'package:studentmanagement/fetaures/classdiary/domain/entities/fetch_diary_entity.dart';

// // class FetchDiaryResponseModel extends FetchDiaryResponse {
// //   FetchDiaryResponseModel({
// //     super.status,
// //     super.error,
// //     List<FetchDiaryDetailsModel>? super.data,
// //   });

// //   factory FetchDiaryResponseModel.fromJson(Map<String, dynamic> json) {
// //     return FetchDiaryResponseModel(
// //       status: json['status'],
// //       error: json['error'],
// //       data: json['data'] != null
// //           ? List<FetchDiaryDetailsModel>.from(
// //               json['data'].map((x) => FetchDiaryDetailsModel.fromJson(x)),
// //             )
// //           : [],
// //     );
// //   }
// // }

// // class FetchDiaryDetailsModel extends FetchDiaryDetails {
// //   FetchDiaryDetailsModel({
// //     super.admno,
// //     super.admissionId,
// //     super.accYear,
// //     super.sectionName,
// //     super.name,
// //     super.gender,
// //     super.aadharNo,
// //     super.father,
// //     super.mother,
// //     super.guardian,
// //     super.relation,
// //     super.occupation,
// //     super.houseName,
// //     super.street,
// //     super.place,
// //     super.post,
// //     super.nationality,
// //     super.state,
// //     super.district,
// //     super.landPhone,
// //     super.mobile,
// //     super.email,
// //     super.preTcNo,
// //     super.preTcDate,
// //     super.pretcSchool,
// //     super.doj,
// //     super.dob,
// //     super.bloodGroup,
// //     super.religion,
// //     super.category,
// //     super.caste,
// //     super.stdonAdm,
// //     super.divonAdm,
// //     super.madrassaAdmNo,
// //     super.madrassaStd,
// //     super.madrassaDiv,
// //     super.medium,
// //     super.firstLan,
// //     super.secondLan,
// //     super.motherTongue,
// //     super.deformity,
// //     super.identityMark1,
// //     super.identityMark2,
// //     super.consessionType,
// //     super.relativeStatus,
// //     super.busStatus,
// //     super.activeStatus,
// //     super.vaccinationDate,
// //     super.motherMobile,
// //     super.bankName,
// //     super.accountNo,
// //     super.artsSchool,
// //     super.artsDistrict,
// //     super.artsState,
// //     super.artsNational,
// //     super.sportsSchool,
// //     super.sportsDistrict,
// //     super.sportsState,
// //     super.sportsNational,
// //     super.previousClass,
// //     super.dobInWords,
// //     super.placeofBirth,
// //     super.branchId,
// //     super.createdDate,
// //     super.createdUser,
// //     super.modifiedDate,
// //     super.modifiedUser,
// //     super.stdIdOnAdm,
// //     super.divIdOnAdm,
// //     super.diaryId,
// //     super.accYearCd,
// //     super.standardId,
// //     super.divisionId,
// //     super.subjectId,
// //     super.employeeId,
// //     super.diaryType,
// //     super.diaryTitle,
// //     super.description,
// //     super.diaryDate,
// //     super.dueDate,
// //     super.isActive,
// //     super.isFavourite,
// //     super.branchIdCd,
// //     super.createdDateCd,
// //     super.createdUserCd,
// //     super.modifedDate,
// //     super.modifedUser,
// //     super.files,
// //   });

// //   factory FetchDiaryDetailsModel.fromJson(Map<String, dynamic> json) {
// //     return FetchDiaryDetailsModel(
// //       admno: json['Admno'],
// //       admissionId: json['AdmissionId'],
// //       accYear: json['AccYear'],
// //       sectionName: json['SectionName'],
// //       name: json['Name'],
// //       gender: json['Gender'],
// //       aadharNo: json['AadharNo'],
// //       father: json['Father'],
// //       mother: json['Mother'],
// //       guardian: json['Guardian'],
// //       relation: json['Relation'],
// //       occupation: json['Occupation'],
// //       houseName: json['HouseName'],
// //       street: json['Street'],

// //       // IDs coming from API
// //       place: json['PlaceId']?.toString(),
// //       post: json['PostId']?.toString(),
// //       district: json['DistrictId']?.toString(),
// //       state: json['StateId']?.toString(),
// //       nationality: json['NationalityId']?.toString(),

// //       landPhone: json['LandPhone'],
// //       mobile: json['Mobile'],
// //       email: json['Email'],
// //       preTcNo: json['PreTcNo'],
// //       preTcDate: json['PreTcDate'],
// //       pretcSchool: json['PretcSchool'],
// //       doj: json['DOJ'],
// //       dob: json['DOB'],
// //       bloodGroup: json['BloodGroup'],

// //       religion: json['ReligionId']?.toString(),
// //       category: json['CategoryId']?.toString(),
// //       caste: json['CasteId']?.toString(),

// //       stdonAdm: json['StdIdonAdm'],
// //       divonAdm: json['DivIdonAdm'],

// //       madrassaAdmNo: json['MadrassaAdmNo'],
// //       madrassaStd: json['MadrassaStdid']?.toString(),
// //       madrassaDiv: json['MadrassaDivId']?.toString(),

// //       medium: json['MediumId']?.toString(),
// //       firstLan: json['FirstLanId']?.toString(),
// //       secondLan: json['SecondLanId']?.toString(),
// //       motherTongue: json['MotherTongueId']?.toString(),

// //       deformity: json['Deformity'],
// //       identityMark1: json['IdentityMark1'],
// //       identityMark2: json['IdentityMark2'],

// //       consessionType: json['ConsessionType'],
// //       relativeStatus: json['RelativeStatus'],
// //       busStatus: json['BusStatus'],
// //       activeStatus: json['ActiveStatus'],

// //       vaccinationDate: json['VaccinationDate'],
// //       motherMobile: json['MotherMobile'],
// //       bankName: json['BankName'],
// //       accountNo: json['AccountNo'],

// //       artsSchool: json['ArtsSchool'],
// //       artsDistrict: json['ArtsDistrict'],
// //       artsState: json['ArtsState'],
// //       artsNational: json['ArtsNational'],

// //       sportsSchool: json['SportsSchool'],
// //       sportsDistrict: json['SportsDistrict'],
// //       sportsState: json['SportsState'],
// //       sportsNational: json['SportsNational'],

// //       previousClass: json['PreviousClass'],
// //       dobInWords: json['DOBInWords'],
// //       placeofBirth: json['PlaceofBirth'],

// //       branchId: json['branchId'],
// //       createdDate: json['CreatedDate'],
// //       createdUser: json['CreatedUser'],
// //       modifiedDate: json['ModifiedDate'],
// //       modifiedUser: json['ModifiedUser'],

// //       // Correct keys
// //       stdIdOnAdm: json['StdIdonAdm'] != null
// //           ? int.tryParse(json['StdIdonAdm'].toString())
// //           : null,

// //       divIdOnAdm: json['DivIdonAdm'] != null
// //           ? int.tryParse(json['DivIdonAdm'].toString())
// //           : null,

// //       diaryId: json['diaryId'],
// //       accYearCd: json['AccYear_cd'],
// //       standardId: json['StandardId'],
// //       divisionId: json['DivisionId'],
// //       subjectId: json['SubjectId'],
// //       employeeId: json['EmployeeId']?.toString(),

// //       diaryType: json['diaryType'],
// //       diaryTitle: json['diaryTitle'],
// //       description: json['Description'],
// //       diaryDate: json['diaryDate'],
// //       dueDate: json['dueDate'],

// //       isActive: json['isActive'],
// //       isFavourite: json['isFavourite'],

// //       branchIdCd: json['branchId_cd'],
// //       createdDateCd: json['CreatedDate_cd'],
// //       createdUserCd: json['CreatedUser_cd'],

// //       // Correct keys
// //       modifedDate: json['ModifiedDate_cd'],
// //       modifedUser: json['ModifiedUser_cd'],

// //       files: json['files'] != null
// //           ? List<DiaryFileModel>.from(
// //               json['files'].map((x) => DiaryFileModel.fromJson(x)),
// //             )
// //           : [],
// //     );
// //   }
// // }

// // class DiaryFileModel extends DiaryFile {
// //   DiaryFileModel({super.url, super.type});

// //   factory DiaryFileModel.fromJson(Map<String, dynamic> json) {
// //     return DiaryFileModel(url: json['url'], type: json['type']);
// //   }
// // }
// // //
// import 'dart:convert';

// import 'package:studentmanagement/fetaures/classdiary/domain/entities/fetch_diary_entity.dart';

// class FetchDiaryResponseModel extends FetchDiaryResponse {
//   FetchDiaryResponseModel({
//     super.status,
//     super.error,
//     List<FetchDiaryDetailsModel>? super.data,
//   });

//   factory FetchDiaryResponseModel.fromJson(Map<String, dynamic> json) {
//     return FetchDiaryResponseModel(
//       status: json['status'],
//       error: json['error'],
//       data: json['data'] != null
//           ? List<FetchDiaryDetailsModel>.from(
//               json['data'].map((x) => FetchDiaryDetailsModel.fromJson(x)),
//             )
//           : [],
//     );
//   }
// }

// class FetchDiaryDetailsModel extends FetchDiaryDetails {
//   FetchDiaryDetailsModel({
//     super.admissionId,
//     super.accYear,
//     super.admno,
//     super.scode,
//     super.sectionId,
//     super.name,
//     super.gender,
//     super.father,
//     super.mother,
//     super.mobile,
//     super.doj,
//     super.dob,
//     super.activeStatus,
//     super.motherMobile,
//     super.hostelStatus,
//     super.dobInWords,
//     super.diaryId,
//     super.accYearCd,
//     super.standardId,
//     super.divisionId,
//     super.subjectId,
//     super.employeeName,
//     super.employeePhoto,
//     super.diaryType,
//     super.diaryTitle,
//     super.description,
//     super.diaryDate,
//     super.dueDate,
//     super.isActive,
//     super.isFavourite,
//     super.branchIdCd,
//     super.createdDateCd,
//     super.createdUserCd,
//     super.modifiedDateCd,
//     super.modifiedUserCd,
//     List<DiaryFileModel>? super.files,
//     super.videoUrl,
//   });

//   factory FetchDiaryDetailsModel.fromJson(Map<String, dynamic> json) {
//     return FetchDiaryDetailsModel(
//       admissionId: json['AdmissionId'],
//       accYear: json['AccYear'],
//       admno: json['Admno'],
//       scode: json['Scode'],
//       sectionId: json['SectionId'],
//       name: json['Name'],
//       gender: json['Gender'],
//       father: json['Father'],
//       mother: json['Mother'],
//       mobile: json['Mobile'],
//       doj: json['DOJ'],
//       dob: json['DOB'],
//       activeStatus: json['ActiveStatus'],
//       motherMobile: json['MotherMobile'],
//       hostelStatus: json['HostelStatus'],
//       dobInWords: json['DOBInWords'],

//       diaryId: json['diaryId'],
//       accYearCd: json['AccYear_cd'],
//       standardId: json['StandardId'],
//       divisionId: json['DivisionId'],
//       subjectId: json['SubjectId'],

//       employeeName: json['EmployeeName'],
//       employeePhoto: json['EmployeePhoto'],

//       diaryType: json['diaryType'],
//       diaryTitle: json['diaryTitle'],
//       description: json['Description'],
//       diaryDate: json['diaryDate'],
//       dueDate: json['dueDate'],

//       isActive: json['isActive'],
//       isFavourite: json['isFavourite'],

//       branchIdCd: json['branchId_cd'],
//       createdDateCd: json['CreatedDate_cd'],
//       createdUserCd: json['CreatedUser_cd'],
//       modifiedDateCd: json['ModifiedDate_cd'],
//       modifiedUserCd: json['ModifiedUser_cd'],

//       files: json['files'] != null
//           ? List<DiaryFileModel>.from(
//               json['files'].map((x) => DiaryFileModel.fromJson(x)),
//             )
//           : [],
//       videoUrl: json['videoUrl'] == null
//           ? []
//           : json['videoUrl'] is String
//           ? List<String>.from(jsonDecode(json['videoUrl']))
//           : List<String>.from(json['videoUrl']),
//     );
//   }
// }

// class DiaryFileModel extends DiaryFileEntity {
//   DiaryFileModel({super.url, super.type});

//   factory DiaryFileModel.fromJson(Map<String, dynamic> json) {
//     return DiaryFileModel(url: json['url'], type: json['type']);
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/classdiary/domain/entities/fetch_diary_entity.dart';

/// =======================
/// RESPONSE MODEL
/// =======================

class FetchDiaryResponseModel extends FetchDiaryResponse {
  FetchDiaryResponseModel({super.status, super.error, super.data});

  factory FetchDiaryResponseModel.fromJson(Map<String, dynamic> json) {
    return FetchDiaryResponseModel(
      status: json['status'],
      error: json['error'],
      data: json['data'] == null
          ? []
          : List<FetchDiaryDetailsModel>.from(
              (json['data'] as List).map(
                (x) => FetchDiaryDetailsModel.fromJson(x),
              ),
            ),
    );
  }
}

/// =======================
/// DIARY MODEL
/// =======================

class FetchDiaryDetailsModel extends FetchDiaryDetails {
  FetchDiaryDetailsModel({
    super.admissionId,
    super.accYear,
    super.admno,
    super.scode,
    super.sectionId,
    super.name,
    super.gender,
    super.father,
    super.mother,
    super.mobile,
    super.doj,
    super.dob,
    super.activeStatus,
    super.motherMobile,
    super.hostelStatus,
    super.dobInWords,
    super.diaryId,
    super.accYearCd,
    super.standardId,
    super.divisionId,
    super.subjectId,
    super.employeeName,
    super.employeePhoto,
    super.diaryType,
    super.diaryTitle,
    super.description,
    super.diaryDate,
    super.dueDate,
    super.isActive,
    super.isFavourite,
    super.branchIdCd,
    super.createdDateCd,
    super.createdUserCd,
    super.modifiedDateCd,
    super.modifiedUserCd,
    super.files,
    super.videoUrl,
  });

  factory FetchDiaryDetailsModel.fromJson(Map<String, dynamic> json) {
    /// =======================
    /// FILE PARSE
    /// =======================

    List<DiaryFileEntity> parsedFiles = [];

    if (json['files'] != null && json['files'] is List) {
      parsedFiles = List<DiaryFileModel>.from(
        (json['files'] as List).map((x) => DiaryFileModel.fromJson(x)),
      );
    }

    /// =======================
    /// VIDEO PARSE
    /// =======================

    List<String> parsedVideos = [];

    try {
      final rawVideo = json['videoUrl'];

      debugPrint('');
      debugPrint('================ VIDEO PARSE START ================');
      debugPrint('TITLE => ${json['diaryTitle']}');
      debugPrint('RAW VIDEO => $rawVideo');
      debugPrint('RAW TYPE => ${rawVideo.runtimeType}');

      if (rawVideo == null) {
        debugPrint('RAW VIDEO IS NULL');
        parsedVideos = [];
      }
      /// CASE 1 : STRING
      else if (rawVideo is String) {
        debugPrint('VIDEO IS STRING');

        if (rawVideo.trim().isEmpty ||
            rawVideo.trim() == '[]' ||
            rawVideo.trim() == 'null') {
          debugPrint('EMPTY VIDEO STRING');
          parsedVideos = [];
        } else {
          try {
            dynamic decoded = jsonDecode(rawVideo);

            debugPrint('FIRST DECODE => $decoded');
            debugPrint('FIRST DECODE TYPE => ${decoded.runtimeType}');

            /// CURRENT API FORMAT
            /// String -> String -> List
            if (decoded is String) {
              debugPrint('DOUBLE ENCODED STRING DETECTED');

              decoded = jsonDecode(decoded);

              debugPrint('SECOND DECODE => $decoded');
              debugPrint('SECOND DECODE TYPE => ${decoded.runtimeType}');
            }

            if (decoded is List) {
              parsedVideos = decoded.map((e) => e.toString()).toList();

              debugPrint('VIDEO LIST COUNT => ${parsedVideos.length}');

              for (int i = 0; i < parsedVideos.length; i++) {
                debugPrint('VIDEO ITEM [$i] => ${parsedVideos[i]}');
              }
            }
          } catch (e) {
            debugPrint('JSON DECODE ERROR => $e');
          }
        }
      }
      /// CASE 2 : ALREADY LIST
      else if (rawVideo is List) {
        debugPrint('VIDEO IS ALREADY LIST');

        parsedVideos = rawVideo.map((e) => e.toString()).toList();

        debugPrint('VIDEO LIST COUNT => ${parsedVideos.length}');
      } else {
        debugPrint('UNKNOWN VIDEO FORMAT => ${rawVideo.runtimeType}');
        parsedVideos = [];
      }

      debugPrint('FINAL VIDEO COUNT => ${parsedVideos.length}');

      debugPrint('================ VIDEO PARSE END =================');
      debugPrint('');
    } catch (e, stackTrace) {
      debugPrint('VIDEO PARSE ERROR => $e');
      debugPrint('STACKTRACE => $stackTrace');
      parsedVideos = [];
    }
    // /// =======================
    // /// VIDEO PARSE
    // /// =======================

    // List<String> parsedVideos = [];

    // try {
    //   final rawVideo = json['videoUrl'];

    //   if (rawVideo == null) {
    //     parsedVideos = [];
    //   }
    //   /// STRINGIFIED ARRAY
    //   else if (rawVideo is String) {
    //     if (rawVideo.isNotEmpty) {
    //       final decoded = jsonDecode(rawVideo);

    //       if (decoded is List) {
    //         parsedVideos = List<String>.from(decoded);
    //       }
    //     }
    //   }
    //   /// NORMAL ARRAY
    //   else if (rawVideo is List) {
    //     parsedVideos = List<String>.from(rawVideo);
    //   }
    //   /// MAP / INVALID FORMAT
    //   else {
    //     parsedVideos = [];
    //   }
    // } catch (e) {
    //   debugPrint("VIDEO PARSE ERROR: $e");
    //   parsedVideos = [];
    // }
    debugPrint('RETURNING DIARY => ${json['diaryTitle']}');
    debugPrint('RETURNING VIDEO COUNT => ${parsedVideos.length}');

    if (parsedVideos.isNotEmpty) {
      debugPrint('FIRST VIDEO => ${parsedVideos.first}');
    }
    return FetchDiaryDetailsModel(
      admissionId: json['AdmissionId'],
      accYear: json['AccYear'],
      admno: json['Admno'],
      scode: json['Scode'],
      sectionId: json['SectionId'],
      name: json['Name'],
      gender: json['Gender'],
      father: json['Father'],
      mother: json['Mother'],
      mobile: json['Mobile'],
      doj: json['DOJ'],
      dob: json['DOB'],
      activeStatus: json['ActiveStatus'],
      motherMobile: json['MotherMobile'],
      hostelStatus: json['HostelStatus'],
      dobInWords: json['DOBInWords'],

      diaryId: json['diaryId'],
      accYearCd: json['AccYear_cd'],
      standardId: json['StandardId'],
      divisionId: json['DivisionId'],
      subjectId: json['SubjectId'],

      employeeName: json['EmployeeName'],
      employeePhoto: json['EmployeePhoto'],

      diaryType: json['diaryType'],
      diaryTitle: json['diaryTitle'],
      description: json['Description'],
      diaryDate: json['diaryDate'],
      dueDate: json['dueDate'],

      isActive: json['isActive'],
      isFavourite: json['isFavourite'],

      branchIdCd: json['branchId_cd'],
      createdDateCd: json['CreatedDate_cd'],
      createdUserCd: json['CreatedUser_cd'],
      modifiedDateCd: json['ModifiedDate_cd'],
      modifiedUserCd: json['ModifiedUser_cd'],

      files: parsedFiles,

      /// VIDEO
      videoUrl: parsedVideos,
    );
  }
}

/// =======================
/// FILE MODEL
/// =======================

class DiaryFileModel extends DiaryFileEntity {
  DiaryFileModel({super.url, super.type});

  factory DiaryFileModel.fromJson(Map<String, dynamic> json) {
    return DiaryFileModel(url: json['url'], type: json['type']);
  }
}
