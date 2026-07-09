import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'splash_screen_model.dart';

/// Default factory for [SplashWidgetModel].
SplashWidgetModel splashWidgetModelFactory(BuildContext context) {
  return SplashWidgetModel(SplashModel());
}

/// Widget model for [SplashScreen].
class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel>
    implements ISplashWidgetModel {
  SplashWidgetModel(super._model);

  @override
  String get title => model.title;
}

/// Public contract of [SplashWidgetModel].
abstract interface class ISplashWidgetModel implements IWidgetModel {
  /// Title shown on the splash placeholder.
  String get title;
}
