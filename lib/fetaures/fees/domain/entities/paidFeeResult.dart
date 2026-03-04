import 'package:equatable/equatable.dart';

class PaidFeeResult extends Equatable {
  PaidFeeResult({
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


  PaidFeeResult copyWith({
    int? status,
    bool? error,
    List<Datum>? data,
  }) {
    return PaidFeeResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory PaidFeeResult.fromJson(Map<String, dynamic> json){
    return PaidFeeResult(
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
    required this.admno,
    required this.standard,
    required this.division,
    required this.stdonAdm,
    required this.ledgerName,
    required this.amount,
    required this.feeMonth,
    required this.name,
  });

  final String admno;
  static const String admnoKey = "Admno";

  final String standard;
  static const String standardKey = "Standard";

  final String division;
  static const String divisionKey = "Division";

  final String stdonAdm;
  static const String stdonAdmKey = "StdonAdm";

  final String ledgerName;
  static const String ledgerNameKey = "LedgerName";

  final String amount;
  static const String amountKey = "Amount";

  final String feeMonth;
  static const String feeMonthKey = "FeeMonth";

  final String name;
  static const String nameKey = "Name";


  Datum copyWith({
    String? admno,
    String? standard,
    String? division,
    String? stdonAdm,
    String? ledgerName,
    String? amount,
    String? feeMonth,
    String? name,
  }) {
    return Datum(
      admno: admno ?? this.admno,
      standard: standard ?? this.standard,
      division: division ?? this.division,
      stdonAdm: stdonAdm ?? this.stdonAdm,
      ledgerName: ledgerName ?? this.ledgerName,
      amount: amount ?? this.amount,
      feeMonth: feeMonth ?? this.feeMonth,
      name: name ?? this.name,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      admno: json["Admno"] ?? "",
      standard: json["Standard"] ?? "",
      division: json["Division"] ?? "",
      stdonAdm: json["StdonAdm"] ?? "",
      ledgerName: json["LedgerName"] ?? "",
      amount: json["Amount"] ?? "",
      feeMonth: json["FeeMonth"] ?? "",
      name: json["Name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "Admno": admno,
    "Standard": standard,
    "Division": division,
    "StdonAdm": stdonAdm,
    "LedgerName": ledgerName,
    "Amount": amount,
    "FeeMonth": feeMonth,
    "Name": name,
  };

  @override
  String toString(){
    return "$admno, $standard, $division, $stdonAdm, $ledgerName, $amount, $feeMonth, $name, ";
  }

  @override
  List<Object?> get props => [
    admno, standard, division, stdonAdm, ledgerName, amount, feeMonth, name, ];
}
