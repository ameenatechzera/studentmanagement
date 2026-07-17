import '../../domain/entities/login_status_entity.dart';

class LoginStatusModel extends LoginStatusEntity {
  const LoginStatusModel({
    required super.status,
    required super.message,
    required super.time,
  });

  factory LoginStatusModel.fromJson(Map<String, dynamic> json) {
    return LoginStatusModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'time': time};
  }
}
