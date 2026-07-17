// import 'package:equatable/equatable.dart';

// class MaterialsbysubjectResult extends Equatable {
//   MaterialsbysubjectResult({
//     required this.status,
//     required this.error,
//     required this.data,
//   });

//   final int status;
//   static const String statusKey = "status";

//   final bool error;
//   static const String errorKey = "error";

//   final List<MaterialList> data;
//   static const String dataKey = "data";

//   MaterialsbysubjectResult copyWith({
//     int? status,
//     bool? error,
//     List<MaterialList>? data,
//   }) {
//     return MaterialsbysubjectResult(
//       status: status ?? this.status,
//       error: error ?? this.error,
//       data: data ?? this.data,
//     );
//   }

//   factory MaterialsbysubjectResult.fromJson(Map<String, dynamic> json) {
//     return MaterialsbysubjectResult(
//       status: json["status"] ?? 0,
//       error: json["error"] ?? false,
//       data: json["data"] == null
//           ? []
//           : List<MaterialList>.from(
//               json["data"]!.map((x) => MaterialList.fromJson(x)),
//             ),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "error": error,
//     "data": data.map((x) => x?.toJson()).toList(),
//   };

//   @override
//   String toString() {
//     return "$status, $error, $data, ";
//   }

//   @override
//   List<Object?> get props => [status, error, data];
// }

// class MaterialList extends Equatable {
//   MaterialList({
//     required this.materialId,
//     required this.staffId,
//     required this.employeeName,
//     required this.accYear,
//     required this.standardId,
//     required this.standard,
//     required this.divisionId,
//     required this.division,
//     required this.subjectId,
//     required this.subjectName,
//     required this.material,
//     required this.branchId,
//     required this.createdDate,
//     required this.createdUser,
//     required this.modifiedDate,
//     required this.modifiedUser,
//     required this.documentName,
//     required this.notes,
//     required this.link,
//     required this.favorite,
//   });

//   final int materialId;
//   static const String materialIdKey = "materialId";

//   final int staffId;
//   static const String staffIdKey = "StaffId";

//   final String employeeName;
//   static const String employeeNameKey = "employeeName";

//   final String accYear;
//   static const String accYearKey = "AccYear";

//   final int standardId;
//   static const String standardIdKey = "StandardId";

//   final String standard;
//   static const String standardKey = "Standard";

//   final int divisionId;
//   static const String divisionIdKey = "DivisionId";

//   final String division;
//   static const String divisionKey = "Division";

//   final int subjectId;
//   static const String subjectIdKey = "SubjectId";

//   final String subjectName;
//   static const String subjectNameKey = "SubjectName";

//   String material;
//   static const String materialKey = "Material";

//   final int branchId;
//   static const String branchIdKey = "branchId";

//   final DateTime? createdDate;
//   static const String createdDateKey = "CreatedDate";

//   final String createdUser;
//   static const String createdUserKey = "CreatedUser";

//   final DateTime? modifiedDate;
//   static const String modifiedDateKey = "ModifiedDate";

//   final String modifiedUser;
//   static const String modifiedUserKey = "ModifiedUser";

//   final String documentName;
//   static const String documentNameKey = "documentName";

//   final String notes;
//   static const String notesKey = "notes";

//   final String link;
//   static const String linkKey = "link";

//   final bool favorite;
//   static const String favoriteKey = "favorite";

//   MaterialList copyWith({
//     int? materialId,
//     int? staffId,
//     String? employeeName,
//     String? accYear,
//     int? standardId,
//     String? standard,
//     int? divisionId,
//     String? division,
//     int? subjectId,
//     String? subjectName,
//     String? material,
//     int? branchId,
//     DateTime? createdDate,
//     String? createdUser,
//     DateTime? modifiedDate,
//     String? modifiedUser,
//     String? documentName,
//     String? notes,
//     String? link,
//     bool? favorite,
//   }) {
//     return MaterialList(
//       materialId: materialId ?? this.materialId,
//       staffId: staffId ?? this.staffId,
//       employeeName: employeeName ?? this.employeeName,
//       accYear: accYear ?? this.accYear,
//       standardId: standardId ?? this.standardId,
//       standard: standard ?? this.standard,
//       divisionId: divisionId ?? this.divisionId,
//       division: division ?? this.division,
//       subjectId: subjectId ?? this.subjectId,
//       subjectName: subjectName ?? this.subjectName,
//       material: material ?? this.material,
//       branchId: branchId ?? this.branchId,
//       createdDate: createdDate ?? this.createdDate,
//       createdUser: createdUser ?? this.createdUser,
//       modifiedDate: modifiedDate ?? this.modifiedDate,
//       modifiedUser: modifiedUser ?? this.modifiedUser,
//       documentName: documentName ?? this.documentName,
//       notes: notes ?? this.notes,
//       link: link ?? this.link,
//       favorite: favorite ?? this.favorite,
//     );
//   }

