import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/services/token_service.dart';

class FlutterSecureStorageMock extends Mock implements FlutterSecureStorage {}

void main() {
  late FlutterSecureStorageMock storage;
  late TokenService tokenService;

  setUp(() {
    storage = FlutterSecureStorageMock();
    tokenService = TokenService(storage: storage);
  });

  group('readToken', () {
    test('returns token from storage', () async {
      when(() => storage.read(key: TokenService.tokenKey))
          .thenAnswer((_) async => 'secret_token');

      final result = await tokenService.readToken();

      expect(result, 'secret_token');
    });

    test('returns null when token is absent', () async {
      when(() => storage.read(key: TokenService.tokenKey))
          .thenAnswer((_) async => null);

      final result = await tokenService.readToken();

      expect(result, isNull);
    });
  });

  group('writeToken', () {
    test('writes token to storage', () async {
      when(
        () => storage.write(
          key: TokenService.tokenKey,
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});

      await tokenService.writeToken('secret_token');

      verify(
        () => storage.write(
          key: TokenService.tokenKey,
          value: 'secret_token',
        ),
      ).called(1);
    });
  });

  group('deleteToken', () {
    test('deletes token from storage', () async {
      when(() => storage.delete(key: TokenService.tokenKey))
          .thenAnswer((_) async {});

      await tokenService.deleteToken();

      verify(() => storage.delete(key: TokenService.tokenKey)).called(1);
    });
  });
}
