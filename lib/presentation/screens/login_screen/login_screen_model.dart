import 'package:elementary/elementary.dart';

import '../../../services/token_service.dart';

class LoginModel extends ElementaryModel {
  final ITokenService _tokenService;

  LoginModel(this._tokenService);

  Future<void> signIn(String username) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final token = 'fake_token_${timestamp}_$username';
    await _tokenService.writeToken(token);
  }
}
