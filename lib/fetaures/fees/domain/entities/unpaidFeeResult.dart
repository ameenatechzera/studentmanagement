import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class UnpaidFeeResult extends Equatable {
  UnpaidFeeResult({
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


  UnpaidFeeResult copyWith({
    int? status,
    bool? error,
    List<Datum>? data,
  }) {
    return UnpaidFeeResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory UnpaidFeeResult.fromJson(Map<String, dynamic> json){
    return UnpaidFeeResult(
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
    required this.accYear,
    required this.feeMonth,
    required this.ledgerName,
    required this.totalAmount,
    required this.paidAmount,
    required this.dueAmount,
    required this.dueDate,
  });

  final String admno;
  static const String admnoKey = "Admno";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String feeMonth;
  static const String feeMonthKey = "FeeMonth";

  final String ledgerName;
  static const String ledgerNameKey = "LedgerName";

  final String totalAmount;
  static const String totalAmountKey = "TotalAmount";

  final String paidAmount;
  static const String paidAmountKey = "PaidAmount";

  final String dueAmount;
  static const String dueAmountKey = "DueAmount";

  final String? dueDate;
  static const String dueDateKey = "DueDate";


  Datum copyWith({
    String? admno,
    String? accYear,
    String? feeMonth,
    String? ledgerName,
    String? totalAmount,
    String? paidAmount,
    String? dueAmount,
    String? dueDate,
  }) {
    return Datum(
      admno: admno ?? this.admno,
      accYear: accYear ?? this.accYear,
      feeMonth: feeMonth ?? this.feeMonth,
      ledgerName: ledgerName ?? this.ledgerName,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      dueAmount: dueAmount ?? this.dueAmount,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      admno: json["Admno"] ?? "",
      accYear: json["AccYear"] ?? "",
      feeMonth: json["FeeMonth"] ?? "",
      ledgerName: json["LedgerName"] ?? "",
      totalAmount: json["TotalAmount"] ?? "",
      paidAmount: json["PaidAmount"] ?? "",
      dueAmount: json["DueAmount"] ?? "",
      dueDate: json["DueDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "Admno": admno,
    "AccYear": accYear,
    "FeeMonth": feeMonth,
    "LedgerName": ledgerName,
    "TotalAmount": totalAmount,
    "PaidAmount": paidAmount,
    "DueAmount": dueAmount,
    "DueDate": dueDate
  };

  @override
  String toString(){
    return "$admno, $accYear, $feeMonth, $ledgerName, $totalAmount, $paidAmount, $dueAmount, $dueDate, ";
  }

  @override
  List<Object?> get props => [
    admno, accYear, feeMonth, ledgerName, totalAmount, paidAmount, dueAmount, dueDate, ];
}

