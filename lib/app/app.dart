import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/generated/app_localizations.dart';
import '../l10n/localization_helper.dart';
import '../routes/router.dart';
import '../services/theme_controller.dart';

class App extends StatelessWidget {
  final AppRouter _router;
  final ThemeController _themeController;

  const App({
    required AppRouter router,
    required ThemeController themeController,
    super.key,
  })  : _router = router,
        _themeController = themeController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _themeController.themeType,
      builder: (context, _) {
        return MaterialApp.router(
          onGenerateTitle: (context) => context.strings.appTitle,
          debugShowCheckedModeBanner: false,
          theme: _themeController.themeData,
          routerConfig: _router.config(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
        );
      },
    );
  }
}
