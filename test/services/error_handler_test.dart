import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/services/app_error.dart';
import 'package:rim_elementary/services/error_handler.dart';

void main() {
  late TypedErrorHandler errorHandler;

  setUp(() {
    errorHandler = TypedErrorHandler();
  });

  group('DioExceptionType mapping', () {
    test('maps connectionTimeout to network', () {
      final error = DioException.connectionTimeout(
        requestOptions: RequestOptions(path: '/'),
        timeout: const Duration(seconds: 5),
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps sendTimeout to network', () {
      final error = DioException.sendTimeout(
        requestOptions: RequestOptions(path: '/'),
        timeout: const Duration(seconds: 5),
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps receiveTimeout to network', () {
      final error = DioException.receiveTimeout(
        requestOptions: RequestOptions(path: '/'),
        timeout: const Duration(seconds: 5),
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps connectionError to network', () {
      final error = DioException.connectionError(
        requestOptions: RequestOptions(path: '/'),
        reason: 'connection refused',
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps badCertificate to network', () {
      final error = DioException.badCertificate(
        requestOptions: RequestOptions(path: '/'),
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps transformTimeout to network', () {
      final error = DioException.transformTimeout(
        requestOptions: RequestOptions(path: '/'),
        timeout: const Duration(seconds: 5),
      );

      expect(errorHandler.map(error), const AppError.network());
    });

    test('maps badResponse to server', () {
      final error = DioException.badResponse(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/'),
        response: Response(
          requestOptions: RequestOptions(path: '/'),
          statusCode: 500,
        ),
      );

      expect(errorHandler.map(error), const AppError.server());
    });

    test('maps requestCancelled to unknown', () {
      final error = DioException.requestCancelled(
        requestOptions: RequestOptions(path: '/'),
        reason: 'user cancelled',
      );

      expect(errorHandler.map(error), const AppError.unknown());
    });

    test('maps unknown to unknown', () {
      final error = DioException(
        requestOptions: RequestOptions(path: '/'),
        error: 'something went wrong',
      );

      expect(errorHandler.map(error), const AppError.unknown());
    });
  });

  group('non-DioException mapping', () {
    test('maps AppException to its AppError', () {
      final exception = AppException(const AppError.server());

      expect(errorHandler.map(exception), const AppError.server());
    });

    test('maps arbitrary exceptions to unknown', () {
      expect(errorHandler.map(Exception('oops')), const AppError.unknown());
    });
  });
}
