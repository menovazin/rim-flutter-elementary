import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
abstract class AppError with _$AppError {
  const factory AppError.network() = _AppErrorNetwork;

  const factory AppError.server() = _AppErrorServer;

  const factory AppError.unknown() = _AppErrorUnknown;
}

class AppException implements Exception {
  final AppError error;

  AppException(this.error);

  @override
  String toString() => 'AppException($error)';
}
