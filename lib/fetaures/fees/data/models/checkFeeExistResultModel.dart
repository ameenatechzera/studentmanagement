import 'package:studentmanagement/fetaures/fees/domain/entities/feeExistCheckResult.dart';

class CheckFeeExistResultModel extends FeePaymentExistResult{
  CheckFeeExistResultModel({required super.status, required super.error, required super.message, required super.data});


  factory CheckFeeExistResultModel.fromJson(Map<String, dynamic> json){
    return CheckFeeExistResultModel(
      status: json["status"] ?? false,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}