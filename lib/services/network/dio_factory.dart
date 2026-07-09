import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../config/urls.dart';

@module
abstract class DioFactory {
  @lazySingleton
  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.base,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }
}
