import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes/app_theme.dart';

@injectable
class ThemeService {
  static const _themeKey = 'theme';
  final SharedPreferences _storage;

  ThemeService(this._storage);

  ThemeType? getTheme() {
    final result = _storage.getString(_themeKey);
    if (result == null) {
      return null;
    }
    return ThemeType.fromString(result);
  }

  Future<bool> saveTheme(ThemeType type) {
    return _storage.setString(_themeKey, type.name);
  }
}