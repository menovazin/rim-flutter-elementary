import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/services/network/auth_interceptor.dart';

import '../mocks/token_service_mock.dart';

void main() {
  late TokenServiceMock tokenService;
  late AuthInterceptor interceptor;

  setUp(() {
    tokenService = TokenServiceMock();
    interceptor = AuthInterceptor(tokenService);
  });

  group('AuthInterceptor', () {
    test('adds Bearer Authorization when token is present', () async {
      when(() => tokenService.readToken()).thenAnswer((_) async => 'tok_123');

      final options = RequestOptions(path: '/character');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.nextOptions, isNotNull);
      expect(
        handler.nextOptions!.headers['Authorization'],
        'Bearer tok_123',
      );
    });

    test('does not add Authorization when token is null', () async {
      when(() => tokenService.readToken()).thenAnswer((_) async => null);

      final options = RequestOptions(path: '/character');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.nextOptions, isNotNull);
      expect(
        handler.nextOptions!.headers.containsKey('Authorization'),
        isFalse,
      );
    });

    test('does not add Authorization when token is empty', () async {
      when(() => tokenService.readToken()).thenAnswer((_) async => '');

      final options = RequestOptions(path: '/character');
      final handler = _CapturingRequestHandler();

      await interceptor.onRequest(options, handler);

      expect(handler.nextOptions, isNotNull);
      expect(
        handler.nextOptions!.headers.containsKey('Authorization'),
        isFalse,
      );
    });
  });
}

class _CapturingRequestHandler extends RequestInterceptorHandler {
  RequestOptions? nextOptions;

  @override
  void next(RequestOptions requestOptions) {
    nextOptions = requestOptions;
  }
}
