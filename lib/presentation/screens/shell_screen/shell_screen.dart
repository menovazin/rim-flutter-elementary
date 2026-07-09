import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Text(l10n.appTitle),
      ),
    );
  }
}
