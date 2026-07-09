import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.dart';
import '../../../routes/router.gr.dart';
import '../../../services/token_service.dart';
import 'shell_screen.dart';
import 'shell_screen_model.dart';

ShellWidgetModel shellWidgetModelFactory(BuildContext context) {
  return ShellWidgetModel(
    ShellModel(getIt<ITokenService>()),
    getIt<AppRouter>(),
  );
}

class ShellWidgetModel extends WidgetModel<ShellScreen, ShellModel>
    implements IShellWidgetModel {
  final StackRouter _router;

  ShellWidgetModel(super._model, this._router);

  @override
  Future<void> signOut() async {
    await model.signOut();
    await _router.replaceAll([const LoginRoute()]);
  }
}

abstract interface class IShellWidgetModel implements IWidgetModel {
  Future<void> signOut();
}
