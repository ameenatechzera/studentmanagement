import 'package:equatable/equatable.dart';

class AccYearResult extends Equatable {
  AccYearResult({
    required this.status,
    required this.error,
    required this.data,
  });

  final int status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final List<Datum> data;
  static const String dataKey = "data";


  AccYearResult copyWith({
    int? status,
    bool? error,
    List<Datum>? data,
  }) {
    return AccYearResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory AccYearResult.fromJson(Map<String, dynamic> json){
    return AccYearResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum extends Equatable {
  Datum({
    required this.accYearId,
    required this.accYear,
    required this.fromDate,
    required this.toDate,
    required this.status,
    required this.branchId,
    required this.createdDate,
    required this.createdUser,
    required this.modifiedDate,
    required this.modifiedUser,
  });

  final String accYearId;
  static const String accYearIdKey = "AccYearId";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String? fromDate;
  static const String fromDateKey = "fromDate";

  final String? toDate;
  static const String toDateKey = "toDate";

  final bool status;
  static const String statusKey = "status";

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


  Datum copyWith({
    String? accYearId,
    String? accYear,
    String? fromDate,
    String? toDate,
    bool? status,
    int? branchId,
    String? createdDate,
    String? createdUser,
    dynamic? modifiedDate,
    dynamic? modifiedUser,
  }) {
    return Datum(
      accYearId: accYearId ?? this.accYearId,
      accYear: accYear ?? this.accYear,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      status: status ?? this.status,
      branchId: branchId ?? this.branchId,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedUser: modifiedUser ?? this.modifiedUser,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      accYearId: json["AccYearId"] ?? "",
      accYear: json["AccYear"] ?? "",
      fromDate: json["fromDate"] ?? "",
      toDate: json["toDate"] ?? "",
      status: json["status"] ?? false,
      branchId: json["branchId"] ?? 0,
      createdDate: json["CreatedDate"] ?? "",
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: json["ModifiedDate"],
      modifiedUser: json["ModifiedUser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "AccYearId": accYearId,
    "AccYear": accYear,
    "fromDate": fromDate,
    "toDate": toDate,
    "status": status,
    "branchId": branchId,
    "CreatedDate": createdDate,
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate,
    "ModifiedUser": modifiedUser,
  };

  @override
  String toString(){
    return "$accYearId, $accYear, $fromDate, $toDate, $status, $branchId, $createdDate, $createdUser, $modifiedDate, $modifiedUser, ";
  }

  @override
  List<Object?> get props => [
    accYearId, accYear, fromDate, toDate, status, branchId, createdDate, createdUser, modifiedDate, modifiedUser, ];
}
