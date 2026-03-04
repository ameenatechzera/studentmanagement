import 'package:studentmanagement/fetaures/fees/domain/entities/paidFeeResult.dart';

class PaidFeeModel extends PaidFeeResult{
  PaidFeeModel({required super.status, required super.error, required super.data});
  factory PaidFeeModel.fromJson(Map<String, dynamic> json){
    return PaidFeeModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}