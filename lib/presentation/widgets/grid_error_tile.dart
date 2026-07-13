import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../../themes/app_theme.dart';

class GridErrorTile extends StatelessWidget {
  final VoidCallback onRetry;
  final String? message;

  const GridErrorTile({
    super.key,
    required this.onRetry,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: designs.error.withValues(alpha: 0.6)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, color: designs.error, size: 36),
          const SizedBox(height: 12),
          Text(
            message ?? l10n.errorLoadingCharacters,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium?.copyWith(
              color: designs.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: designs.primary,
              foregroundColor: designs.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: Text(l10n.retryButton),
          ),
        ],
      ),
    );
  }
}