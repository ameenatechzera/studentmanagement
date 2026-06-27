import 'package:equatable/equatable.dart';

class FeeSaveResult extends Equatable {
  FeeSaveResult({
    required this.status,
    required this.error,
    required this.message,
  });

  final int status;
  static const String statusKey = "status";

  final bool error;
  static const String errorKey = "error";

  final String message;
  static const String messageKey = "message";


  FeeSaveResult copyWith({
    int? status,
    bool? error,
    String? message,
  }) {
    return FeeSaveResult(
      status: status ?? this.status,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  factory FeeSaveResult.fromJson(Map<String, dynamic> json){
    return FeeSaveResult(
      status: json["status"] ?? 0,
      error: json["error"] ?? false,
      message: json["message"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": message,
  };

  @override
  String toString(){
    return "$status, $error, $message, ";
  }

  @override
  List<Object?> get props => [
    status, error, message, ];
}
