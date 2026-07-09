import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Text(
          l10n.appTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
