import 'package:studentmanagement/fetaures/fees/domain/entities/paymentGatewayDetails.dart';

class FeePaymentGatewayDetailsModel  extends FeePaymentGatewayDetails{
  FeePaymentGatewayDetailsModel({required super.status, required super.error, required super.message, required super.data});

  factory FeePaymentGatewayDetailsModel.fromJson(Map<String, dynamic> json){
    return FeePaymentGatewayDetailsModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}