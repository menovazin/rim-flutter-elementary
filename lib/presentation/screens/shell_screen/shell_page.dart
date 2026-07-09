import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'shell_screen.dart';

@RoutePage()
class ShellPage extends StatelessWidget {
  const ShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShellScreen();
  }
}
