import 'package:equatable/equatable.dart';

class LoginResponseResult extends Equatable {
  const LoginResponseResult({
    required this.status,
    required this.message,
    required this.token,
    required this.student,
  });

  final bool status;
  static const String statusKey = "status";

  final String message;
  static const String messageKey = "message";

  final String token;
  static const String tokenKey = "token";

  final Student? student;
  static const String studentKey = "student";

  LoginResponseResult copyWith({
    bool? status,
    String? message,
    String? token,
    Student? student,
  }) {
    return LoginResponseResult(
      status: status ?? this.status,
      message: message ?? this.message,
      token: token ?? this.token,
      student: student ?? this.student,
    );
  }

  factory LoginResponseResult.fromJson(Map<String, dynamic> json) {
    return LoginResponseResult(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      student: json["student"] == null
          ? null
          : Student.fromJson(json["student"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "token": token,
    "student": student?.toJson(),
  };

  @override
  String toString() {
    return "$status, $message, $token, $student, ";
  }

  @override
  List<Object?> get props => [status, message, token, student];
}

class Student extends Equatable {
  const Student({
    required this.admissionId,
    required this.accYear,
    required this.admno,
    required this.scode,
    required this.sectionId,
    required this.name,
    required this.gender,
    required this.aadharNo,
    required this.father,
    required this.mother,
    required this.guardian,
    required this.relation,
    required this.occupation,
    required this.houseName,
    required this.street,
    required this.placeId,
    required this.postId,
    required this.districtId,
    required this.stateId,
    required this.nationalityId,
    required this.landPhone,
    required this.mobile,
    required this.email,
    required this.preTcNo,
    required this.preTcDate,
    required this.pretcSchool,
    required this.doj,
    required this.dob,
    required this.bloodGroup,
    required this.religionId,
    required this.categoryId,
    required this.casteId,
    required this.stdIdonAdm,
    required this.divIdonAdm,
    required this.madrassaAdmNo,
    required this.madrassaStdid,
    required this.madrassaDivId,
    required this.mediumId,
    required this.firstLanId,
    required this.secondLanId,
    required this.motherTongueId,
    required this.deformity,
    required this.identityMark1,
    required this.identityMark2,
    required this.tcNumber,
    required this.tcDate,
    required this.tcStdId,
    required this.tcDivId,
    required this.consessionTypeId,
    required this.relativeStatus,
    required this.busStatus,
    required this.activeStatus,
    required this.vaccinationDate,
    required this.motherMobile,
    required this.bankName,
    required this.accountNo,
    required this.artsSchool,
    required this.artsDistrict,
    required this.artsState,
    required this.artsNational,
    required this.sportsSchool,
    required this.sportsDistrict,
    required this.sportsState,
    required this.sportsNational,
    required this.previousClass,
    required this.hostelStatus,
    required this.dobInWords,
    required this.placeofBirth,
    required this.branchId,
    required this.createdDate,
    required this.createdUser,
    required this.modifiedDate,
    required this.modifiedUser,
    required this.passportNo,
    required this.passportExpiry,
    required this.iqamaNo,
    required this.iqamaExpiry,
    required this.fatherIqamaNo,
    required this.motherIqamaNo,
    required this.imageUrl,
    required this.currentStudentDivisionId,
    required this.currentStudentStandardId,
    required this.studentDivision,
    required this.studentStandard,
  });

  final int admissionId;
  static const String admissionIdKey = "AdmissionId";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String admno;
  static const String admnoKey = "Admno";

  final String scode;
  static const String scodeKey = "Scode";

  final String sectionId;
  static const String sectionIdKey = "SectionId";

  final String name;
  static const String nameKey = "Name";

  final String gender;
  static const String genderKey = "Gender";

  final dynamic aadharNo;
  static const String aadharNoKey = "AadharNo";

  final String father;
  static const String fatherKey = "Father";

  final dynamic mother;
  static const String motherKey = "Mother";

  final dynamic guardian;
  static const String guardianKey = "Guardian";

  final dynamic relation;
  static const String relationKey = "Relation";

  final dynamic occupation;
  static const String occupationKey = "Occupation";

  final String houseName;
  static const String houseNameKey = "HouseName";

  final dynamic street;
  static const String streetKey = "Street";

  final dynamic placeId;
  static const String placeIdKey = "PlaceId";

  final dynamic postId;
  static const String postIdKey = "PostId";

  final dynamic districtId;
  static const String districtIdKey = "DistrictId";

  final dynamic stateId;
  static const String stateIdKey = "StateId";

  final dynamic nationalityId;
  static const String nationalityIdKey = "NationalityId";

  final dynamic landPhone;
  static const String landPhoneKey = "LandPhone";

  final String mobile;
  static const String mobileKey = "Mobile";

  final String email;
  static const String emailKey = "Email";

  final dynamic preTcNo;
  static const String preTcNoKey = "PreTcNo";

  final dynamic preTcDate;
  static const String preTcDateKey = "PreTcDate";

  final dynamic pretcSchool;
  static const String pretcSchoolKey = "PretcSchool";

  final String? doj;
  static const String dojKey = "DOJ";

  final String? dob;
  static const String dobKey = "DOB";

  final dynamic bloodGroup;
  static const String bloodGroupKey = "BloodGroup";

  final dynamic religionId;
  static const String religionIdKey = "ReligionId";

  final dynamic categoryId;
  static const String categoryIdKey = "CategoryId";

  final dynamic casteId;
  static const String casteIdKey = "CasteId";

  final String stdIdonAdm;
  static const String stdIdonAdmKey = "StdIdonAdm";

  final String divIdonAdm;
  static const String divIdonAdmKey = "DivIdonAdm";

  final dynamic madrassaAdmNo;
  static const String madrassaAdmNoKey = "MadrassaAdmNo";

  final dynamic madrassaStdid;
  static const String madrassaStdidKey = "MadrassaStdid";

  final dynamic madrassaDivId;
  static const String madrassaDivIdKey = "MadrassaDivId";

  final String imageUrl;
  static const String imageUrlKey = "Image";

  final dynamic mediumId;
  static const String mediumIdKey = "MediumId";

  final dynamic firstLanId;
  static const String firstLanIdKey = "FirstLanId";

  final dynamic secondLanId;
  static const String secondLanIdKey = "SecondLanId";

  final dynamic motherTongueId;
  static const String motherTongueIdKey = "MotherTongueId";

  final dynamic deformity;
  static const String deformityKey = "Deformity";

  final dynamic identityMark1;
  static const String identityMark1Key = "IdentityMark1";

  final dynamic identityMark2;
  static const String identityMark2Key = "IdentityMark2";

  final dynamic tcNumber;
  static const String tcNumberKey = "TcNumber";

  final dynamic tcDate;
  static const String tcDateKey = "TcDate";

  final dynamic tcStdId;
  static const String tcStdIdKey = "TcStdId";

  final dynamic tcDivId;
  static const String tcDivIdKey = "TcDivId";

  final dynamic consessionTypeId;
  static const String consessionTypeIdKey = "ConsessionTypeId";

  final bool relativeStatus;
  static const String relativeStatusKey = "RelativeStatus";

  final bool busStatus;
  static const String busStatusKey = "BusStatus";

  final String activeStatus;
  static const String activeStatusKey = "ActiveStatus";

  final dynamic vaccinationDate;
  static const String vaccinationDateKey = "VaccinationDate";

  final dynamic motherMobile;
  static const String motherMobileKey = "MotherMobile";

  final dynamic bankName;
  static const String bankNameKey = "BankName";

  final dynamic accountNo;
  static const String accountNoKey = "AccountNo";

  final String artsSchool;
  static const String artsSchoolKey = "ArtsSchool";

  final String artsDistrict;
  static const String artsDistrictKey = "ArtsDistrict";

  final String artsState;
  static const String artsStateKey = "ArtsState";

  final String artsNational;
  static const String artsNationalKey = "ArtsNational";

  final String sportsSchool;
  static const String sportsSchoolKey = "SportsSchool";

  final String sportsDistrict;
  static const String sportsDistrictKey = "SportsDistrict";

  final String sportsState;
  static const String sportsStateKey = "SportsState";

  final String sportsNational;
  static const String sportsNationalKey = "SportsNational";

  final dynamic previousClass;
  static const String previousClassKey = "PreviousClass";

  final bool hostelStatus;
  static const String hostelStatusKey = "HostelStatus";

  final String dobInWords;
  static const String dobInWordsKey = "DOBInWords";

  final String placeofBirth;
  static const String placeofBirthKey = "PlaceofBirth";

  final int branchId;
  static const String branchIdKey = "branchId";

  final String? createdDate;
  static const String createdDateKey = "CreatedDate";

  final String createdUser;
  static const String createdUserKey = "CreatedUser";

  final dynamic modifiedDate;
  static const String modifiedDateKey = "ModifiedDate";

  final dynamic modifiedUser;
  static const String modifiedUserKey = "ModifiedUser";

  final dynamic passportNo;
  static const String passportNoKey = "PassportNo";

  final dynamic passportExpiry;
  static const String passportExpiryKey = "PassportExpiry";

  final dynamic iqamaNo;
  static const String iqamaNoKey = "IqamaNo";

  final dynamic iqamaExpiry;
  static const String iqamaExpiryKey = "IqamaExpiry";

  final dynamic fatherIqamaNo;
  static const String fatherIqamaNoKey = "FatherIqamaNo";

  final dynamic motherIqamaNo;
  static const String motherIqamaNoKey = "MotherIqamaNo";

  final String currentStudentDivisionId;
  static const String currentStudentDivisionIdKey = "currentStudentDivisionId";

  final String currentStudentStandardId;
  static const String currentStudentStandardIdKey = "currentStudentStandardId";

  final String studentDivision;
  static const String studentDivisionKey = "StudentDivision";

  final String studentStandard;
  static const String studentStandardKey = "StudentStandard";

  Student copyWith({
    int? admissionId,
    String? accYear,
    String? admno,
    String? scode,
    String? sectionId,
    String? name,
    String? gender,
    dynamic aadharNo,
    String? father,
    dynamic mother,
    dynamic guardian,
    dynamic relation,
    dynamic occupation,
    String? houseName,
    dynamic street,
    dynamic placeId,
    dynamic postId,
    dynamic districtId,
    dynamic stateId,
    dynamic nationalityId,
    dynamic landPhone,
    String? mobile,
    String? email,
    dynamic preTcNo,
    dynamic preTcDate,
    dynamic pretcSchool,
    String? doj,
    String? dob,
    dynamic bloodGroup,
    dynamic religionId,
    dynamic categoryId,
    dynamic casteId,
    String? stdIdonAdm,
    String? divIdonAdm,
    dynamic madrassaAdmNo,
    dynamic madrassaStdid,
    dynamic madrassaDivId,
    dynamic mediumId,
    dynamic firstLanId,
    dynamic secondLanId,
    dynamic motherTongueId,
    dynamic deformity,
    dynamic identityMark1,
    dynamic identityMark2,
    dynamic tcNumber,
    dynamic tcDate,
    dynamic tcStdId,
    dynamic tcDivId,
    dynamic consessionTypeId,
    bool? relativeStatus,
    bool? busStatus,
    String? activeStatus,
    dynamic vaccinationDate,
    dynamic motherMobile,
    dynamic bankName,
    dynamic accountNo,
    String? artsSchool,
    String? artsDistrict,
    String? artsState,
    String? artsNational,
    String? sportsSchool,
    String? sportsDistrict,
    String? sportsState,
    String? sportsNational,
    dynamic previousClass,
    bool? hostelStatus,
    String? dobInWords,
    String? placeofBirth,
    int? branchId,
    String? createdDate,
    String? createdUser,
    dynamic modifiedDate,
    dynamic modifiedUser,
    dynamic passportNo,
    dynamic passportExpiry,
    dynamic iqamaNo,
    dynamic iqamaExpiry,
    dynamic fatherIqamaNo,
    dynamic motherIqamaNo,
    String? currentStudentDivisionId,
    String? currentStudentStandardId,
    String? imageUrl,
    String? studentDivision,
    String? studentStandard,
  }) {
    return Student(
      admissionId: admissionId ?? this.admissionId,
      accYear: accYear ?? this.accYear,
      admno: admno ?? this.admno,
      scode: scode ?? this.scode,
      sectionId: sectionId ?? this.sectionId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      aadharNo: aadharNo ?? this.aadharNo,
      father: father ?? this.father,
      mother: mother ?? this.mother,
      guardian: guardian ?? this.guardian,
      relation: relation ?? this.relation,
      occupation: occupation ?? this.occupation,
      houseName: houseName ?? this.houseName,
      street: street ?? this.street,
      placeId: placeId ?? this.placeId,
      postId: postId ?? this.postId,
      districtId: districtId ?? this.districtId,
      stateId: stateId ?? this.stateId,
      nationalityId: nationalityId ?? this.nationalityId,
      landPhone: landPhone ?? this.landPhone,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      preTcNo: preTcNo ?? this.preTcNo,
      preTcDate: preTcDate ?? this.preTcDate,
      pretcSchool: pretcSchool ?? this.pretcSchool,
      doj: doj ?? this.doj,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      religionId: religionId ?? this.religionId,
      categoryId: categoryId ?? this.categoryId,
      casteId: casteId ?? this.casteId,
      stdIdonAdm: stdIdonAdm ?? this.stdIdonAdm,
      divIdonAdm: divIdonAdm ?? this.divIdonAdm,
      madrassaAdmNo: madrassaAdmNo ?? this.madrassaAdmNo,
      madrassaStdid: madrassaStdid ?? this.madrassaStdid,
      madrassaDivId: madrassaDivId ?? this.madrassaDivId,
      mediumId: mediumId ?? this.mediumId,
      firstLanId: firstLanId ?? this.firstLanId,
      secondLanId: secondLanId ?? this.secondLanId,
      motherTongueId: motherTongueId ?? this.motherTongueId,
      deformity: deformity ?? this.deformity,
      identityMark1: identityMark1 ?? this.identityMark1,
      identityMark2: identityMark2 ?? this.identityMark2,
      tcNumber: tcNumber ?? this.tcNumber,
      tcDate: tcDate ?? this.tcDate,
      tcStdId: tcStdId ?? this.tcStdId,
      tcDivId: tcDivId ?? this.tcDivId,
      consessionTypeId: consessionTypeId ?? this.consessionTypeId,
      relativeStatus: relativeStatus ?? this.relativeStatus,
      busStatus: busStatus ?? this.busStatus,
      activeStatus: activeStatus ?? this.activeStatus,
      vaccinationDate: vaccinationDate ?? this.vaccinationDate,
      motherMobile: motherMobile ?? this.motherMobile,
      bankName: bankName ?? this.bankName,
      accountNo: accountNo ?? this.accountNo,
      artsSchool: artsSchool ?? this.artsSchool,
      artsDistrict: artsDistrict ?? this.artsDistrict,
      artsState: artsState ?? this.artsState,
      artsNational: artsNational ?? this.artsNational,
      sportsSchool: sportsSchool ?? this.sportsSchool,
      sportsDistrict: sportsDistrict ?? this.sportsDistrict,
      sportsState: sportsState ?? this.sportsState,
      sportsNational: sportsNational ?? this.sportsNational,
      previousClass: previousClass ?? this.previousClass,
      hostelStatus: hostelStatus ?? this.hostelStatus,
      dobInWords: dobInWords ?? this.dobInWords,
      placeofBirth: placeofBirth ?? this.placeofBirth,
      branchId: branchId ?? this.branchId,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedUser: modifiedUser ?? this.modifiedUser,
      passportNo: passportNo ?? this.passportNo,
      passportExpiry: passportExpiry ?? this.passportExpiry,
      iqamaNo: iqamaNo ?? this.iqamaNo,
      iqamaExpiry: iqamaExpiry ?? this.iqamaExpiry,
      fatherIqamaNo: fatherIqamaNo ?? this.fatherIqamaNo,
      motherIqamaNo: motherIqamaNo ?? this.motherIqamaNo,
      currentStudentDivisionId:
          currentStudentDivisionId ?? this.currentStudentDivisionId,
      currentStudentStandardId:
          currentStudentStandardId ?? this.currentStudentStandardId,
      imageUrl: imageUrl ?? this.imageUrl,
      studentDivision: studentDivision ?? this.studentDivision,
      studentStandard: studentStandard ?? this.studentStandard,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      admissionId: json["AdmissionId"] ?? 0,
      accYear: json["AccYear"] ?? "",
      admno: json["Admno"] ?? "",
      scode: json["Scode"] ?? "",
      sectionId: json["SectionId"] ?? "",
      name: json["Name"] ?? "",
      gender: json["Gender"] ?? "",
      aadharNo: json["AadharNo"],
      father: json["Father"] ?? "",
      mother: json["Mother"],
      guardian: json["Guardian"],
      relation: json["Relation"],
      occupation: json["Occupation"],
      houseName: json["HouseName"] ?? "",
      street: json["Street"],
      placeId: json["PlaceId"],
      postId: json["PostId"],
      districtId: json["DistrictId"],
      stateId: json["StateId"],
      nationalityId: json["NationalityId"],
      landPhone: json["LandPhone"],
      mobile: json["Mobile"] ?? "",
      email: json["Email"] ?? "",
      preTcNo: json["PreTcNo"],
      preTcDate: json["PreTcDate"],
      pretcSchool: json["PretcSchool"],
      doj: json["DOJ"] ?? "",
      dob: json["DOB"] ?? "",
      bloodGroup: json["BloodGroup"],
      religionId: json["ReligionId"],
      categoryId: json["CategoryId"],
      casteId: json["CasteId"],
      stdIdonAdm: json["StdIdonAdm"] ?? "",
      divIdonAdm: json["DivIdonAdm"] ?? "",
      madrassaAdmNo: json["MadrassaAdmNo"],
      madrassaStdid: json["MadrassaStdid"],
      madrassaDivId: json["MadrassaDivId"],
      mediumId: json["MediumId"],
      firstLanId: json["FirstLanId"],
      secondLanId: json["SecondLanId"],
      motherTongueId: json["MotherTongueId"],
      deformity: json["Deformity"],
      identityMark1: json["IdentityMark1"],
      identityMark2: json["IdentityMark2"],
      tcNumber: json["TcNumber"],
      tcDate: json["TcDate"],
      tcStdId: json["TcStdId"],
      tcDivId: json["TcDivId"],
      consessionTypeId: json["ConsessionTypeId"],
      relativeStatus: json["RelativeStatus"] ?? false,
      busStatus: json["BusStatus"] ?? false,
      activeStatus: json["ActiveStatus"] ?? "",
      vaccinationDate: json["VaccinationDate"],
      motherMobile: json["MotherMobile"],
      bankName: json["BankName"],
      accountNo: json["AccountNo"],
      artsSchool: json["ArtsSchool"] ?? "",
      artsDistrict: json["ArtsDistrict"] ?? "",
      artsState: json["ArtsState"] ?? "",
      artsNational: json["ArtsNational"] ?? "",
      sportsSchool: json["SportsSchool"] ?? "",
      sportsDistrict: json["SportsDistrict"] ?? "",
      sportsState: json["SportsState"] ?? "",
      sportsNational: json["SportsNational"] ?? "",
      previousClass: json["PreviousClass"],
      hostelStatus: json["HostelStatus"] ?? false,
      dobInWords: json["DOBInWords"] ?? "",
      placeofBirth: json["PlaceofBirth"] ?? "",
      branchId: json["branchId"] ?? 0,
      createdDate: json["CreatedDate"] ?? "",
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: json["ModifiedDate"],
      modifiedUser: json["ModifiedUser"],
      passportNo: json["PassportNo"],
      passportExpiry: json["PassportExpiry"],
      iqamaNo: json["IqamaNo"],
      iqamaExpiry: json["IqamaExpiry"],
      fatherIqamaNo: json["FatherIqamaNo"],
      motherIqamaNo: json["MotherIqamaNo"],
      currentStudentDivisionId: json["currentStudentDivisionId"] ?? "",
      currentStudentStandardId: json["currentStudentStandardId"] ?? "",
      imageUrl: json["Image"] ?? "",
      studentDivision: json["StudentDivision"] ?? "",
      studentStandard: json["StudentStandard"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "AdmissionId": admissionId,
    "AccYear": accYear,
    "Admno": admno,
    "Scode": scode,
    "SectionId": sectionId,
    "Name": name,
    "Gender": gender,
    "AadharNo": aadharNo,
    "Father": father,
    "Mother": mother,
    "Guardian": guardian,
    "Relation": relation,
    "Occupation": occupation,
    "HouseName": houseName,
    "Street": street,
    "PlaceId": placeId,
    "PostId": postId,
    "DistrictId": districtId,
    "StateId": stateId,
    "NationalityId": nationalityId,
    "LandPhone": landPhone,
    "Mobile": mobile,
    "Email": email,
    "PreTcNo": preTcNo,
    "PreTcDate": preTcDate,
    "PretcSchool": pretcSchool,
    "DOJ": doj,
    "DOB": dob,
    "BloodGroup": bloodGroup,
    "ReligionId": religionId,
    "CategoryId": categoryId,
    "CasteId": casteId,
    "StdIdonAdm": stdIdonAdm,
    "DivIdonAdm": divIdonAdm,
    "MadrassaAdmNo": madrassaAdmNo,
    "MadrassaStdid": madrassaStdid,
    "MadrassaDivId": madrassaDivId,
    "MediumId": mediumId,
    "FirstLanId": firstLanId,
    "SecondLanId": secondLanId,
    "MotherTongueId": motherTongueId,
    "Deformity": deformity,
    "IdentityMark1": identityMark1,
    "IdentityMark2": identityMark2,
    "TcNumber": tcNumber,
    "TcDate": tcDate,
    "TcStdId": tcStdId,
    "TcDivId": tcDivId,
    "ConsessionTypeId": consessionTypeId,
    "RelativeStatus": relativeStatus,
    "BusStatus": busStatus,
    "ActiveStatus": activeStatus,
    "VaccinationDate": vaccinationDate,
    "MotherMobile": motherMobile,
    "BankName": bankName,
    "AccountNo": accountNo,
    "ArtsSchool": artsSchool,
    "ArtsDistrict": artsDistrict,
    "ArtsState": artsState,
    "ArtsNational": artsNational,
    "SportsSchool": sportsSchool,
    "SportsDistrict": sportsDistrict,
    "SportsState": sportsState,
    "SportsNational": sportsNational,
    "PreviousClass": previousClass,
    "HostelStatus": hostelStatus,
    "DOBInWords": dobInWords,
    "PlaceofBirth": placeofBirth,
    "branchId": branchId,
    "CreatedDate": createdDate,
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate,
    "ModifiedUser": modifiedUser,
    "PassportNo": passportNo,
    "PassportExpiry": passportExpiry,
    "IqamaNo": iqamaNo,
    "IqamaExpiry": iqamaExpiry,
    "FatherIqamaNo": fatherIqamaNo,
    "MotherIqamaNo": motherIqamaNo,
    "currentStudentDivisionId": currentStudentDivisionId,
    "currentStudentStandardId": currentStudentStandardId,
    "StudentDivision": studentDivision,
    'Image': imageUrl,
    "StudentStandard": studentStandard,
  };

  @override
  String toString() {
    return "$admissionId, $accYear, $admno, $scode, $sectionId, $name, $gender, $aadharNo, $father, $mother, $guardian, $relation, $occupation, $houseName, $street, $placeId, $postId, $districtId, $stateId, $nationalityId, $landPhone, $mobile, $email, $preTcNo, $preTcDate, $pretcSchool, $doj, $dob, $bloodGroup, $religionId, $categoryId, $casteId, $stdIdonAdm, $divIdonAdm, $madrassaAdmNo, $madrassaStdid, $madrassaDivId, $mediumId, $firstLanId, $secondLanId, $motherTongueId, $deformity, $identityMark1, $identityMark2, $tcNumber, $tcDate, $tcStdId, $tcDivId, $consessionTypeId, $relativeStatus, $busStatus, $activeStatus, $vaccinationDate, $motherMobile, $bankName, $accountNo, $artsSchool, $artsDistrict, $artsState, $artsNational, $sportsSchool, $sportsDistrict, $sportsState, $sportsNational, $previousClass, $hostelStatus, $dobInWords, $placeofBirth, $branchId, $createdDate, $createdUser, $modifiedDate, $modifiedUser, $passportNo, $passportExpiry, $iqamaNo, $iqamaExpiry, $fatherIqamaNo,"
        " $motherIqamaNo, $currentStudentDivisionId, $currentStudentStandardId, $imageUrl, $studentDivision , $studentStandard ";
  }

  @override
  List<Object?> get props => [
    admissionId,
    accYear,
    admno,
    scode,
    sectionId,
    name,
    gender,
    aadharNo,
    father,
    mother,
    guardian,
    relation,
    occupation,
    houseName,
    street,
    placeId,
    postId,
    districtId,
    stateId,
    nationalityId,
    landPhone,
    mobile,
    email,
    preTcNo,
    preTcDate,
    pretcSchool,
    doj,
    dob,
    bloodGroup,
    religionId,
    categoryId,
    casteId,
    stdIdonAdm,
    divIdonAdm,
    madrassaAdmNo,
    madrassaStdid,
    madrassaDivId,
    mediumId,
    firstLanId,
    secondLanId,
    motherTongueId,
    deformity,
    identityMark1,
    identityMark2,
    tcNumber,
    tcDate,
    tcStdId,
    tcDivId,
    consessionTypeId,
    relativeStatus,
    busStatus,
    activeStatus,
    vaccinationDate,
    motherMobile,
    bankName,
    accountNo,
    artsSchool,
    artsDistrict,
    artsState,
    artsNational,
    sportsSchool,
    sportsDistrict,
    sportsState,
    sportsNational,
    previousClass,
    hostelStatus,
    dobInWords,
    placeofBirth,
    branchId,
    createdDate,
    createdUser,
    modifiedDate,
    modifiedUser,
    passportNo,
    passportExpiry,
    iqamaNo,
    iqamaExpiry,
    fatherIqamaNo,
    motherIqamaNo,
    currentStudentDivisionId,
    currentStudentStandardId,
    imageUrl,
    studentDivision,
    studentStandard,
  ];
}
