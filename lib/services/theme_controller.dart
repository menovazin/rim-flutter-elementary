import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../themes/app_theme.dart';
import 'storage/theme_service.dart';

@lazySingleton
class ThemeController {
  ThemeController(this._themeService);

  final ThemeService _themeService;
  final ValueNotifier<ThemeType> themeType = ValueNotifier(ThemeType.system);

  ThemeData get themeData =>
      themeType.value.themeData(fontFamily: kFontFamilyNunito);

  Future<void> init() async {
    themeType.value = _themeService.getTheme() ?? ThemeType.system;
  }

  Future<void> switchTheme() async {
    final current = themeType.value;
    themeType.value =
        current == ThemeType.dark ? ThemeType.light : ThemeType.dark;
    await _themeService.saveTheme(themeType.value);
  }
}