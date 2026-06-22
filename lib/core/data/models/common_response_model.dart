import '../../domain/entities/common_response_entity.dart';

class CommonResponseModel extends CommonResponseEntity {
  CommonResponseModel({super.status, super.error, super.message});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      status: json['status'],
      error: json['error'],
      message: json['message'],
    );
  }
}
