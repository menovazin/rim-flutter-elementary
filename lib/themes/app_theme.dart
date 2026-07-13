import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'extensions/custom_designs.dart';

part 'dark/dark_theme_data.dart';
part 'light/light_theme_data.dart';

const kFontFamilyNunito = 'Nunito';

enum ThemeType {
  light,
  dark,
  system;

  static final themeDataMap = {
    ThemeType.dark: _darkThemeData,
    ThemeType.light: _lightThemeData,
  };

  static final labelToEnumMap = {
    ThemeType.dark.name: ThemeType.dark,
    ThemeType.light.name: ThemeType.light,
    ThemeType.system.name: ThemeType.system,
  };

  static ThemeType fromString(String text) {
    return labelToEnumMap[text] ?? ThemeType.light;
  }

  ThemeData themeData({String? fontFamily}) {
    if (this == ThemeType.system) {
      final resolved = switch (_brightness) {
        Brightness.light => ThemeType.light,
        Brightness.dark => ThemeType.dark,
      };
      return themeDataMap[resolved]!(fontFamily: fontFamily);
    }
    return themeDataMap[this]!(fontFamily: fontFamily);
  }

  Brightness get _brightness => PlatformDispatcher.instance.platformBrightness;
}

ThemeData lightTheme({String? fontFamily}) =>
    ThemeType.light.themeData(fontFamily: fontFamily);

ThemeData darkTheme({String? fontFamily}) =>
    ThemeType.dark.themeData(fontFamily: fontFamily);

extension BuildContextExt on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  CustomDesigns get designs => Theme.of(this).extension<CustomDesigns>()!;
  BaseDesigns get baseDesign => Theme.of(this).extension<BaseDesigns>()!;
}