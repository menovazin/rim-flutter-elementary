import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../config/urls.dart';
import '../token_service.dart';
import 'auth_interceptor.dart';

@module
abstract class DioFactory {
  @lazySingleton
  Dio create(ITokenService tokenService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.base,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(AuthInterceptor(tokenService));

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }
}
