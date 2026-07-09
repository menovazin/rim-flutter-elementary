import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/characters/domain/model/character.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../widgets/character_gender_x.dart';
import '../../widgets/detail_widgets.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: PinchToZoomScrollableWidget(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                    character.image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return ColoredBox(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.broken_image,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: _statusColor(character.status, theme),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${character.status} • ${character.species}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DetailInfoRow(
                label: l10n.detailSpecies,
                value: character.species,
              ),
              if (character.type.isNotEmpty)
                DetailInfoRow(
                  label: l10n.detailType,
                  value: character.type,
                ),
              DetailInfoRow(
                label: l10n.detailGender,
                value: '${character.genderSymbol}  ${character.gender}',
              ),
              DetailInfoRow(
                label: l10n.detailOrigin,
                value: character.originName,
              ),
              DetailInfoRow(
                label: l10n.detailLocation,
                value: character.locationName,
              ),
              const SizedBox(height: 16),
              DetailSectionTitle(
                title: l10n.sectionEpisodesCount(character.episodeIds.length),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final id in character.episodeIds)
                    DetailChip(
                      label: 'S${(id ~/ 20 + 1).toString().padLeft(2, '0')}E${(id % 20 + 1).toString().padLeft(2, '0')}',
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status, ThemeData theme) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return theme.colorScheme.onSurfaceVariant;
    }
  }
}
