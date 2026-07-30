import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final hasInternet = await InternetConnection().hasInternetAccess;

    if (!hasInternet) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message:
              "No internet connection. Please connect to Wi-Fi or mobile data and try again.",
        ),
      );
      return;
    }

    handler.next(options);
  }
}
