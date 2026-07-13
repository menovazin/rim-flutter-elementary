import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/episodes/domain/model/episode.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../themes/app_theme.dart';
import '../../widgets/character_avatar_circle.dart';
import '../../widgets/episode_code_x.dart';
import 'episode_detail_screen_widget_model.dart';

class EpisodeDetailScreen extends ElementaryWidget<IEpisodeDetailWidgetModel> {
  final Episode episode;

  EpisodeDetailScreen({
    required this.episode,
    super.key,
  }) : super((context) => createEpisodeDetailWidgetModel(episode));

  @override
  Widget build(IEpisodeDetailWidgetModel wm) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        final designs = context.designs;

        return Scaffold(
          backgroundColor: designs.background,
          appBar: AppBar(
            backgroundColor: designs.background,
            iconTheme: IconThemeData(color: designs.textPrimary),
            title: Text(
              episode.name,
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
                  _HeroBlock(episode: episode),
                  const SizedBox(height: 24),
                  _CharactersSection(wm: wm, l10n: l10n),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroBlock extends StatelessWidget {
  final Episode episode;

  const _HeroBlock({required this.episode});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final s = episode.seasonNumber;
    final e = episode.episodeNumber;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            designs.primary.withValues(alpha: 0.15),
            designs.surface,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: designs.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'S${s.toString().padLeft(2, '0')}',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: designs.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: designs.primary.withValues(alpha: 0.4),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'E${e.toString().padLeft(2, '0')}',
                  style: context.textTheme.labelLarge?.copyWith(
                    color: designs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            episode.name,
            style: context.textTheme.headlineSmall?.copyWith(
              color: designs.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            episode.airDate,
            style: context.textTheme.bodyMedium?.copyWith(
              color: designs.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CharactersSection extends StatelessWidget {
  final IEpisodeDetailWidgetModel wm;
  final AppLocalizations l10n;

  const _CharactersSection({required this.wm, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final characterIds = wm.characterIds;

    if (characterIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sectionCharactersCount(characterIds.length),
          style: context.textTheme.titleMedium?.copyWith(
            color: designs.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: characterIds.length,
            itemBuilder: (context, index) {
              final id = characterIds[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < characterIds.length - 1 ? 12 : 0,
                ),
                child: CharacterAvatarCircle(
                  characterId: id,
                  name: '#$id',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}