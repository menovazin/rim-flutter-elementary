import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../di/di.dart';
import '../../../routes/router.gr.dart';
import 'splash_screen.dart';
import 'splash_screen_model.dart';

SplashWidgetModel splashWidgetModelFactory(BuildContext context) {
  return SplashWidgetModel(
    SplashModel(di.tokenService),
    di.appRouter,
  );
}

class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel>
    implements ISplashWidgetModel {
  final StackRouter _router;

  SplashWidgetModel(super._model, this._router);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_checkAuth());
  }

  Future<void> _checkAuth() async {
    final isAuthenticated = await model.checkAuthentication();

    if (isAuthenticated) {
      await _router.replace(const ShellRoute());
    } else {
      await _router.replace(const LoginRoute());
    }
  }
}

abstract interface class ISplashWidgetModel implements IWidgetModel {}
