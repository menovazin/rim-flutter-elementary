import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';
import 'splash_screen_model.dart';

SplashWidgetModel splashWidgetModelFactory(BuildContext context) {
  return SplashWidgetModel(SplashModel());
}

class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel>
    implements ISplashWidgetModel {
  SplashWidgetModel(super._model);

  @override
  String get title => model.title;
}

abstract interface class ISplashWidgetModel implements IWidgetModel {
  String get title;
}
