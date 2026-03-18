import 'package:studentmanagement/fetaures/fees/domain/entities/unpaidFeeResult.dart';

class UnPaidFeeModel extends UnpaidFeeResult{
  UnPaidFeeModel({required super.status, required super.error, required super.data});

  factory UnPaidFeeModel.fromJson(Map<String, dynamic> json){
    return UnPaidFeeModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}