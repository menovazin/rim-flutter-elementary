import 'package:elementary/elementary.dart';

import '../../../services/token_service.dart';

class ShellModel extends ElementaryModel {
  final ITokenService _tokenService;

  ShellModel(this._tokenService);

  Future<void> signOut() async {
    await _tokenService.deleteToken();
  }
}
