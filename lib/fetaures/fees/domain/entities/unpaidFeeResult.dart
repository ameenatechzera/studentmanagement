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
    required this.ledgerName,
  });

  final String admno;
  static const String admnoKey = "Admno";

  final String accYear;
  static const String accYearKey = "AccYear";

  final String ledgerName;
  static const String ledgerNameKey = "LedgerName";


  Datum copyWith({
    String? admno,
    String? accYear,
    String? ledgerName,
  }) {
    return Datum(
      admno: admno ?? this.admno,
      accYear: accYear ?? this.accYear,
      ledgerName: ledgerName ?? this.ledgerName,
    );
  }

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      admno: json["Admno"] ?? "",
      accYear: json["AccYear"] ?? "",
      ledgerName: json["LedgerName"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "Admno": admno,
    "AccYear": accYear,
    "LedgerName": ledgerName,
  };

  @override
  String toString(){
    return "$admno, $accYear, $ledgerName, ";
  }

  @override
  List<Object?> get props => [
    admno, accYear, ledgerName, ];
}
