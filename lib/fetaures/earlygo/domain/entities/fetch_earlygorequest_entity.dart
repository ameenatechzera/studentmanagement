import 'package:equatable/equatable.dart';

class FetchEarlyLeaveResponse extends Equatable {
  FetchEarlyLeaveResponse({
    required this.status,
    required this.message,
    required this.error,
    required this.data,
  });

  final int status;
  static const String statusKey = "status";

  final String message;
  static const String messageKey = "message";

  final bool error;
  static const String errorKey = "error";

  final List<EarlygoList> data;
  static const String dataKey = "data";


  FetchEarlyLeaveResponse copyWith({
    int? status,
    String? message,
    bool? error,
    List<EarlygoList>? data,
  }) {
    return FetchEarlyLeaveResponse(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory FetchEarlyLeaveResponse.fromJson(Map<String, dynamic> json){
    return FetchEarlyLeaveResponse(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<EarlygoList>.from(json["data"]!.map((x) => EarlygoList.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "error": error,
    "data": data.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $message, $error, $data, ";
  }

  @override
  List<Object?> get props => [
    status, message, error, data, ];
}

class EarlygoList extends Equatable {
  EarlygoList({
    required this.id,
    required this.requestNo,
    required this.accYear,
    required this.admno,
    required this.requestDate,
    required this.earlyLeaveData,
    required this.leaveTime,
    required this.reason,
    required this.pickupPersonName,
    required this.pickupPersonMobile,
    required this.pickupPersonRelation,
    required this.teacherStatus,
    required this.employeeId,
    required this.teacherRemarks,
    required this.teacherApprovedAt,
    required this.finalStatus,
    required this.createdDate,
    required this.createdUser,
    required this.modifiedDate,
    required this.modifiedUser,
    required this.branchId,
  });

  final int id;
  static const String idKey = "Id";

  final String requestNo;
  static const String requestNoKey = "requestNo";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String admno;
  static const String admnoKey = "Admno";

  final String? requestDate;
  static const String requestDateKey = "RequestDate";

  final dynamic earlyLeaveData;
  static const String earlyLeaveDataKey = "EarlyLeaveData";

  final String leaveTime;
  static const String leaveTimeKey = "LeaveTime";

  final String reason;
  static const String reasonKey = "Reason";

  final String pickupPersonName;
  static const String pickupPersonNameKey = "PickupPersonName";

  final String pickupPersonMobile;
  static const String pickupPersonMobileKey = "PickupPersonMobile";

  final String pickupPersonRelation;
  static const String pickupPersonRelationKey = "PickupPersonRelation";

  final String teacherStatus;
  static const String teacherStatusKey = "TeacherStatus";

  final dynamic employeeId;
  static const String employeeIdKey = "employeeId";

  final dynamic teacherRemarks;
  static const String teacherRemarksKey = "TeacherRemarks";

  final dynamic teacherApprovedAt;
  static const String teacherApprovedAtKey = "TeacherApprovedAt";

  final String finalStatus;
  static const String finalStatusKey = "FinalStatus";

  final DateTime? createdDate;
  static const String createdDateKey = "CreatedDate";

  final String createdUser;
  static const String createdUserKey = "CreatedUser";

  final dynamic modifiedDate;
  static const String modifiedDateKey = "ModifiedDate";

  final dynamic modifiedUser;
  static const String modifiedUserKey = "ModifiedUser";

  final int branchId;
  static const String branchIdKey = "branchId";


  EarlygoList copyWith({
    int? id,
    String? requestNo,
    String? accYear,
    String? admno,
    String? requestDate,
    dynamic? earlyLeaveData,
    String? leaveTime,
    String? reason,
    String? pickupPersonName,
    String? pickupPersonMobile,
    String? pickupPersonRelation,
    String? teacherStatus,
    dynamic? employeeId,
    dynamic? teacherRemarks,
    dynamic? teacherApprovedAt,
    String? finalStatus,
    DateTime? createdDate,
    String? createdUser,
    dynamic? modifiedDate,
    dynamic? modifiedUser,
    int? branchId,
  }) {
    return EarlygoList(
      id: id ?? this.id,
      requestNo: requestNo ?? this.requestNo,
      accYear: accYear ?? this.accYear,
      admno: admno ?? this.admno,
      requestDate: requestDate ?? this.requestDate,
      earlyLeaveData: earlyLeaveData ?? this.earlyLeaveData,
      leaveTime: leaveTime ?? this.leaveTime,
      reason: reason ?? this.reason,
      pickupPersonName: pickupPersonName ?? this.pickupPersonName,
      pickupPersonMobile: pickupPersonMobile ?? this.pickupPersonMobile,
      pickupPersonRelation: pickupPersonRelation ?? this.pickupPersonRelation,
      teacherStatus: teacherStatus ?? this.teacherStatus,
      employeeId: employeeId ?? this.employeeId,
      teacherRemarks: teacherRemarks ?? this.teacherRemarks,
      teacherApprovedAt: teacherApprovedAt ?? this.teacherApprovedAt,
      finalStatus: finalStatus ?? this.finalStatus,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedUser: modifiedUser ?? this.modifiedUser,
      branchId: branchId ?? this.branchId,
    );
  }

  factory EarlygoList.fromJson(Map<String, dynamic> json){
    return EarlygoList(
      id: json["Id"] ?? 0,
      requestNo: json["requestNo"] ?? "",
      accYear: json["AccYear"] ?? "",
      admno: json["Admno"] ?? "",
      requestDate:json["RequestDate"] ?? "",
      earlyLeaveData: json["EarlyLeaveData"],
      leaveTime: json["LeaveTime"] ?? "",
      reason: json["Reason"] ?? "",
      pickupPersonName: json["PickupPersonName"] ?? "",
      pickupPersonMobile: json["PickupPersonMobile"] ?? "",
      pickupPersonRelation: json["PickupPersonRelation"] ?? "",
      teacherStatus: json["TeacherStatus"] ?? "",
      employeeId: json["employeeId"],
      teacherRemarks: json["TeacherRemarks"],
      teacherApprovedAt: json["TeacherApprovedAt"],
      finalStatus: json["FinalStatus"] ?? "",
      createdDate: DateTime.tryParse(json["CreatedDate"] ?? ""),
      createdUser: json["CreatedUser"] ?? "",
      modifiedDate: json["ModifiedDate"],
      modifiedUser: json["ModifiedUser"],
      branchId: json["branchId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "Id": id,
    "requestNo": requestNo,
    "AccYear": accYear,
    "Admno": admno,
    "RequestDate": requestDate,
    "EarlyLeaveData": earlyLeaveData,
    "LeaveTime": leaveTime,
    "Reason": reason,
    "PickupPersonName": pickupPersonName,
    "PickupPersonMobile": pickupPersonMobile,
    "PickupPersonRelation": pickupPersonRelation,
    "TeacherStatus": teacherStatus,
    "employeeId": employeeId,
    "TeacherRemarks": teacherRemarks,
    "TeacherApprovedAt": teacherApprovedAt,
    "FinalStatus": finalStatus,
    "CreatedDate": createdDate?.toIso8601String(),
    "CreatedUser": createdUser,
    "ModifiedDate": modifiedDate,
    "ModifiedUser": modifiedUser,
    "branchId": branchId,
  };

  @override
  String toString(){
    return "$id, $requestNo, $accYear, $admno, $requestDate, $earlyLeaveData, $leaveTime, $reason, $pickupPersonName, $pickupPersonMobile, $pickupPersonRelation, $teacherStatus, $employeeId, $teacherRemarks, $teacherApprovedAt, $finalStatus, $createdDate, $createdUser, $modifiedDate, $modifiedUser, $branchId, ";
  }

  @override
  List<Object?> get props => [
    id, requestNo, accYear, admno, requestDate, earlyLeaveData, leaveTime, reason, pickupPersonName, pickupPersonMobile, pickupPersonRelation, teacherStatus, employeeId, teacherRemarks, teacherApprovedAt, finalStatus, createdDate, createdUser, modifiedDate, modifiedUser, branchId, ];
}
