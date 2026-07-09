import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../l10n/generated/app_localizations.dart';
import '../routes/router.dart';
import '../themes/app_theme.dart';

/// Root application widget. Material 3 + AutoRoute + EN localization.
class App extends StatelessWidget {
  final AppRouter _router;

  const App({required AppRouter router, super.key}) : _router = router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rick and Morty',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
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
  }
}
