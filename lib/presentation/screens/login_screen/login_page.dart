import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}
