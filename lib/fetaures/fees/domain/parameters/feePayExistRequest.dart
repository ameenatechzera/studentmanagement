import 'package:equatable/equatable.dart';

class FeePaymentExistRequest extends Equatable {
  FeePaymentExistRequest({
    required this.admno,
    required this.feemonthId,
    required this.ledgerId,
    required this.paidamount,
    required this.accyear,
  });

  final String admno;
  static const String admnoKey = "admno";

  final int feemonthId;
  static const String feemonthIdKey = "feemonthId";

  final int ledgerId;
  static const String ledgerIdKey = "ledgerId";

  final int paidamount;
  static const String paidamountKey = "paidamount";

  final String accyear;
  static const String accyearKey = "accyear";


  FeePaymentExistRequest copyWith({
    String? admno,
    int? feemonthId,
    int? ledgerId,
    int? paidamount,
    String? accyear,
  }) {
    return FeePaymentExistRequest(
      admno: admno ?? this.admno,
      feemonthId: feemonthId ?? this.feemonthId,
      ledgerId: ledgerId ?? this.ledgerId,
      paidamount: paidamount ?? this.paidamount,
      accyear: accyear ?? this.accyear,
    );
  }

  Map<String, dynamic> toJson() => {
    "admno": admno,
    "feemonthId": feemonthId,
    "ledgerId": ledgerId,
    "paidamount": paidamount,
    "accyear": accyear,
  };

  @override
  String toString(){
    return "$admno, $feemonthId, $ledgerId, $paidamount, $accyear, ";
  }

  @override
  List<Object?> get props => [
    admno, feemonthId, ledgerId, paidamount, accyear, ];
}
