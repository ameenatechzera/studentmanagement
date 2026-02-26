import 'package:equatable/equatable.dart';

class LoginResponseResult extends Equatable {
  LoginResponseResult({
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
  Student({
    required this.admno,
    required this.admissionId,
    required this.accYear,
    required this.sectionName,
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
    required this.place,
    required this.post,
    required this.nationality,
    required this.state,
    required this.district,
    required this.landPhone,
    required this.mobile,
    required this.email,
    required this.preTcNo,
    required this.preTcDate,
    required this.pretcSchool,
    required this.doj,
    required this.dob,
    required this.bloodGroup,
    required this.religion,
    required this.category,
    required this.caste,
    required this.stdonAdm,
    required this.divonAdm,
    required this.madrassaAdmNo,
    required this.madrassaStd,
    required this.madrassaDiv,
    required this.medium,
    required this.firstLan,
    required this.secondLan,
    required this.motherTongue,
    required this.deformity,
    required this.identityMark1,
    required this.identityMark2,
    required this.consessionType,
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
    required this.dobInWords,
    required this.placeofBirth,
    required this.branchId,
    required this.createdDate,
    required this.createdUser,
    required this.modifiedDate,
    required this.modifiedUser,
  });

  final int admno;
  static const String admnoKey = "Admno";

  final int admissionId;
  static const String admissionIdKey = "AdmissionId";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String sectionName;
  static const String sectionNameKey = "SectionName";

  final String name;
  static const String nameKey = "Name";

  final String gender;
  static const String genderKey = "Gender";

  final dynamic aadharNo;
  static const String aadharNoKey = "AadharNo";

  final String father;
  static const String fatherKey = "Father";

  final String mother;
  static const String motherKey = "Mother";

  final String guardian;
  static const String guardianKey = "Guardian";

  final String relation;
  static const String relationKey = "Relation";

  final String occupation;
  static const String occupationKey = "Occupation";

  final String houseName;
  static const String houseNameKey = "HouseName";

  final String street;
  static const String streetKey = "Street";

  final String place;
  static const String placeKey = "Place";

  final String post;
  static const String postKey = "Post";

  final String nationality;
  static const String nationalityKey = "Nationality";

  final String state;
  static const String stateKey = "State";

  final String district;
  static const String districtKey = "District";

  final dynamic landPhone;
  static const String landPhoneKey = "LandPhone";

  final String mobile;
  static const String mobileKey = "Mobile";

  final dynamic email;
  static const String emailKey = "Email";

  final dynamic preTcNo;
  static const String preTcNoKey = "PreTcNo";

  final DateTime? preTcDate;
  static const String preTcDateKey = "PreTcDate";

  final dynamic pretcSchool;
  static const String pretcSchoolKey = "PretcSchool";

  final DateTime? doj;
  static const String dojKey = "DOJ";

  final DateTime? dob;
  static const String dobKey = "DOB";

  final String bloodGroup;
  static const String bloodGroupKey = "BloodGroup";

  final String religion;
  static const String religionKey = "Religion";

  final String category;
  static const String categoryKey = "Category";

  final String caste;
  static const String casteKey = "Caste";

  final String stdonAdm;
  static const String stdonAdmKey = "StdonAdm";

  final String divonAdm;
  static const String divonAdmKey = "DivonAdm";

  final dynamic madrassaAdmNo;
  static const String madrassaAdmNoKey = "MadrassaAdmNo";

  final String madrassaStd;
  static const String madrassaStdKey = "MadrassaStd";

  final String madrassaDiv;
  static const String madrassaDivKey = "MadrassaDiv";

  final String medium;
  static const String mediumKey = "Medium";

  final String firstLan;
  static const String firstLanKey = "FirstLan";

  final String secondLan;
  static const String secondLanKey = "SecondLan";

  final String motherTongue;
  static const String motherTongueKey = "MotherTongue";

  final String deformity;
  static const String deformityKey = "Deformity";

  final dynamic identityMark1;
  static const String identityMark1Key = "IdentityMark1";

  final dynamic identityMark2;
  static const String identityMark2Key = "IdentityMark2";

  final String consessionType;
  static const String consessionTypeKey = "ConsessionType";

  final bool relativeStatus;
  static const String relativeStatusKey = "RelativeStatus";

  final bool busStatus;
  static const String busStatusKey = "BusStatus";

  final String activeStatus;
  static const String activeStatusKey = "ActiveStatus";

  final DateTime? vaccinationDate;
  static const String vaccinationDateKey = "VaccinationDate";

  final String motherMobile;
  static const String motherMobileKey = "MotherMobile";

  final dynamic bankName;
  static const String bankNameKey = "BankName";

  final dynamic accountNo;
  static const String accountNoKey = "AccountNo";

  final dynamic artsSchool;
  static const String artsSchoolKey = "ArtsSchool";

  final dynamic artsDistrict;
  static const String artsDistrictKey = "ArtsDistrict";

  final dynamic artsState;
  static const String artsStateKey = "ArtsState";

  final dynamic artsNational;
  static const String artsNationalKey = "ArtsNational";

  final dynamic sportsSchool;
  static const String sportsSchoolKey = "SportsSchool";

  final dynamic sportsDistrict;
  static const String sportsDistrictKey = "SportsDistrict";

  final dynamic sportsState;
  static const String sportsStateKey = "SportsState";

  final dynamic sportsNational;
  static const String sportsNationalKey = "SportsNational";

  final dynamic previousClass;
  static const String previousClassKey = "PreviousClass";

  final String dobInWords;
  static const String dobInWordsKey = "DOBInWords";

  final dynamic placeofBirth;
  static const String placeofBirthKey = "PlaceofBirth";

  final int branchId;
  static const String branchIdKey = "branchId";

  final DateTime? createdDate;
  static const String createdDateKey = "CreatedDate";

  final String createdUser;
  static const String createdUserKey = "CreatedUser";

  final dynamic modifiedDate;
  static const String modifiedDateKey = "ModifiedDate";

  final dynamic modifiedUser;
  static const String modifiedUserKey = "ModifiedUser";

  Student copyWith({
    int? admno,
    int? admissionId,
    String? accYear,
    String? sectionName,
    String? name,
    String? gender,
    dynamic aadharNo,
    String? father,
    String? mother,
    String? guardian,
    String? relation,
    String? occupation,
    String? houseName,
    String? street,
    String? place,
    String? post,
    String? nationality,
    String? state,
    String? district,
    dynamic landPhone,
    String? mobile,
    dynamic email,
    dynamic preTcNo,
    DateTime? preTcDate,
    dynamic pretcSchool,
    DateTime? doj,
    DateTime? dob,
    String? bloodGroup,
    String? religion,
    String? category,
    String? caste,
    String? stdonAdm,
    String? divonAdm,
    dynamic madrassaAdmNo,
    String? madrassaStd,
    String? madrassaDiv,
    String? medium,
    String? firstLan,
    String? secondLan,
    String? motherTongue,
    String? deformity,
    dynamic identityMark1,
    dynamic identityMark2,
    String? consessionType,
    bool? relativeStatus,
    bool? busStatus,
    String? activeStatus,
    DateTime? vaccinationDate,
    String? motherMobile,
    dynamic bankName,
    dynamic accountNo,
    dynamic artsSchool,
    dynamic artsDistrict,
    dynamic artsState,
    dynamic artsNational,
    dynamic sportsSchool,
    dynamic sportsDistrict,
    dynamic sportsState,
    dynamic sportsNational,
    dynamic previousClass,
    String? dobInWords,
    dynamic placeofBirth,
    int? branchId,
    DateTime? createdDate,
    String? createdUser,
    dynamic modifiedDate,
    dynamic modifiedUser,
  }) {
    return Student(
      admno: admno ?? this.admno,
      admissionId: admissionId ?? this.admissionId,
      accYear: accYear ?? this.accYear,
      sectionName: sectionName ?? this.sectionName,
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
      place: place ?? this.place,
      post: post ?? this.post,
      nationality: nationality ?? this.nationality,
      state: state ?? this.state,
      district: district ?? this.district,
      landPhone: landPhone ?? this.landPhone,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      preTcNo: preTcNo ?? this.preTcNo,
      preTcDate: preTcDate ?? this.preTcDate,
      pretcSchool: pretcSchool ?? this.pretcSchool,
      doj: doj ?? this.doj,
      dob: dob ?? this.dob,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      religion: religion ?? this.religion,
      category: category ?? this.category,
      caste: caste ?? this.caste,
      stdonAdm: stdonAdm ?? this.stdonAdm,
      divonAdm: divonAdm ?? this.divonAdm,
      madrassaAdmNo: madrassaAdmNo ?? this.madrassaAdmNo,
      madrassaStd: madrassaStd ?? this.madrassaStd,
      madrassaDiv: madrassaDiv ?? this.madrassaDiv,
      medium: medium ?? this.medium,
      firstLan: firstLan ?? this.firstLan,
      secondLan: secondLan ?? this.secondLan,
      motherTongue: motherTongue ?? this.motherTongue,
      deformity: deformity ?? this.deformity,
      identityMark1: identityMark1 ?? this.identityMark1,
      identityMark2: identityMark2 ?? this.identityMark2,
      consessionType: consessionType ?? this.consessionType,
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
      dobInWords: dobInWords ?? this.dobInWords,
      placeofBirth: placeofBirth ?? this.placeofBirth,
      branchId: branchId ?? this.branchId,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedUser: modifiedUser ?? this.modifiedUser,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      admno: json["Admno"] ?? 0,
      admissionId: json["AdmissionId"] ?? 0,
      accYear: json["AccYear"] ?? "",
      sectionName: json["SectionName"] ?? "",
      name: json["Name"] ?? "",
      gender: json["Gender"] ?? "",
      aadharNo: json["AadharNo"],
      father: json["Father"] ?? "",
      mother: json["Mother"] ?? "",
      guardian: json["Guardian"] ?? "",
      relation: json["Relation"] ?? "",
      occupation: json["Occupation"] ?? "",
      houseName: json["HouseName"] ?? "",
      street: json["Street"] ?? "",
      place: json["Place"] ?? "",
      post: json["Post"] ?? "",
      nationality: json["Nationality"] ?? "",
      state: json["State"] ?? "",
      district: json["District"] ?? "",
      landPhone: json["LandPhone"],
      mobile: json["Mobile"] ?? "",
      email: json["Email"],
      preTcNo: json["PreTcNo"],
      preTcDate: DateTime.tryParse(json["PreTcDate"] ?? ""),
      pretcSchool: json["PretcSchool"],
      doj: DateTime.tryParse(json["DOJ"] ?? ""),
      dob: DateTime.tryParse(json["DOB"] ?? ""),
      bloodGroup: json["BloodGroup"] ?? "",
      religion: json["Religion"] ?? "",
      category: json["Category"] ?? "",
      caste: json["Caste"] ?? "",
      stdonAdm: json["StdonAdm"] ?? "",
      divonAdm: json["DivonAdm"] ?? "",
      madrassaAdmNo: json["MadrassaAdmNo"],
      madrassaStd: json["MadrassaStd"] ?? "",
      madrassaDiv: json["MadrassaDiv"] ?? "",
      medium: json["Medium"] ?? "",
      firstLan: json["FirstLan"] ?? "",
      secondLan: json["SecondLan"] ?? "",
      motherTongue: json["MotherTongue"] ?? "",
      deformity: json["Deformity"] ?? "",
      identityMark1: json["IdentityMark1"],
      identityMark2: json["IdentityMark2"],
      consessionType: json["ConsessionType"] ?? "",
      relativeStatus: json["RelativeStatus"] ?? false,
      busStatus: json["BusStatus"] ?? false,
      activeStatus: json["ActiveStatus"] ?? "",
      vaccinationDate: DateTime.tryParse(json["VaccinationDate"] ?? ""),
      motherMobile: json["MotherMobile"] ?? "",
      bankName: json["BankName"],
      accountNo: json["AccountNo"],
      artsSchool: json["ArtsSchool"],
      artsDistrict: json["ArtsDistrict"],
      artsState: json["ArtsState"],
      artsNational: json["ArtsNational"],
      sportsSchool: json["SportsSchool"],
      sportsDistrict: json["SportsDistrict"],
      sportsState: json["SportsState"],
      sportsNational: json["SportsNational"],
      previousClass: json["PreviousClass"],
      dobInWords: json["DOBInWords"] ?? "",
      placeofBirth: json["PlaceofBirth"],
      branchId: json["branchId"] ?? 0,
      createdDate: DateTime.tryParse(json["CreatedDate"] ?? ""),
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: json["ModifiedDate"],
      modifiedUser: json["ModifiedUser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Admno": admno,
    "AdmissionId": admissionId,
    "AccYear": accYear,
    "SectionName": sectionName,
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
    "Place": place,
    "Post": post,
    "Nationality": nationality,
    "State": state,
    "District": district,
    "LandPhone": landPhone,
    "Mobile": mobile,
    "Email": email,
    "PreTcNo": preTcNo,
    "PreTcDate": preTcDate?.toIso8601String(),
    "PretcSchool": pretcSchool,
    "DOJ": doj?.toIso8601String(),
    "DOB": dob?.toIso8601String(),
    "BloodGroup": bloodGroup,
    "Religion": religion,
    "Category": category,
    "Caste": caste,
    "StdonAdm": stdonAdm,
    "DivonAdm": divonAdm,
    "MadrassaAdmNo": madrassaAdmNo,
    "MadrassaStd": madrassaStd,
    "MadrassaDiv": madrassaDiv,
    "Medium": medium,
    "FirstLan": firstLan,
    "SecondLan": secondLan,
    "MotherTongue": motherTongue,
    "Deformity": deformity,
    "IdentityMark1": identityMark1,
    "IdentityMark2": identityMark2,
    "ConsessionType": consessionType,
    "RelativeStatus": relativeStatus,
    "BusStatus": busStatus,
    "ActiveStatus": activeStatus,
    "VaccinationDate": vaccinationDate?.toIso8601String(),
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
    "DOBInWords": dobInWords,
    "PlaceofBirth": placeofBirth,
    "branchId": branchId,
    "CreatedDate": createdDate?.toIso8601String(),
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate,
    "ModifiedUser": modifiedUser,
  };

  @override
  String toString() {
    return "$admno, $admissionId, $accYear, $sectionName, $name, $gender, $aadharNo, $father, $mother, $guardian, $relation, $occupation, $houseName, $street, $place, $post, $nationality, $state, $district, $landPhone, $mobile, $email, $preTcNo, $preTcDate, $pretcSchool, $doj, $dob, $bloodGroup, $religion, $category, $caste, $stdonAdm, $divonAdm, $madrassaAdmNo, $madrassaStd, $madrassaDiv, $medium, $firstLan, $secondLan, $motherTongue, $deformity, $identityMark1, $identityMark2, $consessionType, $relativeStatus, $busStatus, $activeStatus, $vaccinationDate, $motherMobile, $bankName, $accountNo, $artsSchool, $artsDistrict, $artsState, $artsNational, $sportsSchool, $sportsDistrict, $sportsState, $sportsNational, $previousClass, $dobInWords, $placeofBirth, $branchId, $createdDate, $createdUser, $modifiedDate, $modifiedUser, ";
  }

  @override
  List<Object?> get props => [
    admno,
    admissionId,
    accYear,
    sectionName,
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
    place,
    post,
    nationality,
    state,
    district,
    landPhone,
    mobile,
    email,
    preTcNo,
    preTcDate,
    pretcSchool,
    doj,
    dob,
    bloodGroup,
    religion,
    category,
    caste,
    stdonAdm,
    divonAdm,
    madrassaAdmNo,
    madrassaStd,
    madrassaDiv,
    medium,
    firstLan,
    secondLan,
    motherTongue,
    deformity,
    identityMark1,
    identityMark2,
    consessionType,
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
    dobInWords,
    placeofBirth,
    branchId,
    createdDate,
    createdUser,
    modifiedDate,
    modifiedUser,
  ];
}
