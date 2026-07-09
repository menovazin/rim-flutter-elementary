import 'package:elementary/elementary.dart';

import '../../../services/token_service.dart';

class SplashModel extends ElementaryModel {
  final ITokenService _tokenService;

  SplashModel(this._tokenService);

  Future<bool> checkAuthentication() async {
    final token = await _tokenService.readToken();

    return token != null && token.isNotEmpty;
  }
}
