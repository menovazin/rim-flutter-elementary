import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di/di.dart';
import 'routes/router.dart';
import 'services/theme_controller.dart';

Future<void> runner() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await getIt<ThemeController>().init();

  final router = getIt<AppRouter>();

  runApp(
    App(
      router: router,
      themeController: getIt<ThemeController>(),
    ),
  );
}