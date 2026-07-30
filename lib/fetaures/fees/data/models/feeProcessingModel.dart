import 'package:studentmanagement/fetaures/fees/domain/entities/feeProcessingResult.dart';

class FeeProcessingModel extends FeeProcessingResult{
  FeeProcessingModel({required super.status, required super.error, required super.message, required super.data});

  factory FeeProcessingModel.fromJson(Map<String, dynamic> json){
    return FeeProcessingModel(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}