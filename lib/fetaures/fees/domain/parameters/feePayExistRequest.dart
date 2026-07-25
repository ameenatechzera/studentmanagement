import 'package:equatable/equatable.dart';

class FeePaymentExistRequest extends Equatable {
  FeePaymentExistRequest({
    required this.admno,
    required this.accyear,
    required this.feemonths,
  });

  final String admno;
  static const String admnoKey = "admno";

  final String accyear;
  static const String accyearKey = "accyear";

  final List<Feemonth> feemonths;
  static const String feemonthsKey = "feemonths";


  FeePaymentExistRequest copyWith({
    String? admno,
    String? accyear,
    List<Feemonth>? feemonths,
  }) {
    return FeePaymentExistRequest(
      admno: admno ?? this.admno,
      accyear: accyear ?? this.accyear,
      feemonths: feemonths ?? this.feemonths,
    );
  }

  factory FeePaymentExistRequest.fromJson(Map<String, dynamic> json){
    return FeePaymentExistRequest(
      admno: json["admno"] ?? "",
      accyear: json["accyear"] ?? "",
      feemonths: json["feemonths"] == null ? [] : List<Feemonth>.from(json["feemonths"]!.map((x) => Feemonth.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "admno": admno,
    "accyear": accyear,
    "feemonths": feemonths.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$admno, $accyear, $feemonths, ";
  }

  @override
  List<Object?> get props => [
    admno, accyear, feemonths, ];
}

class Feemonth extends Equatable {
  Feemonth({
    required this.feemonthid,
    required this.ledgers,
  });

  final int feemonthid;
  static const String feemonthidKey = "feemonthid";

  final List<Ledger> ledgers;
  static const String ledgersKey = "ledgers";


  Feemonth copyWith({
    int? feemonthid,
    List<Ledger>? ledgers,
  }) {
    return Feemonth(
      feemonthid: feemonthid ?? this.feemonthid,
      ledgers: ledgers ?? this.ledgers,
    );
  }

  factory Feemonth.fromJson(Map<String, dynamic> json){
    return Feemonth(
      feemonthid: json["feemonthid"] ?? 0,
      ledgers: json["ledgers"] == null ? [] : List<Ledger>.from(json["ledgers"]!.map((x) => Ledger.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "feemonthid": feemonthid,
    "ledgers": ledgers.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$feemonthid, $ledgers, ";
  }

  @override
  List<Object?> get props => [
    feemonthid, ledgers, ];
}

class Ledger extends Equatable {
  Ledger({
    required this.ledgerid,
    required this.paidamount,
  });

  final int ledgerid;
  static const String ledgeridKey = "ledgerid";

  final int paidamount;
  static const String paidamountKey = "paidamount";


  Ledger copyWith({
    int? ledgerid,
    int? paidamount,
  }) {
    return Ledger(
      ledgerid: ledgerid ?? this.ledgerid,
      paidamount: paidamount ?? this.paidamount,
    );
  }

  factory Ledger.fromJson(Map<String, dynamic> json){
    return Ledger(
      ledgerid: json["ledgerid"] ?? 0,
      paidamount: json["paidamount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "ledgerid": ledgerid,
    "paidamount": paidamount,
  };

  @override
  String toString(){
    return "$ledgerid, $paidamount, ";
  }

  @override
  List<Object?> get props => [
    ledgerid, paidamount, ];
}
