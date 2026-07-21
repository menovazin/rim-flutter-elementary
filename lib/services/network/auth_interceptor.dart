import 'package:dio/dio.dart';

import '../token_service.dart';

class AuthInterceptor extends Interceptor {
  final ITokenService _tokenService;

  AuthInterceptor(this._tokenService);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenService.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
