import 'package:equatable/equatable.dart';

class FeePaymentExistResult extends Equatable {
  FeePaymentExistResult({
    required this.status,
    required this.error,
    required this.message,
    required this.data,
  });

  final bool status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final String message;
  static const String messageKey = "message";

  final List<Datum> data;
  static const String dataKey = "data";


  FeePaymentExistResult copyWith({
    bool? status,
    bool? error,
    String? message,
    List<Datum>? data,
  }) {
    return FeePaymentExistResult(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory FeePaymentExistResult.fromJson(Map<String, dynamic> json){
    return FeePaymentExistResult(
      status: json["status"] ?? false,
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
    required this.status,
    required this.error,
    required this.message,
    required this.feemonthId,
    required this.feemonth,
    required this.ledgerId,
    required this.ledgerName,
    required this.paidAmount,
  });

  final bool status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final String message;
  static const String messageKey = "message";

  final int feemonthId;
  static const String feemonthIdKey = "feemonthId";

  final dynamic feemonth;
  static const String feemonthKey = "feemonth";

  final int ledgerId;
  static const String ledgerIdKey = "ledgerId";

  final dynamic ledgerName;
  static const String ledgerNameKey = "ledgerName";

  final String paidAmount;
  static const String paidAmountKey = "paidAmount";


  Datum copyWith({
    bool? status,
    bool? error,
    String? message,
    int? feemonthId,
    dynamic? feemonth,
    int? ledgerId,
    dynamic? ledgerName,
    String? paidAmount,
  }) {
    return Datum(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
      feemonthId: feemonthId ?? this.feemonthId,
      feemonth: feemonth ?? this.feemonth,
      ledgerId: ledgerId ?? this.ledgerId,
      ledgerName: ledgerName ?? this.ledgerName,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      status: json["status"] ?? false,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      feemonthId: json["feemonthId"] ?? 0,
      feemonth: json["feemonth"],
      ledgerId: json["ledgerId"] ?? 0,
      ledgerName: json["ledgerName"],
      paidAmount: json["paidAmount"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
    "feemonthId": feemonthId,
    "feemonth": feemonth,
    "ledgerId": ledgerId,
    "ledgerName": ledgerName,
    "paidAmount": paidAmount,
  };

  @override
  String toString(){
    return "$status, $error, $message, $feemonthId, $feemonth, $ledgerId, $ledgerName, $paidAmount, ";
  }

  @override
  List<Object?> get props => [
    status, error, message, feemonthId, feemonth, ledgerId, ledgerName, paidAmount, ];
}
