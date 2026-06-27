import 'package:equatable/equatable.dart';

class FeeSaveRequest extends Equatable {
  FeeSaveRequest({
    required this.voucherNo,
    required this.invoiceNo,
    required this.suffixPrefixId,
    required this.date,
    required this.admno,
    required this.accYear,
    required this.ledgerId,
    required this.totalAmount,
    required this.paidAmount,
    required this.balance,
    required this.discount,
    required this.totalTax,
    required this.totalFloodCess,
    required this.status,
    required this.narration,
    required this.financialYearId,
    required this.canceled,
    required this.branchId,
    required this.voucherType,
    required this.yearId,
    required this.createdUser,
    required this.details,
  });

  final int voucherNo;
  static const String voucherNoKey = "VoucherNo";

  final int invoiceNo;
  static const String invoiceNoKey = "InvoiceNo";

  final String suffixPrefixId;
  static const String suffixPrefixIdKey = "suffixPrefixId";

  final String? date;
  static const String dateKey = "Date";

  final String admno;
  static const String admnoKey = "Admno";

  final String accYear;
  static const String accYearKey = "AccYear";

  final int ledgerId;
  static const String ledgerIdKey = "LedgerId";

  final double totalAmount;
  static const String totalAmountKey = "TotalAmount";

  final double paidAmount;
  static const String paidAmountKey = "PaidAmount";

  final int balance;
  static const String balanceKey = "Balance";

  final int discount;
  static const String discountKey = "Discount";

  final int totalTax;
  static const String totalTaxKey = "totalTax";

  final int totalFloodCess;
  static const String totalFloodCessKey = "totalFloodCess";

  final bool status;
  static const String statusKey = "status";

  final String narration;
  static const String narrationKey = "Narration";

  final String financialYearId;
  static const String financialYearIdKey = "FinancialYearId";

  final bool canceled;
  static const String canceledKey = "Canceled";

  final int branchId;
  static const String branchIdKey = "branchId";

  final String voucherType;
  static const String voucherTypeKey = "voucherType";

  final String yearId;
  static const String yearIdKey = "yearId";

  final String createdUser;
  static const String createdUserKey = "CreatedUser";

  final List<saveFeeDetails> details;
  static const String detailsKey = "details";


  FeeSaveRequest copyWith({
    int? voucherNo,
    int? invoiceNo,
    String? suffixPrefixId,
    String? date,
    String? admno,
    String? accYear,
    int? ledgerId,
    double? totalAmount,
    double? paidAmount,
    int? balance,
    int? discount,
    int? totalTax,
    int? totalFloodCess,
    bool? status,
    String? narration,
    String? financialYearId,
    bool? canceled,
    int? branchId,
    String? voucherType,
    String? yearId,
    String? createdUser,
    List<saveFeeDetails>? details,
  }) {
    return FeeSaveRequest(
      voucherNo: voucherNo ?? this.voucherNo,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      suffixPrefixId: suffixPrefixId ?? this.suffixPrefixId,
      date: date ?? this.date,
      admno: admno ?? this.admno,
      accYear: accYear ?? this.accYear,
      ledgerId: ledgerId ?? this.ledgerId,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      balance: balance ?? this.balance,
      discount: discount ?? this.discount,
      totalTax: totalTax ?? this.totalTax,
      totalFloodCess: totalFloodCess ?? this.totalFloodCess,
      status: status ?? this.status,
      narration: narration ?? this.narration,
      financialYearId: financialYearId ?? this.financialYearId,
      canceled: canceled ?? this.canceled,
      branchId: branchId ?? this.branchId,
      voucherType: voucherType ?? this.voucherType,
      yearId: yearId ?? this.yearId,
      createdUser: createdUser ?? this.createdUser,
      details: details ?? this.details,
    );
  }

