import 'package:equatable/equatable.dart';

class FeePaymentGatewayDetails extends Equatable {
  FeePaymentGatewayDetails({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  final int status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final String message;
  static const String messageKey = "message";

  final List<Datum> data;
  static const String dataKey = "data";


  FeePaymentGatewayDetails copyWith({
    int? status,
    bool? error,
    String? message,
    List<Datum>? data,
  }) {
    return FeePaymentGatewayDetails(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory FeePaymentGatewayDetails.fromJson(Map<String, dynamic> json){
    return FeePaymentGatewayDetails(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $error, $message, $data, ";
  }

  @override
  List<Object?> get props => [
    status, error, message, data, ];
}

class Datum extends Equatable {
  Datum({
    required this.id,
    required this.merchantKey,
    required this.saltkey,
    required this.schoolname,
    required this.schoolcode,
    required this.apptype,
    required this.gatewayName,
    required this.branchId,
    required this.createdDate,
    required this.createdUser,
  });

  final int id;
  static const String idKey = "Id";

  final String merchantKey;
  static const String merchantKeyKey = "merchantKey";

  final String saltkey;
  static const String saltkeyKey = "saltkey";

  final String schoolname;
  static const String schoolnameKey = "schoolname";

  final String schoolcode;
  static const String schoolcodeKey = "schoolcode";

  final String apptype;
  static const String apptypeKey = "apptype";

  final String gatewayName;
  static const String gatewayNameKey = "gatewayName";

  final int branchId;
  static const String branchIdKey = "branchId";

  final dynamic createdDate;
  static const String createdDateKey = "CreatedDate";

  final dynamic createdUser;
  static const String createdUserKey = "CreatedUser";


  Datum copyWith({
    int? id,
    String? merchantKey,
    String? saltkey,
    String? schoolname,
    String? schoolcode,
    String? apptype,
    String? gatewayName,
    int? branchId,
    dynamic? createdDate,
    dynamic? createdUser,
  }) {
    return Datum(
      id: id ?? this.id,
      merchantKey: merchantKey ?? this.merchantKey,
      saltkey: saltkey ?? this.saltkey,
      schoolname: schoolname ?? this.schoolname,
      schoolcode: schoolcode ?? this.schoolcode,
      apptype: apptype ?? this.apptype,
      gatewayName: gatewayName ?? this.gatewayName,
      branchId: branchId ?? this.branchId,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["Id"] ?? 0,
      merchantKey: json["merchantKey"] ?? "",
      saltkey: json["saltkey"] ?? "",
      schoolname: json["schoolname"] ?? "",
      schoolcode: json["schoolcode"] ?? "",
      apptype: json["apptype"] ?? "",
      gatewayName: json["gatewayName"] ?? "",
      branchId: json["branchId"] ?? 0,
      createdDate: json["CreatedDate"],
      createdUser: json["CreatedUser"],
    );
  }

  Map<String, dynamic> toJson() => {
    "Id": id,
    "merchantKey": merchantKey,
    "saltkey": saltkey,
    "schoolname": schoolname,
    "schoolcode": schoolcode,
    "apptype": apptype,
    "gatewayName": gatewayName,
    "branchId": branchId,
    "CreatedDate": createdDate,
    "CreatedUser": createdUser,
  };

  @override
  String toString(){
    return "$id, $merchantKey, $saltkey, $schoolname, $schoolcode, $apptype, $gatewayName, $branchId, $createdDate, $createdUser, ";
  }

  @override
  List<Object?> get props => [
    id, merchantKey, saltkey, schoolname, schoolcode, apptype, gatewayName, branchId, createdDate, createdUser, ];
}
