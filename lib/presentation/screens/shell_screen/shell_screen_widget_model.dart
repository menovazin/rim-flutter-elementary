import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.gr.dart';
import 'shell_screen.dart';
import 'shell_screen_model.dart';

ShellWidgetModel shellWidgetModelFactory(BuildContext context) {
  return ShellWidgetModel(
    ShellModel(di.tokenService),
    di.appRouter,
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

  @override
  Future<void> switchTheme() => di.themeController.switchTheme();
}

abstract interface class IShellWidgetModel implements IWidgetModel {
  Future<void> signOut();

  Future<void> switchTheme();
}
