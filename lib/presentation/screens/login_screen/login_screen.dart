import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import 'login_screen_widget_model.dart';

class LoginScreen extends ElementaryWidget<ILoginWidgetModel> {
  const LoginScreen({
    WidgetModelFactory wmFactory = loginWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(ILoginWidgetModel wm) {
    return _LoginBody(wm: wm);
  }
}

class _LoginBody extends StatefulWidget {
  final ILoginWidgetModel wm;

  const _LoginBody({required this.wm});

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.loginSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: l10n.loginNameLabel,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => widget.wm.signIn(_usernameController.text),
              child: Text(l10n.loginSignInButton),
            ),
          ],
        ),
      ),
    );
  }
}
