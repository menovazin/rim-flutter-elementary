import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';

/// AutoRoute page that hosts the [SplashScreen] Elementary triple.
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
