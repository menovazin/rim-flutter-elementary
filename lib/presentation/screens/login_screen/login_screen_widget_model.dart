import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.dart';
import '../../../routes/router.gr.dart';
import '../../../services/token_service.dart';
import 'login_screen.dart';
import 'login_screen_model.dart';

LoginWidgetModel loginWidgetModelFactory(BuildContext context) {
  return LoginWidgetModel(
    LoginModel(getIt<ITokenService>()),
    getIt<AppRouter>(),
  );
}

class LoginWidgetModel extends WidgetModel<LoginScreen, LoginModel>
    implements ILoginWidgetModel {
  final StackRouter _router;

  LoginWidgetModel(super._model, this._router);

  @override
  Future<void> signIn(String username) async {
    await model.signIn(username);
    await _router.replace(const ShellRoute());
  }
}

abstract interface class ILoginWidgetModel implements IWidgetModel {
  Future<void> signIn(String username);
}
