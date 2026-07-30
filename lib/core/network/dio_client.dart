import 'package:dio/dio.dart';
import 'connectivity_interceptor.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio()..interceptors.add(ConnectivityInterceptor());
}
