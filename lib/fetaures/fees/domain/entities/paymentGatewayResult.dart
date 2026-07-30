import 'package:equatable/equatable.dart';

class GatewayPaymentResult extends Equatable {
  GatewayPaymentResult({
    required this.result,
    required this.paymentResponse,
  });

  final String result;
  static const String resultKey = "result";

  final PaymentResponse? paymentResponse;
  static const String paymentResponseKey = "payment_response";


  GatewayPaymentResult copyWith({
    String? result,
    PaymentResponse? paymentResponse,
  }) {
    return GatewayPaymentResult(
      result: result ?? this.result,
      paymentResponse: paymentResponse ?? this.paymentResponse,
    );
  }

  factory GatewayPaymentResult.fromJson(Map<String, dynamic> json){
    return GatewayPaymentResult(
      result: json["result"] ?? "",
      paymentResponse: json["payment_response"] == null ? null : PaymentResponse.fromJson(json["payment_response"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "result": result,
    "payment_response": paymentResponse?.toJson(),
  };

  @override
  String toString(){
    return "$result, $paymentResponse, ";
  }

  @override
  List<Object?> get props => [
    result, paymentResponse, ];
}

class PaymentResponse extends Equatable {
  PaymentResponse({
    required this.firstname,
    required this.merchantLogo,
    required this.cardCategory,
    required this.udf10,
    required this.error,
    required this.addedon,
    required this.mode,
    required this.udf9,
    required this.udf7,
    required this.cashBackPercentage,
    required this.issuingBank,
    required this.udf8,
    required this.deductionPercentage,
    required this.bankName,
    required this.errorMessage,
    required this.paymentSource,
    required this.bankRefNum,
    required this.upiVa,
    required this.bankcode,
    required this.email,
    required this.key,
    required this.txnid,
    required this.authRefNum,
    required this.amount,
    required this.unmappedstatus,
    required this.easepayid,
    required this.udf5,
    required this.udf6,
    required this.surl,
    required this.udf3,
    required this.netAmountDebit,
    required this.udf4,
    required this.cardType,
    required this.udf1,
    required this.cancellationReason,
    required this.udf2,
    required this.authCode,
    required this.cardnum,
    required this.phone,
    required this.furl,
    required this.productinfo,
    required this.pgType,
    required this.hash,
    required this.nameOnCard,
    required this.status,
  });

  final String firstname;
  static const String firstnameKey = "firstname";

  final String merchantLogo;
  static const String merchantLogoKey = "merchant_logo";

  final String cardCategory;
  static const String cardCategoryKey = "cardCategory";

  final String udf10;
  static const String udf10Key = "udf10";

  final String error;
  static const String errorKey = "error";

  final DateTime? addedon;
  static const String addedonKey = "addedon";

  final String mode;
  static const String modeKey = "mode";

  final String udf9;
  static const String udf9Key = "udf9";

  final String udf7;
  static const String udf7Key = "udf7";

  final int cashBackPercentage;
  static const String cashBackPercentageKey = "cash_back_percentage";

  final String issuingBank;
  static const String issuingBankKey = "issuing_bank";

  final String udf8;
  static const String udf8Key = "udf8";

  final int deductionPercentage;
  static const String deductionPercentageKey = "deduction_percentage";

  final String bankName;
  static const String bankNameKey = "bank_name";

  final String errorMessage;
  static const String errorMessageKey = "error_Message";

  final String paymentSource;
  static const String paymentSourceKey = "payment_source";

  final String bankRefNum;
  static const String bankRefNumKey = "bank_ref_num";

  final String upiVa;
  static const String upiVaKey = "upi_va";

  final String bankcode;
  static const String bankcodeKey = "bankcode";

  final String email;
  static const String emailKey = "email";

  final String key;
  static const String keyKey = "key";

  final String txnid;
  static const String txnidKey = "txnid";

  final String authRefNum;
  static const String authRefNumKey = "auth_ref_num";

  final int amount;
  static const String amountKey = "amount";

  final String unmappedstatus;
  static const String unmappedstatusKey = "unmappedstatus";

  final String easepayid;
  static const String easepayidKey = "easepayid";

  final String udf5;
  static const String udf5Key = "udf5";

  final String udf6;
  static const String udf6Key = "udf6";

  final String surl;
  static const String surlKey = "surl";

  final String udf3;
  static const String udf3Key = "udf3";

  final int netAmountDebit;
  static const String netAmountDebitKey = "net_amount_debit";

  final String udf4;
  static const String udf4Key = "udf4";

  final String cardType;
  static const String cardTypeKey = "card_type";

  final String udf1;
  static const String udf1Key = "udf1";

  final String cancellationReason;
  static const String cancellationReasonKey = "cancellation_reason";

  final String udf2;
  static const String udf2Key = "udf2";

  final String authCode;
  static const String authCodeKey = "auth_code";

  final String cardnum;
  static const String cardnumKey = "cardnum";

  final String phone;
  static const String phoneKey = "phone";

  final String furl;
  static const String furlKey = "furl";

  final String productinfo;
  static const String productinfoKey = "productinfo";

  final String pgType;
  static const String pgTypeKey = "PG_TYPE";

  final String hash;
  static const String hashKey = "hash";

  final String nameOnCard;
  static const String nameOnCardKey = "name_on_card";

  final String status;
  static const String statusKey = "status";


  PaymentResponse copyWith({
    String? firstname,
    String? merchantLogo,
    String? cardCategory,
    String? udf10,
    String? error,
    DateTime? addedon,
    String? mode,
    String? udf9,
    String? udf7,
    int? cashBackPercentage,
    String? issuingBank,
    String? udf8,
    int? deductionPercentage,
    String? bankName,
    String? errorMessage,
    String? paymentSource,
    String? bankRefNum,
    String? upiVa,
    String? bankcode,
    String? email,
    String? key,
    String? txnid,
    String? authRefNum,
    int? amount,
    String? unmappedstatus,
    String? easepayid,
    String? udf5,
    String? udf6,
    String? surl,
    String? udf3,
    int? netAmountDebit,
    String? udf4,
    String? cardType,
    String? udf1,
    String? cancellationReason,
    String? udf2,
    String? authCode,
    String? cardnum,
    String? phone,
    String? furl,
    String? productinfo,
    String? pgType,
    String? hash,
    String? nameOnCard,
    String? status,
  }) {
    return PaymentResponse(
      firstname: firstname ?? this.firstname,
      merchantLogo: merchantLogo ?? this.merchantLogo,
      cardCategory: cardCategory ?? this.cardCategory,
      udf10: udf10 ?? this.udf10,
      error: error ?? this.error,
      addedon: addedon ?? this.addedon,
      mode: mode ?? this.mode,
      udf9: udf9 ?? this.udf9,
      udf7: udf7 ?? this.udf7,
      cashBackPercentage: cashBackPercentage ?? this.cashBackPercentage,
      issuingBank: issuingBank ?? this.issuingBank,
      udf8: udf8 ?? this.udf8,
      deductionPercentage: deductionPercentage ?? this.deductionPercentage,
      bankName: bankName ?? this.bankName,
      errorMessage: errorMessage ?? this.errorMessage,
      paymentSource: paymentSource ?? this.paymentSource,
      bankRefNum: bankRefNum ?? this.bankRefNum,
      upiVa: upiVa ?? this.upiVa,
      bankcode: bankcode ?? this.bankcode,
      email: email ?? this.email,
      key: key ?? this.key,
      txnid: txnid ?? this.txnid,
      authRefNum: authRefNum ?? this.authRefNum,
      amount: amount ?? this.amount,
      unmappedstatus: unmappedstatus ?? this.unmappedstatus,
      easepayid: easepayid ?? this.easepayid,
      udf5: udf5 ?? this.udf5,
      udf6: udf6 ?? this.udf6,
      surl: surl ?? this.surl,
      udf3: udf3 ?? this.udf3,
      netAmountDebit: netAmountDebit ?? this.netAmountDebit,
      udf4: udf4 ?? this.udf4,
      cardType: cardType ?? this.cardType,
      udf1: udf1 ?? this.udf1,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      udf2: udf2 ?? this.udf2,
      authCode: authCode ?? this.authCode,
      cardnum: cardnum ?? this.cardnum,
      phone: phone ?? this.phone,
      furl: furl ?? this.furl,
      productinfo: productinfo ?? this.productinfo,
      pgType: pgType ?? this.pgType,
      hash: hash ?? this.hash,
      nameOnCard: nameOnCard ?? this.nameOnCard,
      status: status ?? this.status,
    );
  }

  factory PaymentResponse.fromJson(Map<String, dynamic> json){
    return PaymentResponse(
      firstname: json["firstname"] ?? "",
      merchantLogo: json["merchant_logo"] ?? "",
      cardCategory: json["cardCategory"] ?? "",
      udf10: json["udf10"] ?? "",
      error: json["error"] ?? "",
      addedon: DateTime.tryParse(json["addedon"] ?? ""),
      mode: json["mode"] ?? "",
      udf9: json["udf9"] ?? "",
      udf7: json["udf7"] ?? "",
      cashBackPercentage: json["cash_back_percentage"] ?? 0,
      issuingBank: json["issuing_bank"] ?? "",
      udf8: json["udf8"] ?? "",
      deductionPercentage: json["deduction_percentage"] ?? 0,
      bankName: json["bank_name"] ?? "",
      errorMessage: json["error_Message"] ?? "",
      paymentSource: json["payment_source"] ?? "",
      bankRefNum: json["bank_ref_num"] ?? "",
      upiVa: json["upi_va"] ?? "",
      bankcode: json["bankcode"] ?? "",
      email: json["email"] ?? "",
      key: json["key"] ?? "",
      txnid: json["txnid"] ?? "",
      authRefNum: json["auth_ref_num"] ?? "",
      amount: json["amount"] ?? 0,
      unmappedstatus: json["unmappedstatus"] ?? "",
      easepayid: json["easepayid"] ?? "",
      udf5: json["udf5"] ?? "",
      udf6: json["udf6"] ?? "",
      surl: json["surl"] ?? "",
      udf3: json["udf3"] ?? "",
      netAmountDebit: json["net_amount_debit"] ?? 0,
      udf4: json["udf4"] ?? "",
      cardType: json["card_type"] ?? "",
      udf1: json["udf1"] ?? "",
      cancellationReason: json["cancellation_reason"] ?? "",
      udf2: json["udf2"] ?? "",
      authCode: json["auth_code"] ?? "",
      cardnum: json["cardnum"] ?? "",
      phone: json["phone"] ?? "",
      furl: json["furl"] ?? "",
      productinfo: json["productinfo"] ?? "",
      pgType: json["PG_TYPE"] ?? "",
      hash: json["hash"] ?? "",
      nameOnCard: json["name_on_card"] ?? "",
      status: json["status"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "merchant_logo": merchantLogo,
    "cardCategory": cardCategory,
    "udf10": udf10,
    "error": error,
    "addedon": addedon?.toIso8601String(),
    "mode": mode,
    "udf9": udf9,
    "udf7": udf7,
    "cash_back_percentage": cashBackPercentage,
    "issuing_bank": issuingBank,
    "udf8": udf8,
    "deduction_percentage": deductionPercentage,
    "bank_name": bankName,
    "error_Message": errorMessage,
    "payment_source": paymentSource,
    "bank_ref_num": bankRefNum,
    "upi_va": upiVa,
    "bankcode": bankcode,
    "email": email,
    "key": key,
    "txnid": txnid,
    "auth_ref_num": authRefNum,
    "amount": amount,
    "unmappedstatus": unmappedstatus,
    "easepayid": easepayid,
    "udf5": udf5,
    "udf6": udf6,
    "surl": surl,
    "udf3": udf3,
    "net_amount_debit": netAmountDebit,
    "udf4": udf4,
    "card_type": cardType,
    "udf1": udf1,
    "cancellation_reason": cancellationReason,
    "udf2": udf2,
    "auth_code": authCode,
    "cardnum": cardnum,
    "phone": phone,
    "furl": furl,
    "productinfo": productinfo,
    "PG_TYPE": pgType,
    "hash": hash,
    "name_on_card": nameOnCard,
    "status": status,
  };

  @override
  String toString(){
    return "$firstname, $merchantLogo, $cardCategory, $udf10, $error, $addedon, $mode, $udf9, $udf7, $cashBackPercentage, $issuingBank, $udf8, $deductionPercentage, $bankName, $errorMessage, $paymentSource, $bankRefNum, $upiVa, $bankcode, $email, $key, $txnid, $authRefNum, $amount, $unmappedstatus, $easepayid, $udf5, $udf6, $surl, $udf3, $netAmountDebit, $udf4, $cardType, $udf1, $cancellationReason, $udf2, $authCode, $cardnum, $phone, $furl, $productinfo, $pgType, $hash, $nameOnCard, $status, ";
  }

  @override
  List<Object?> get props => [
    firstname, merchantLogo, cardCategory, udf10, error, addedon, mode, udf9, udf7, cashBackPercentage, issuingBank, udf8, deductionPercentage, bankName, errorMessage, paymentSource, bankRefNum, upiVa, bankcode, email, key, txnid, authRefNum, amount, unmappedstatus, easepayid, udf5, udf6, surl, udf3, netAmountDebit, udf4, cardType, udf1, cancellationReason, udf2, authCode, cardnum, phone, furl, productinfo, pgType, hash, nameOnCard, status, ];
}
