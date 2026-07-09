import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di/di.dart';
import 'routes/router.dart';

/// Bootstrap the app: initialize DI, build the router, run.
void runner() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  final router = AppRouter();

  runApp(App(router: router));
}