  factory FeeSaveRequest.fromJson(Map<String, dynamic> json){
    return FeeSaveRequest(
      voucherNo: json["VoucherNo"] ?? 0,
      invoiceNo: json["InvoiceNo"] ?? 0,
      suffixPrefixId: json["suffixPrefixId"] ?? "",
      date: json["Date"] ?? "",
      admno: json["Admno"] ?? "",
      accYear: json["AccYear"] ?? "",
      ledgerId: json["LedgerId"] ?? 0,
      totalAmount: json["TotalAmount"] ?? 0,
      paidAmount: json["PaidAmount"] ?? 0,
      balance: json["Balance"] ?? 0,
      discount: json["Discount"] ?? 0,
      totalTax: json["totalTax"] ?? 0,
      totalFloodCess: json["totalFloodCess"] ?? 0,
      status: json["status"] ?? false,
      narration: json["Narration"] ?? "",
      financialYearId: json["FinancialYearId"] ?? "",
      canceled: json["Canceled"] ?? false,
      branchId: json["branchId"] ?? 0,
      voucherType: json["voucherType"] ?? "",
      yearId: json["yearId"] ?? "",
      createdUser: json["CreatedUser"] ?? "",
      details: json["details"] == null ? [] : List<saveFeeDetails>.from(json["details"]!.map((x) => saveFeeDetails.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "VoucherNo": voucherNo,
    "InvoiceNo": invoiceNo,
    "suffixPrefixId": suffixPrefixId,
    "Date": date,
    "Admno": admno,
    "AccYear": accYear,
    "LedgerId": ledgerId,
    "TotalAmount": totalAmount,
    "PaidAmount": paidAmount,
    "Balance": balance,
    "Discount": discount,
    "totalTax": totalTax,
    "totalFloodCess": totalFloodCess,
    "status": status,
    "Narration": narration,
    "FinancialYearId": financialYearId,
    "Canceled": canceled,
    "branchId": branchId,
    "voucherType": voucherType,
    "yearId": yearId,
    "CreatedUser": createdUser,
    "details": details.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$voucherNo, $invoiceNo, $suffixPrefixId, $date, $admno, $accYear, $ledgerId, $totalAmount, $paidAmount, $balance, $discount, $totalTax, $totalFloodCess, $status, $narration, $financialYearId, $canceled, $branchId, $voucherType, $yearId, $createdUser, $details, ";
  }

  @override
  List<Object?> get props => [
    voucherNo, invoiceNo, suffixPrefixId, date, admno, accYear, ledgerId, totalAmount, paidAmount, balance, discount, totalTax, totalFloodCess, status, narration, financialYearId, canceled, branchId, voucherType, yearId, createdUser, details, ];
}

class saveFeeDetails extends Equatable {
  saveFeeDetails({
    required this.feeMonthId,
    required this.ledgerId,
    required this.dueAmount,
    required this.paidAmount,
    required this.paidStatus,
    required this.chequeNo,
    required this.chequeDate,
    required this.userId,
    required this.feeAmount,
    required this.taxId,
    required this.taxType,
    required this.taxAmount,
    required this.floodCess,
  });

  final String feeMonthId;
  static const String feeMonthIdKey = "FeeMonthId";

  final dynamic ledgerId;
  static const String ledgerIdKey = "LedgerId";

  final int dueAmount;
  static const String dueAmountKey = "DueAmount";

  final int paidAmount;
  static const String paidAmountKey = "PaidAmount";

  final bool paidStatus;
  static const String paidStatusKey = "PaidStatus";

  final dynamic chequeNo;
  static const String chequeNoKey = "ChequeNo";

  final String? chequeDate;
  static const String chequeDateKey = "ChequeDate";

  final String userId;
  static const String userIdKey = "UserId";

  final int feeAmount;
  static const String feeAmountKey = "FeeAmount";

  final String taxId;
  static const String taxIdKey = "taxId";

  final String taxType;
  static const String taxTypeKey = "taxType";

  final int taxAmount;
  static const String taxAmountKey = "taxAmount";

  final int floodCess;
  static const String floodCessKey = "FloodCess";


  saveFeeDetails copyWith({
    String? feeMonthId,
    dynamic? ledgerId,
    int? dueAmount,
    int? paidAmount,
    bool? paidStatus,
    dynamic? chequeNo,
    String? chequeDate,
    String? userId,
    int? feeAmount,
    String? taxId,
    String? taxType,
    int? taxAmount,
    int? floodCess,
  }) {
    return saveFeeDetails(
      feeMonthId: feeMonthId ?? this.feeMonthId,
      ledgerId: ledgerId ?? this.ledgerId,
      dueAmount: dueAmount ?? this.dueAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      paidStatus: paidStatus ?? this.paidStatus,
      chequeNo: chequeNo ?? this.chequeNo,
      chequeDate: chequeDate ?? this.chequeDate,
      userId: userId ?? this.userId,
      feeAmount: feeAmount ?? this.feeAmount,
      taxId: taxId ?? this.taxId,
      taxType: taxType ?? this.taxType,
      taxAmount: taxAmount ?? this.taxAmount,
      floodCess: floodCess ?? this.floodCess,
    );
  }

  factory saveFeeDetails.fromJson(Map<String, dynamic> json){
    return saveFeeDetails(
      feeMonthId: json["FeeMonthId"] ?? "",
      ledgerId: json["LedgerId"],
      dueAmount: json["DueAmount"] ?? 0,
      paidAmount: json["PaidAmount"] ?? 0,
      paidStatus: json["PaidStatus"] ?? false,
      chequeNo: json["ChequeNo"],
      chequeDate: json["ChequeDate"] ?? "",
      userId: json["UserId"] ?? "",
      feeAmount: json["FeeAmount"] ?? 0,
      taxId: json["taxId"] ?? "",
      taxType: json["taxType"] ?? "",
      taxAmount: json["taxAmount"] ?? 0,
      floodCess: json["FloodCess"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "FeeMonthId": feeMonthId,
    "LedgerId": ledgerId,
    "DueAmount": dueAmount,
    "PaidAmount": paidAmount,
    "PaidStatus": paidStatus,
    "ChequeNo": chequeNo,
    "ChequeDate": chequeDate,
    "UserId": userId,
    "FeeAmount": feeAmount,
    "taxId": taxId,
    "taxType": taxType,
    "taxAmount": taxAmount,
    "FloodCess": floodCess,
  };

  @override
  String toString(){
    return "$feeMonthId, $ledgerId, $dueAmount, $paidAmount, $paidStatus, $chequeNo, $chequeDate, $userId, $feeAmount, $taxId, $taxType, $taxAmount, $floodCess, ";
  }

  @override
  List<Object?> get props => [
    feeMonthId, ledgerId, dueAmount, paidAmount, paidStatus, chequeNo, chequeDate, userId, feeAmount, taxId, taxType, taxAmount, floodCess, ];
}
