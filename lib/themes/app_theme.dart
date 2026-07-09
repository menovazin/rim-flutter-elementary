import 'package:flutter/material.dart';

/// App-specific color tokens, layered on top of Material 3's ColorScheme.
///
/// Access via `Theme.of(context).extension<AppColors>()!`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color statusAlive;
  final Color statusDead;
  final Color statusUnknown;
  final Color badgeBackground;

  const AppColors({
    required this.statusAlive,
    required this.statusDead,
    required this.statusUnknown,
    required this.badgeBackground,
  });

  static const light = AppColors(
    statusAlive: Color(0xFF4CAF50),
    statusDead: Color(0xFFE53935),
    statusUnknown: Color(0xFF9E9E9E),
    badgeBackground: Color(0xFFECEFF1),
  );

  static const dark = AppColors(
    statusAlive: Color(0xFF66BB6A),
    statusDead: Color(0xFFEF5350),
    statusUnknown: Color(0xFFBDBDBD),
    badgeBackground: Color(0xFF37474F),
  );

  @override
  AppColors copyWith({
    Color? statusAlive,
    Color? statusDead,
    Color? statusUnknown,
    Color? badgeBackground,
  }) {
    return AppColors(
      statusAlive: statusAlive ?? this.statusAlive,
      statusDead: statusDead ?? this.statusDead,
      statusUnknown: statusUnknown ?? this.statusUnknown,
      badgeBackground: badgeBackground ?? this.badgeBackground,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      statusAlive: Color.lerp(statusAlive, other.statusAlive, t)!,
      statusDead: Color.lerp(statusDead, other.statusDead, t)!,
      statusUnknown: Color.lerp(statusUnknown, other.statusUnknown, t)!,
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t)!,
    );
  }
}

/// Light Material 3 theme with [AppColors] extension.
ThemeData get lightTheme => _buildTheme(Brightness.light, AppColors.light);

/// Dark Material 3 theme with [AppColors] extension.
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
