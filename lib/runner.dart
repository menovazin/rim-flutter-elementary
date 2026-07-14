import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'di/di.dart';

Future<void> runner() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
