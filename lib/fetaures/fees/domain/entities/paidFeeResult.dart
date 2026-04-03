import 'package:equatable/equatable.dart';

class PaidFeeResult extends Equatable {
  PaidFeeResult({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool status;
  static const String statusKey = "status";

  final String message;
  static const String messageKey = "message";

  final List<Datum> data;
  static const String dataKey = "data";


  PaidFeeResult copyWith({
    bool? status,
    String? message,
    List<Datum>? data,
  }) {
    return PaidFeeResult(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory PaidFeeResult.fromJson(Map<String, dynamic> json){
    return PaidFeeResult(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$status, $message, $data, ";
  }

  @override
  List<Object?> get props => [
    status, message, data, ];
}

class Datum extends Equatable {
  Datum({
    required this.feePaymentMasterId,
    required this.receiptNo,
    required this.date,
    required this.paymentMode,
    required this.totalPaidAmount,
    required this.details,
  });

  final String feePaymentMasterId;
  static const String feePaymentMasterIdKey = "FeePaymentMasterId";

  final String receiptNo;
  static const String receiptNoKey = "receiptNo";

  final String? date;
  static const String dateKey = "Date";

  final String paymentMode;
  static const String paymentModeKey = "paymentMode";

  final String totalPaidAmount;
  static const String totalPaidAmountKey = "totalPaidAmount";

  final List<Detail> details;
  static const String detailsKey = "details";


  Datum copyWith({
    String? feePaymentMasterId,
    String? receiptNo,
    String? date,
    String? paymentMode,
    String? totalPaidAmount,
    List<Detail>? details,
  }) {
    return Datum(
      feePaymentMasterId: feePaymentMasterId ?? this.feePaymentMasterId,
      receiptNo: receiptNo ?? this.receiptNo,
      date: date ?? this.date,
      paymentMode: paymentMode ?? this.paymentMode,
      totalPaidAmount: totalPaidAmount ?? this.totalPaidAmount,
      details: details ?? this.details,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      feePaymentMasterId: json["FeePaymentMasterId"] ?? "",
      receiptNo: json["receiptNo"] ?? "",
      date: json["Date"] ?? "",
      paymentMode: json["paymentMode"] ?? "",
      totalPaidAmount: json["totalPaidAmount"] ?? "",
      details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "FeePaymentMasterId": feePaymentMasterId,
    "receiptNo": receiptNo,
    "Date": date,
    "paymentMode": paymentMode,
    "totalPaidAmount": totalPaidAmount,
    "details": details.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$feePaymentMasterId, $receiptNo, $date, $paymentMode, $totalPaidAmount, $details, ";
  }

  @override
  List<Object?> get props => [
    feePaymentMasterId, receiptNo, date, paymentMode, totalPaidAmount, details, ];
}

class Detail extends Equatable {
  Detail({
    required this.feeMonth,
    required this.ledgerName,
    required this.paidAmount,
  });

  final String feeMonth;
  static const String feeMonthKey = "feeMonth";

  final String ledgerName;
  static const String ledgerNameKey = "ledgerName";

  final int paidAmount;
  static const String paidAmountKey = "paidAmount";


  Detail copyWith({
    String? feeMonth,
    String? ledgerName,
    int? paidAmount,
  }) {
    return Detail(
      feeMonth: feeMonth ?? this.feeMonth,
      ledgerName: ledgerName ?? this.ledgerName,
      paidAmount: paidAmount ?? this.paidAmount,
    );
  }

  factory Detail.fromJson(Map<String, dynamic> json){
    return Detail(
      feeMonth: json["feeMonth"] ?? "",
      ledgerName: json["ledgerName"] ?? "",
      paidAmount: json["paidAmount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "feeMonth": feeMonth,
    "ledgerName": ledgerName,
    "paidAmount": paidAmount,
  };

  @override
  String toString(){
    return "$feeMonth, $ledgerName, $paidAmount, ";
  }

  @override
  List<Object?> get props => [
    feeMonth, ledgerName, paidAmount, ];
}
