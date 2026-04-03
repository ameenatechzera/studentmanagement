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
    required this.accYear,
    required this.feeMonthId,
    required this.feeMonth,
    required this.ledgerId,
    required this.ledgerName,
    required this.amount,
    required this.paidAmount,
    required this.feePaymentDetailsId,
    required this.taxId,
    required this.taxName,
    required this.taxAmt,
    required this.floodCess,
    required this.narration,
  });

  final String accYear;
  static const String accYearKey = "AccYear";

  final String feeMonthId;
  static const String feeMonthIdKey = "FeeMonthId";

  final String feeMonth;
  static const String feeMonthKey = "FeeMonth";

  final String ledgerId;
  static const String ledgerIdKey = "LedgerId";

  final String ledgerName;
  static const String ledgerNameKey = "LedgerName";

  final String amount;
  static const String amountKey = "Amount";

  final String paidAmount;
  static const String paidAmountKey = "PaidAmount";

  final String feePaymentDetailsId;
  static const String feePaymentDetailsIdKey = "FeePaymentDetailsId";

  final dynamic taxId;
  static const String taxIdKey = "taxId";

  final dynamic taxName;
  static const String taxNameKey = "taxName";

  final String taxAmt;
  static const String taxAmtKey = "TaxAmt";

  final String floodCess;
  static const String floodCessKey = "FloodCess";

  final String narration;
  static const String narrationKey = "Narration";


  Datum copyWith({
    String? accYear,
    String? feeMonthId,
    String? feeMonth,
    String? ledgerId,
    String? ledgerName,
    String? amount,
    String? paidAmount,
    String? feePaymentDetailsId,
    dynamic? taxId,
    dynamic? taxName,
    String? taxAmt,
    String? floodCess,
    String? narration,
  }) {
    return Datum(
      accYear: accYear ?? this.accYear,
      feeMonthId: feeMonthId ?? this.feeMonthId,
      feeMonth: feeMonth ?? this.feeMonth,
      ledgerId: ledgerId ?? this.ledgerId,
      ledgerName: ledgerName ?? this.ledgerName,
      amount: amount ?? this.amount,
      paidAmount: paidAmount ?? this.paidAmount,
      feePaymentDetailsId: feePaymentDetailsId ?? this.feePaymentDetailsId,
      taxId: taxId ?? this.taxId,
      taxName: taxName ?? this.taxName,
      taxAmt: taxAmt ?? this.taxAmt,
      floodCess: floodCess ?? this.floodCess,
      narration: narration ?? this.narration,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      accYear: json["AccYear"] ?? "",
      feeMonthId: json["FeeMonthId"] ?? "",
      feeMonth: json["FeeMonth"] ?? "",
      ledgerId: json["LedgerId"] ?? "",
      ledgerName: json["LedgerName"] ?? "",
      amount: json["Amount"] ?? "",
      paidAmount: json["PaidAmount"] ?? "",
      feePaymentDetailsId: json["FeePaymentDetailsId"] ?? "",
      taxId: json["taxId"],
      taxName: json["taxName"],
      taxAmt: json["TaxAmt"] ?? "",
      floodCess: json["FloodCess"] ?? "",
      narration: json["Narration"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "AccYear": accYear,
    "FeeMonthId": feeMonthId,
    "FeeMonth": feeMonth,
    "LedgerId": ledgerId,
    "LedgerName": ledgerName,
    "Amount": amount,
    "PaidAmount": paidAmount,
    "FeePaymentDetailsId": feePaymentDetailsId,
    "taxId": taxId,
    "taxName": taxName,
    "TaxAmt": taxAmt,
    "FloodCess": floodCess,
    "Narration": narration,
  };

  @override
  String toString(){
    return "$accYear, $feeMonthId, $feeMonth, $ledgerId, $ledgerName, $amount, $paidAmount, $feePaymentDetailsId, $taxId, $taxName, $taxAmt, $floodCess, $narration, ";
  }

  @override
  List<Object?> get props => [
    accYear, feeMonthId, feeMonth, ledgerId, ledgerName, amount, paidAmount, feePaymentDetailsId, taxId, taxName, taxAmt, floodCess, narration, ];
}
