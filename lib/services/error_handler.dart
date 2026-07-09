import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'app_error.dart';

abstract interface class IErrorHandler implements ErrorHandler {
  AppError map(Object error);
}

@LazySingleton(as: IErrorHandler)
class TypedErrorHandler implements IErrorHandler {
  @override
  void handleError(Object error, {StackTrace? stackTrace}) {
    final appError = map(error);
    if (kDebugMode) {
      debugPrint('AppError: $appError');
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  @override
  AppError map(Object error) {
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout ||
        DioExceptionType.connectionError ||
        DioExceptionType.badCertificate ||
        DioExceptionType.transformTimeout =>
          const AppError.network(),
        DioExceptionType.badResponse => const AppError.server(),
        DioExceptionType.cancel || DioExceptionType.unknown =>
          const AppError.unknown(),
      };
    }

    if (error is AppException) {
      return error.error;
    }

    return const AppError.unknown();
  }
}