//   factory MaterialList.fromJson(Map<String, dynamic> json) {
//     return MaterialList(
//       materialId: json["materialId"] ?? 0,
//       staffId: json["StaffId"] ?? 0,
//       employeeName: json["employeeName"] ?? "",
//       accYear: json["AccYear"] ?? "",
//       standardId: json["StandardId"] ?? 0,
//       standard: json["Standard"] ?? "",
//       divisionId: json["DivisionId"] ?? 0,
//       division: json["Division"] ?? "",
//       subjectId: json["SubjectId"] ?? 0,
//       subjectName: json["SubjectName"] ?? "",
//       material: json["Material"] ?? "",
//       branchId: json["branchId"] ?? 0,
//       createdDate: DateTime.tryParse(json["CreatedDate"] ?? ""),
//       createdUser: json["CreatedUser"] ?? "",
//       modifiedDate: DateTime.tryParse(json["ModifiedDate"] ?? ""),
//       modifiedUser: json["ModifiedUser"] ?? "",
//       documentName: json["documentName"] ?? "",
//       notes: json["notes"] ?? "",
//       link: json["link"] ?? "",
//       favorite: json["favorite"] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     "materialId": materialId,
//     "StaffId": staffId,
//     "employeeName": employeeName,
//     "AccYear": accYear,
//     "StandardId": standardId,
//     "Standard": standard,
//     "DivisionId": divisionId,
//     "Division": division,
//     "SubjectId": subjectId,
//     "SubjectName": subjectName,
//     "Material": material,
//     "branchId": branchId,
//     "CreatedDate": createdDate?.toIso8601String(),
//     "CreatedUser": createdUser,
//     "ModifiedDate": modifiedDate?.toIso8601String(),
//     "ModifiedUser": modifiedUser,
//     "documentName": documentName,
//     "notes": notes,
//     "link": link,
//     "favorite": favorite,
//   };

//   @override
//   String toString() {
//     return "$materialId, $staffId, $employeeName, $accYear, $standardId, $standard, $divisionId, $division, $subjectId, $subjectName, $material, $branchId, $createdDate, $createdUser, $modifiedDate, $modifiedUser, $documentName, $notes, $link, $favorite, ";
//   }

//   @override
//   List<Object?> get props => [
//     materialId,
//     staffId,
//     employeeName,
//     accYear,
//     standardId,
//     standard,
//     divisionId,
//     division,
//     subjectId,
//     subjectName,
//     material,
//     branchId,
//     createdDate,
//     createdUser,
//     modifiedDate,
//     modifiedUser,
//     documentName,
//     notes,
//     link,
//     favorite,
//   ];
// }
import 'package:equatable/equatable.dart';

class MaterialsbysubjectResult extends Equatable {
  const MaterialsbysubjectResult({
    required this.status,
    required this.error,
    required this.data,
  });

  final int status;
  final bool error;
  final List<MaterialList> data;

  factory MaterialsbysubjectResult.fromJson(Map<String, dynamic> json) {
    return MaterialsbysubjectResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data:
          (json["data"] as List<dynamic>?)
              ?.map((e) => MaterialList.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "data": data.map((e) => e.toJson()).toList(),
  };

  @override
  List<Object?> get props => [status, error, data];
}

class MaterialList extends Equatable {
  const MaterialList({
    required this.materialId,
    required this.staffId,
    this.employeeName,
    required this.accYear,
    required this.standardId,
    required this.standard,
    required this.divisionId,
    required this.division,
    required this.subjectId,
    required this.subjectName,
    required this.material,
    required this.branchId,
    this.createdDate,
    required this.createdUser,
    this.modifiedDate,
    required this.modifiedUser,
    this.documentName,
    required this.notes,
    this.link,
    required this.favorite,
  });

  final int materialId;
  final int staffId;
  final String? employeeName;
  final String accYear;
  final int standardId;
  final String standard;
  final int divisionId;
  final String division;
  final int subjectId;
  final String subjectName;

  /// API returns List<String>
  final List<String> material;

  final int branchId;
  final DateTime? createdDate;
  final String createdUser;
  final DateTime? modifiedDate;
  final String modifiedUser;
  final String? documentName;
  final String notes;
  final String? link;
  final bool favorite;

  factory MaterialList.fromJson(Map<String, dynamic> json) {
    return MaterialList(
      materialId: json["materialId"] ?? 0,
      staffId: json["StaffId"] ?? 0,
      employeeName: json["employeeName"],
      accYear: json["AccYear"] ?? "",
      standardId: json["StandardId"] ?? 0,
      standard: json["Standard"] ?? "",
      divisionId: json["DivisionId"] ?? 0,
      division: json["Division"] ?? "",
      subjectId: json["SubjectId"] ?? 0,
      subjectName: json["SubjectName"] ?? "",
      material:
          (json["Material"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      branchId: json["branchId"] ?? 0,
      createdDate: DateTime.tryParse(json["CreatedDate"] ?? ""),
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: DateTime.tryParse(json["ModifiedDate"] ?? ""),
      modifiedUser: json["ModifiedUser"] ?? "",
      documentName: json["documentName"],
      notes: json["notes"] ?? "",
      link: json["link"],
      favorite: json["favorite"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    "materialId": materialId,
    "StaffId": staffId,
    "employeeName": employeeName,
    "AccYear": accYear,
    "StandardId": standardId,
    "Standard": standard,
    "DivisionId": divisionId,
    "Division": division,
    "SubjectId": subjectId,
    "SubjectName": subjectName,
    "Material": material,
    "branchId": branchId,
    "CreatedDate": createdDate?.toIso8601String(),
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate?.toIso8601String(),
    "ModifiedUser": modifiedUser,
    "documentName": documentName,
    "notes": notes,
    "link": link,
    "favorite": favorite,
  };

  @override
  List<Object?> get props => [
    materialId,
    staffId,
    employeeName,
    accYear,
    standardId,
    standard,
    divisionId,
    division,
    subjectId,
    subjectName,
    material,
    branchId,
    createdDate,
    createdUser,
    modifiedDate,
    modifiedUser,
    documentName,
    notes,
    link,
    favorite,
  ];
}
