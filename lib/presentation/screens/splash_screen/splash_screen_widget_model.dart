import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../di/di.dart';
import '../../../routes/router.gr.dart';
import 'splash_screen.dart';
import 'splash_screen_model.dart';

const _preNavigationDelay = Duration(milliseconds: 600);
const _postNavigationDelay = Duration(milliseconds: 300);

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

    await Future<void>.delayed(_preNavigationDelay);

    if (isAuthenticated) {
      unawaited(_router.replace(const ShellRoute()));
    } else {
      unawaited(_router.replace(const LoginRoute()));
    }

    await Future<void>.delayed(_postNavigationDelay);
    FlutterNativeSplash.remove();
  }
}

abstract interface class ISplashWidgetModel implements IWidgetModel {}
