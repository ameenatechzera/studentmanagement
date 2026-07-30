import 'package:equatable/equatable.dart';

class OfflineFeePayRequest extends Equatable {
  OfflineFeePayRequest({
    required this.admissionId,
    required this.admno,
    required this.accyear,
    required this.date,
    required this.totalamount,
    required this.paidamount,
    required this.transactionid,
    required this.status,
    required this.response,
    required this.details,
  });



  final int admissionId;
  static const String admissionIdKey = "admissionId";

  final String admno;
  static const String admnoKey = "admno";

  final String accyear;
  static const String accyearKey = "accyear";

  final String? date;
  static const String dateKey = "date";

  final String totalamount;
  static const String totalamountKey = "totalamount";

  final String paidamount;
  static const String paidamountKey = "paidamount";

  final String transactionid;
  static const String transactionidKey = "transactionid";

  final String status;
  static const String statusKey = "status";

  final String response;
  static const String responseKey = "response";

  final List<OfflineDetail> details;
  static const String detailsKey = "details";


  OfflineFeePayRequest copyWith({
    String? admno,
    int? admissionId,
    String? accyear,
    String? date,
    String? totalamount,
    String? paidamount,
    String? transactionid,
    String? status,
    String? response,
    List<OfflineDetail>? details,
  }) {
    return OfflineFeePayRequest(
      admissionId : admissionId ?? this.admissionId,
      admno: admno ?? this.admno,
      accyear: accyear ?? this.accyear,
      date: date ?? this.date,
      totalamount: totalamount ?? this.totalamount,
      paidamount: paidamount ?? this.paidamount,
      transactionid: transactionid ?? this.transactionid,
      status: status ?? this.status,
      response: response ?? this.response,
      details: details ?? this.details,
    );
  }


  Map<String, dynamic> toJson() => {
    "createduser":admissionId,
    "admno": admno,
    "accyear": accyear,
    "date": date,
    "totalamount": totalamount,
    "paidamount": paidamount,
    "transactionid": transactionid,
    "status": status,
    "response": response,
    "details": details.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return " $admissionId,$admno, $accyear, $date, $totalamount, $paidamount, $transactionid, $status, $response, $details, ";
  }

  @override
  List<Object?> get props => [
    admissionId,admno, accyear, date, totalamount, paidamount, transactionid, status, response, details, ];
}

class OfflineDetail extends Equatable {
  OfflineDetail({
    required this.feemonthid,
    required this.feemonth,
    required this.ledgerid,
    required this.ledgername,
    required this.dueamount,
    required this.paidamount,
  });

  final String feemonthid;
  static const String feemonthidKey = "feemonthid";

  final String feemonth;
  static const String feemonthKey = "feemonth";

  final int ledgerid;
  static const String ledgeridKey = "ledgerid";

  final String ledgername;
  static const String ledgernameKey = "ledgername";

  final String dueamount;
  static const String dueamountKey = "dueamount";

  final String paidamount;
  static const String paidamountKey = "paidamount";


  OfflineDetail copyWith({
    String? feemonthid,
    String? feemonth,
    int? ledgerid,
    String? ledgername,
    String? dueamount,
    String? paidamount,
  }) {
    return OfflineDetail(
      feemonthid: feemonthid ?? this.feemonthid,
      feemonth: feemonth ?? this.feemonth,
      ledgerid: ledgerid ?? this.ledgerid,
      ledgername: ledgername ?? this.ledgername,
      dueamount: dueamount ?? this.dueamount,
      paidamount: paidamount ?? this.paidamount,
    );
  }

  factory OfflineDetail.fromJson(Map<String, dynamic> json){
    return OfflineDetail(
      feemonthid: json["feemonthid"] ?? 0,
      feemonth: json["feemonth"] ?? "",
      ledgerid: json["ledgerid"] ?? 0,
      ledgername: json["ledgername"] ?? "",
      dueamount: json["dueamount"] ?? 0,
      paidamount: json["paidamount"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "feemonthid": feemonthid,
    "feemonth": feemonth,
    "ledgerid": ledgerid,
    "ledgername": ledgername,
    "dueamount": dueamount,
    "paidamount": paidamount,
  };

  @override
  String toString(){
    return "$feemonthid, $feemonth, $ledgerid, $ledgername, $dueamount, $paidamount, ";
  }

  @override
  List<Object?> get props => [
    feemonthid, feemonth, ledgerid, ledgername, dueamount, paidamount, ];
}
