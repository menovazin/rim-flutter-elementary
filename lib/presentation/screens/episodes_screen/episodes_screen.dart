import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Text(l10n.tabEpisodes),
    );
  }
}
