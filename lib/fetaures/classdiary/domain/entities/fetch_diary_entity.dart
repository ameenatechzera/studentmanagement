class FetchDiaryResponse {
  final int? status;
  final bool? error;
  final List<FetchDiaryDetails>? data;

  FetchDiaryResponse({this.status, this.error, this.data});
}

class FetchDiaryDetails {
  final String? admno;
  final int? admissionId;
  final String? accYear;
  final String? sectionName;
  final String? name;
  final String? gender;
  final String? aadharNo;
  final String? father;
  final String? mother;
  final String? guardian;
  final String? relation;
  final String? occupation;
  final String? houseName;
  final String? street;
  final String? place;
  final String? post;
  final String? nationality;
  final String? state;
  final String? district;
  final String? landPhone;
  final String? mobile;
  final String? email;
  final String? preTcNo;
  final String? preTcDate;
  final String? pretcSchool;
  final String? doj;
  final String? dob;
  final String? bloodGroup;
  final String? religion;
  final String? category;
  final String? caste;
  final String? stdonAdm;
  final String? divonAdm;
  final String? madrassaAdmNo;
  final String? madrassaStd;
  final String? madrassaDiv;
  final String? medium;
  final String? firstLan;
  final String? secondLan;
  final String? motherTongue;
  final String? deformity;
  final String? identityMark1;
  final String? identityMark2;
  final String? consessionType;
  final bool? relativeStatus;
  final bool? busStatus;
  final String? activeStatus;
  final String? vaccinationDate;
  final String? motherMobile;
  final String? bankName;
  final String? accountNo;
  final String? artsSchool;
  final String? artsDistrict;
  final String? artsState;
  final String? artsNational;
  final String? sportsSchool;
  final String? sportsDistrict;
  final String? sportsState;
  final String? sportsNational;
  final String? previousClass;
  final String? dobInWords;
  final String? placeofBirth;
  final int? branchId;
  final String? createdDate;
  final String? createdUser;
  final String? modifiedDate;
  final String? modifiedUser;
  final int? stdIdOnAdm;
  final int? divIdOnAdm;

  // Diary Fields
  final int? diaryId;
  final String? accYearCd;
  final int? standardId;
  final int? divisionId;
  final int? subjectId;
  final String? employeeId;
  final String? diaryType;
  final String? diaryTitle;
  final String? description;
  final String? diaryDate;
  final String? dueDate;
  final bool? isActive;
  final bool? isFavourite;
  final int? branchIdCd;
  final String? createdDateCd;
  final String? createdUserCd;
  final String? modifedDate;
  final String? modifedUser;
  final dynamic files;

  FetchDiaryDetails({
    this.admno,
    this.admissionId,
    this.accYear,
    this.sectionName,
    this.name,
    this.gender,
    this.aadharNo,
    this.father,
    this.mother,
    this.guardian,
    this.relation,
    this.occupation,
    this.houseName,
    this.street,
    this.place,
    this.post,
    this.nationality,
    this.state,
    this.district,
    this.landPhone,
    this.mobile,
    this.email,
    this.preTcNo,
    this.preTcDate,
    this.pretcSchool,
    this.doj,
    this.dob,
    this.bloodGroup,
    this.religion,
    this.category,
    this.caste,
    this.stdonAdm,
    this.divonAdm,
    this.madrassaAdmNo,
    this.madrassaStd,
    this.madrassaDiv,
    this.medium,
    this.firstLan,
    this.secondLan,
    this.motherTongue,
    this.deformity,
    this.identityMark1,
    this.identityMark2,
    this.consessionType,
    this.relativeStatus,
    this.busStatus,
    this.activeStatus,
    this.vaccinationDate,
    this.motherMobile,
    this.bankName,
    this.accountNo,
    this.artsSchool,
    this.artsDistrict,
    this.artsState,
    this.artsNational,
    this.sportsSchool,
    this.sportsDistrict,
    this.sportsState,
    this.sportsNational,
    this.previousClass,
    this.dobInWords,
    this.placeofBirth,
    this.branchId,
    this.createdDate,
    this.createdUser,
    this.modifiedDate,
    this.modifiedUser,
    this.stdIdOnAdm,
    this.divIdOnAdm,
    this.diaryId,
    this.accYearCd,
    this.standardId,
    this.divisionId,
    this.subjectId,
    this.employeeId,
    this.diaryType,
    this.diaryTitle,
    this.description,
    this.diaryDate,
    this.dueDate,
    this.isActive,
    this.isFavourite,
    this.branchIdCd,
    this.createdDateCd,
    this.createdUserCd,
    this.modifedDate,
    this.modifedUser,
    this.files,
  });
}
