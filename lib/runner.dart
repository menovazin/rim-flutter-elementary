import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di/di.dart';
import 'routes/router.dart';

void runner() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  final router = getIt<AppRouter>();

  runApp(App(router: router));
}
