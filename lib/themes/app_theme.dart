import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color badgeBackground;

  const AppColors({required this.badgeBackground});

  static const light = AppColors(badgeBackground: Color(0xFFECEFF1));

  static const dark = AppColors(badgeBackground: Color(0xFF37474F));

  @override
  AppColors copyWith({Color? badgeBackground}) {
    return AppColors(badgeBackground: badgeBackground ?? this.badgeBackground);
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t)!,
    );
  }
}

ThemeData get lightTheme => _buildTheme(Brightness.light, AppColors.light);

ThemeData get darkTheme => _buildTheme(Brightness.dark, AppColors.dark);

ThemeData _buildTheme(Brightness brightness, AppColors colors) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6CA51E),
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: [colors],
  );
}
