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
    required this.feeMonth,
    required this.dueDate,
    required this.totalBalance,
    required this.details,
  });

  final String feeMonth;
  static const String feeMonthKey = "FeeMonth";

  final String? dueDate;
  static const String dueDateKey = "DueDate";

  final String totalBalance;
  static const String totalBalanceKey = "TotalBalance";

  final List<Detail> details;
  static const String detailsKey = "details";


  Datum copyWith({
    String? feeMonth,
    String? dueDate,
    String? totalBalance,
    List<Detail>? details,
  }) {
    return Datum(
      feeMonth: feeMonth ?? this.feeMonth,
      dueDate: dueDate ?? this.dueDate,
      totalBalance: totalBalance ?? this.totalBalance,
      details: details ?? this.details,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      feeMonth: json["FeeMonth"] ?? "",
      dueDate: json["DueDate"] ?? "",
      totalBalance: json["TotalBalance"] ?? "",
      details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "FeeMonth": feeMonth,
    "DueDate": dueDate,
    "TotalBalance": totalBalance,
    "details": details.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$feeMonth, $dueDate, $totalBalance, $details, ";
  }

  @override
  List<Object?> get props => [
    feeMonth, dueDate, totalBalance, details, ];
}

class Detail extends Equatable {
  Detail({
    required this.ledgerName,
    required this.amount,
  });

  final String ledgerName;
  static const String ledgerNameKey = "LedgerName";

  final String amount;
  static const String amountKey = "Amount";


  Detail copyWith({
    String? ledgerName,
    String? amount,
  }) {
    return Detail(
      ledgerName: ledgerName ?? this.ledgerName,
      amount: amount ?? this.amount,
    );
  }

  factory Detail.fromJson(Map<String, dynamic> json){
    return Detail(
      ledgerName: json["LedgerName"] ?? "",
      amount: json["Amount"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "LedgerName": ledgerName,
    "Amount": amount,
  };

  @override
  String toString(){
    return "$ledgerName, $amount, ";
  }

  @override
  List<Object?> get props => [
    ledgerName, amount, ];
}
