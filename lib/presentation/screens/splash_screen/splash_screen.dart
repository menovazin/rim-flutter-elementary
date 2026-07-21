import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/localization_helper.dart';
import '../../../themes/app_theme.dart';
import 'splash_screen_widget_model.dart';

class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  const SplashScreen({
    WidgetModelFactory wmFactory = splashWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(ISplashWidgetModel wm) {
    return const _SplashBody();
  }
}

class _SplashBody extends StatelessWidget {
  const _SplashBody();

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;
    final designs = context.designs;

    return Scaffold(
      backgroundColor: designs.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.branding.logoSplash.image(
              width: 192,
              height: 192,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            Text(
              l10n.appTitle,
              style: context.textTheme.headlineMedium?.copyWith(
                color: designs.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CircularProgressIndicator(color: designs.primary),
          ],
        ),
      ),
    );
  }
}