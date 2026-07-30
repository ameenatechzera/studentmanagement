import 'package:dio/dio.dart';
import 'package:studentmanagement/core/errors/failure.dart';

class DioErrorHandler {
  static ServerFailure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return const ServerFailure(
          "No internet connection. Please connect to Wi-Fi or mobile data and try again.",
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ServerFailure("Request timed out. Please try again.");

      default:
        return ServerFailure(e.message ?? "Something went wrong.");
    }
  }
}
