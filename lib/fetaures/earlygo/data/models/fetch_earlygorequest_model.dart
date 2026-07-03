import 'package:studentmanagement/fetaures/earlygo/domain/entities/fetch_earlygorequest_entity.dart';

class FetchEarlyLeaveResponseModel extends FetchEarlyLeaveResponse {
  FetchEarlyLeaveResponseModel({required super.status, required super.message, required super.error, required super.data});

  factory FetchEarlyLeaveResponseModel.fromJson(Map<String, dynamic> json){
    return FetchEarlyLeaveResponseModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      error: json["error"] ?? false,
      data: json["data"] == null ? [] : List<EarlygoList>.from(json["data"]!.map((x) => EarlygoList.fromJson(x))),
    );
  }

}
