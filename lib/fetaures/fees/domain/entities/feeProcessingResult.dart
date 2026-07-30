import 'package:equatable/equatable.dart';

class FeeProcessingResult extends Equatable {
  FeeProcessingResult({
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


  FeeProcessingResult copyWith({
    int? status,
    bool? error,
    String? message,
    List<Datum>? data,
  }) {
    return FeeProcessingResult(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory FeeProcessingResult.fromJson(Map<String, dynamic> json){
    return FeeProcessingResult(
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
    required this.status,
    required this.feemonths,
  });

  final String status;
  static const String statusKey = "status";

  final List<Feemonth> feemonths;
  static const String feemonthsKey = "feemonths";


  Datum copyWith({
    String? status,
    List<Feemonth>? feemonths,
  }) {
    return Datum(
      status: status ?? this.status,
      feemonths: feemonths ?? this.feemonths,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      status: json["status"] ?? "",
      feemonths: json["feemonths"] == null ? [] : List<Feemonth>.from(json["feemonths"]!.map((x) => Feemonth.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "feemonths": feemonths.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $feemonths, ";
  }

  @override
  List<Object?> get props => [
    status, feemonths, ];
}

class Feemonth extends Equatable {
  Feemonth({
    required this.feemonthId,
    required this.feemonth,
    required this.details,
  });

  final int feemonthId;
  static const String feemonthIdKey = "feemonthId";

  final String feemonth;
  static const String feemonthKey = "feemonth";

  final List<Detail> details;
  static const String detailsKey = "details";


  Feemonth copyWith({
    int? feemonthId,
    String? feemonth,
    List<Detail>? details,
  }) {
    return Feemonth(
      feemonthId: feemonthId ?? this.feemonthId,
      feemonth: feemonth ?? this.feemonth,
      details: details ?? this.details,
    );
  }

  factory Feemonth.fromJson(Map<String, dynamic> json){
    return Feemonth(
      feemonthId: json["feemonthId"] ?? 0,
      feemonth: json["feemonth"] ?? "",
      details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "feemonthId": feemonthId,
    "feemonth": feemonth,
    "details": details.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$feemonthId, $feemonth, $details, ";
  }

  @override
  List<Object?> get props => [
    feemonthId, feemonth, details, ];
}

class Detail extends Equatable {
  Detail({
    required this.ledgerId,
    required this.ledgerName,
    required this.dueAmount,
    required this.paidAmount,
  });

  final int ledgerId;
  static const String ledgerIdKey = "ledgerId";

  final String ledgerName;
  static const String ledgerNameKey = "ledgerName";

  final String dueAmount;
  static const String dueAmountKey = "dueAmount";

  final String paidAmount;
  static const String paidAmountKey = "paidAmount";


  Detail copyWith({
    int? ledgerId,
    String? ledgerName,
    String? dueAmount,
    String? paidAmount,
  }) {
    return Detail(
      ledgerId: ledgerId ?? this.ledgerId,
      ledgerName: ledgerName ?? this.ledgerName,
      dueAmount: dueAmount ?? this.dueAmount,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  factory Detail.fromJson(Map<String, dynamic> json){
    return Detail(
      ledgerId: json["ledgerId"] ?? 0,
      ledgerName: json["ledgerName"] ?? "",
      dueAmount: json["dueAmount"] ?? "0",
      paidAmount: json["paidAmount"] ?? "0",
    );
  }

  Map<String, dynamic> toJson() => {
    "ledgerId": ledgerId,
    "ledgerName": ledgerName,
    "dueAmount": dueAmount,
    "paidAmount": paidAmount,
  };

  @override
  String toString(){
    return "$ledgerId, $ledgerName, $dueAmount, $paidAmount, ";
  }

  @override
  List<Object?> get props => [
    ledgerId, ledgerName, dueAmount, paidAmount, ];
}
