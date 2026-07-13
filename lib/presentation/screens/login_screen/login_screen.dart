import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../themes/app_theme.dart';
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
    final designs = context.designs;

    return Scaffold(
      backgroundColor: designs.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.science_outlined,
                    size: 72,
                    color: designs.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    l10n.loginTitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: designs.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: designs.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _usernameController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) =>
                        widget.wm.signIn(_usernameController.text),
                    style: TextStyle(color: designs.textPrimary),
                    decoration: InputDecoration(
                      labelText: l10n.loginNameLabel,
                      labelStyle: TextStyle(color: designs.textSecondary),
                      filled: true,
                      fillColor: designs.surface,
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: designs.textSecondary,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: designs.textSecondary.withValues(alpha: 0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: designs.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () =>
                          widget.wm.signIn(_usernameController.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: designs.primary,
                        foregroundColor: designs.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        l10n.loginSignInButton,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}