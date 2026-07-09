import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(l10n.tabCharacters),
    );
  }
}
