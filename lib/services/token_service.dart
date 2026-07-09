import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class ITokenService {
  Future<String?> readToken();

  Future<void> writeToken(String token);

  Future<void> deleteToken();
}

class TokenService implements ITokenService {
  static const tokenKey = 'auth_token';

  final FlutterSecureStorage _storage;

  const TokenService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  @override
  Future<String?> readToken() => _storage.read(key: tokenKey);

  @override
  Future<void> writeToken(String token) =>
      _storage.write(key: tokenKey, value: token);

  @override
  Future<void> deleteToken() => _storage.delete(key: tokenKey);
}
