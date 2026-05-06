import 'package:equatable/equatable.dart';

class SubjectsResult extends Equatable {
  SubjectsResult({
    required this.status,
    required this.error,
    required this.data,
  });

  final int status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final List<SubjectList> data;
  static const String dataKey = "data";


  SubjectsResult copyWith({
    int? status,
    bool? error,
    List<SubjectList>? data,
  }) {
    return SubjectsResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory SubjectsResult.fromJson(Map<String, dynamic> json){
    return SubjectsResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<SubjectList>.from(json["data"]!.map((x) => SubjectList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "data": data.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $error, $data, ";
  }

  @override
  List<Object?> get props => [
    status, error, data, ];
}

class SubjectList extends Equatable {
  SubjectList({
    required this.subjectId,
    required this.subjectName,
    required this.shortName,
    required this.status,
    required this.branchId,
    required this.createdDate,
    required this.createdUser,
    required this.modifiedDate,
    required this.modifiedUser,
  });

  final String subjectId;
  static const String subjectIdKey = "SubjectId";

  final String subjectName;
  static const String subjectNameKey = "SubjectName";

  final String shortName;
  static const String shortNameKey = "ShortName";

  final bool status;
  static const String statusKey = "Status";

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


  SubjectList copyWith({
    String? subjectId,
    String? subjectName,
    String? shortName,
    bool? status,
    int? branchId,
    DateTime? createdDate,
    String? createdUser,
    dynamic? modifiedDate,
    dynamic? modifiedUser,
  }) {
    return SubjectList(
      subjectId: subjectId ?? this.subjectId,
      subjectName: subjectName ?? this.subjectName,
      shortName: shortName ?? this.shortName,
      status: status ?? this.status,
      branchId: branchId ?? this.branchId,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedUser: modifiedUser ?? this.modifiedUser,
    );
  }

  factory SubjectList.fromJson(Map<String, dynamic> json){
    return SubjectList(
      subjectId: json["SubjectId"] ?? "",
      subjectName: json["SubjectName"] ?? "",
      shortName: json["ShortName"] ?? "",
      status: json["Status"] ?? false,
      branchId: json["branchId"] ?? 0,
      createdDate: DateTime.tryParse(json["CreatedDate"] ?? ""),
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: json["ModifiedDate"],
      modifiedUser: json["ModifiedUser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "SubjectId": subjectId,
    "SubjectName": subjectName,
    "ShortName": shortName,
    "Status": status,
    "branchId": branchId,
    "CreatedDate": createdDate?.toIso8601String(),
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate,
    "ModifiedUser": modifiedUser,
  };

  @override
  String toString(){
    return "$subjectId, $subjectName, $shortName, $status, $branchId, $createdDate, $createdUser, $modifiedDate, $modifiedUser, ";
  }

  @override
  List<Object?> get props => [
    subjectId, subjectName, shortName, status, branchId, createdDate, createdUser, modifiedDate, modifiedUser, ];
}
