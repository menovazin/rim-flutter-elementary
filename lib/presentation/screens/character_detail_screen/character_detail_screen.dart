import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/characters/domain/model/character.dart';
import '../../../l10n/localization_helper.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/avatar_url_utils.dart';
import '../../widgets/character_gender_x.dart';
import '../../widgets/character_status_x.dart';
import '../../widgets/detail_widgets.dart';

class CharacterDetailScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;
    final designs = context.designs;
    final imageUrl = AvatarUrlUtils.avatarUrlFromId(character.id);

    return Scaffold(
      backgroundColor: designs.background,
      appBar: AppBar(
        backgroundColor: designs.background,
        iconTheme: IconThemeData(color: designs.textPrimary),
        title: Text(
          character.name,
          style: context.textTheme.titleLarge?.copyWith(
            color: designs.textPrimary,
          ),
        ),
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
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ColoredBox(
                      color: designs.surface,
                      child: Center(
                        child: CircularProgressIndicator(color: designs.primary),
                      ),
                    ),
                    errorWidget: (context, url, error) => ColoredBox(
                      color: designs.surface,
                      child: Icon(
                        Icons.broken_image,
                        color: designs.textSecondary,
                      ),
                    ),
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
                      color: character.statusColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${character.status} • ${character.species}',
                    style: context.textTheme.titleMedium?.copyWith(
                      color: designs.textPrimary,
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
                    DetailChip(label: _episodeLabel(id)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _episodeLabel(int id) => 'E${id.toString().padLeft(2, '0')}';
}
