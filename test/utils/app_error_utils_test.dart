import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/services/app_error.dart';
import 'package:rim_elementary/utils/app_error_utils.dart';

void main() {
  group('resolveAppError', () {
    test('returns AppException.error for AppException', () {
      const expected = AppError.server();

      expect(
        resolveAppError(AppException(expected)),
        expected,
      );
    });

    test('returns unknown for generic Exception', () {
      expect(
        resolveAppError(Exception('fail')),
        const AppError.unknown(),
      );
    });
  });
}