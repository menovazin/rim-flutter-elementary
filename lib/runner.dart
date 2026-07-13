import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di/di.dart';

Future<void> runner() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  await di.themeController.init();

  final router = di.appRouter;

  runApp(
    App(
      router: router,
      themeController: di.themeController,
    ),
  );
}
