import 'package:studentmanagement/fetaures/fees/domain/entities/paid_fee_result.dart';

class PaidFeeModel extends PaidFeeResult {
  PaidFeeModel({
    required super.status,
    required super.message,
    required super.data,
  });

  factory PaidFeeModel.fromJson(Map<String, dynamic> json) {
    return PaidFeeModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}
