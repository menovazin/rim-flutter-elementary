import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/characters/domain/model/character.dart';
import '../../../features/episodes/domain/model/episode.dart';
import '../../../l10n/generated/app_localizations.dart';
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

        return Scaffold(
          appBar: AppBar(
            title: Text(episode.name),
          ),
          body: PinchToZoomScrollableWidget(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroBlock(episode: episode),
                  const SizedBox(height: 24),
                  _InfoSection(episode: episode, l10n: l10n),
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
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _HeroNumber(
                number:
                    'S${episode.seasonNumber.toString().padLeft(2, '0')}',
                label: 'Season',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '/',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              _HeroNumber(
                number:
                    'E${episode.episodeNumber.toString().padLeft(2, '0')}',
                label: 'Episode',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            episode.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            episode.airDate,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSecondaryContainer
                  .withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroNumber extends StatelessWidget {
  final String number;
  final String label;

  const _HeroNumber({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          number,
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.onSecondaryContainer,
            fontWeight: FontWeight.w900,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSecondaryContainer
                .withValues(alpha: 0.7),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final Episode episode;
  final AppLocalizations l10n;

  const _InfoSection({required this.episode, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          episode.name,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        _EpisodeInfoRow(
          label: l10n.detailEpisode,
          value: episode.seasonEpisodeLabel,
        ),
        const SizedBox(height: 4),
        _EpisodeInfoRow(
          label: l10n.detailAirDate,
          value: episode.airDate,
        ),
      ],
    );
  }
}

class _EpisodeInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _EpisodeInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _CharactersSection extends StatelessWidget {
  final IEpisodeDetailWidgetModel wm;
  final AppLocalizations l10n;

  const _CharactersSection({required this.wm, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return EntityStateNotifierBuilder<List<Character>>(
      listenableEntityState: wm.charactersState,
      loadingBuilder: (_, _) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorBuilder: (_, _, _) => Center(
        child: Text(
          l10n.errorLoadingCharacters,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ),
      builder: (_, characters) {
        if (characters == null || characters.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.sectionCharactersCount(characters.length),
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: characters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return CharacterAvatarCircle(character: character);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
