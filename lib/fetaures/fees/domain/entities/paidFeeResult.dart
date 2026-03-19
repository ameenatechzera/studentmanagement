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

  PaidFeeResult copyWith({int? status, bool? error, List<Datum>? data}) {
    return PaidFeeResult(
      status: status ?? this.status,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  factory PaidFeeResult.fromJson(Map<String, dynamic> json) {
    return PaidFeeResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "data": data.map((x) => x.toJson()).toList(),
  };

  @override
  String toString() {
    return "$status, $error, $data, ";
  }

  @override
  List<Object?> get props => [status, error, data];
}

class Datum extends Equatable {
  Datum({
    required this.admno,
    required this.standard,
    required this.division,
    required this.stdonAdm,
    required this.ledgerName,
    required this.totalAmount,
    required this.paidAmount,
    required this.balanceAmount,
    required this.feeMonth,
    required this.name,
    required this.dueDate,
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

  final String totalAmount;
  static const String totalAmountKey = "TotalAmount";

  final String paidAmount;
  static const String paidAmountKey = "PaidAmount";

  final String balanceAmount;
  static const String balanceAmountKey = "BalanceAmount";

  final String feeMonth;
  static const String feeMonthKey = "FeeMonth";

  final String name;
  static const String nameKey = "Name";

  final String? dueDate;
  static const String dueDateKey = "DueDate";

  Datum copyWith({
    String? admno,
    String? standard,
    String? division,
    String? stdonAdm,
    String? ledgerName,
    String? totalAmount,
    String? paidAmount,
    String? balanceAmount,
    String? feeMonth,
    String? name,
    String? dueDate,
  }) {
    return Datum(
      admno: admno ?? this.admno,
      standard: standard ?? this.standard,
      division: division ?? this.division,
      stdonAdm: stdonAdm ?? this.stdonAdm,
      ledgerName: ledgerName ?? this.ledgerName,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      balanceAmount: balanceAmount ?? this.balanceAmount,
      feeMonth: feeMonth ?? this.feeMonth,
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      admno: json["Admno"] ?? "",
      standard: json["Standard"] ?? "",
      division: json["Division"] ?? "",
      stdonAdm: json["StdonAdm"] ?? "",
      ledgerName: json["LedgerName"] ?? "",
      totalAmount: json["TotalAmount"] ?? "",
      paidAmount: json["PaidAmount"] ?? "",
      balanceAmount: json["BalanceAmount"] ?? "",
      feeMonth: json["FeeMonth"] ?? "",
      name: json["Name"] ?? "",
      dueDate: json["DueDate"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "Admno": admno,
    "Standard": standard,
    "Division": division,
    "StdonAdm": stdonAdm,
    "LedgerName": ledgerName,
    "TotalAmount": totalAmount,
    "PaidAmount": paidAmount,
    "BalanceAmount": balanceAmount,
    "FeeMonth": feeMonth,
    "Name": name,
    "DueDate": dueDate,
  };

  @override
  String toString() {
    return "$admno, $standard, $division, $stdonAdm, $ledgerName, $totalAmount, $paidAmount, $balanceAmount, $feeMonth, $name, $dueDate, ";
  }

  @override
  List<Object?> get props => [
    admno,
    standard,
    division,
    stdonAdm,
    ledgerName,
    totalAmount,
    paidAmount,
    balanceAmount,
    feeMonth,
    name,
    dueDate,
  ];
}
