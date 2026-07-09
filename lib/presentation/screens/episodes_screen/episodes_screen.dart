import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/episodes/domain/model/episode.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routes/router.gr.dart';
import '../../widgets/episode_code_x.dart';
import 'episodes_screen_widget_model.dart';

class EpisodesScreen extends ElementaryWidget<IEpisodesWidgetModel> {
  const EpisodesScreen({
    WidgetModelFactory wmFactory = episodesWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(IEpisodesWidgetModel wm) {
    return _EpisodesBody(wm: wm);
  }
}

class _EpisodesBody extends StatefulWidget {
  final IEpisodesWidgetModel wm;

  const _EpisodesBody({required this.wm});

  @override
  State<_EpisodesBody> createState() => _EpisodesBodyState();
}

class _EpisodesBodyState extends State<_EpisodesBody> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      unawaited(widget.wm.loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EntityStateNotifierBuilder<List<Episode>>(
      listenableEntityState: widget.wm.episodesState,
      loadingBuilder: (_, _) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorBuilder: (_, _, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.errorLoadingEpisodes),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.wm.retry,
              child: Text(l10n.retryButton),
            ),
          ],
        ),
      ),
      builder: (_, episodes) {
        if (episodes == null || episodes.isEmpty) {
          return Center(
            child: Text(l10n.tabEpisodes),
          );
        }

        return RefreshIndicator(
          onRefresh: widget.wm.refresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final episode = episodes[index];
                    return _EpisodeListItem(
                      episode: episode,
                      onTap: () => context.router.push(
                        EpisodeDetailRoute(episode: episode),
                      ),
                    );
                  },
                  childCount: episodes.length,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: widget.wm.isLoadingMore,
                builder: (context, isLoadingMore, _) {
                  if (!isLoadingMore) {
                    return const SliverToBoxAdapter();
                  }
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: widget.wm.hasError,
                builder: (context, hasError, _) {
                  if (!hasError || episodes.isEmpty) {
                    return const SliverToBoxAdapter();
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: widget.wm.retry,
                          child: Text(l10n.retryButton),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EpisodeListItem extends StatelessWidget {
  final Episode episode;
  final VoidCallback onTap;

  const _EpisodeListItem({
    required this.episode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              _SeasonEpisodeBadge(episode: episode),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      episode.airDate,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SeasonEpisodeBadge extends StatelessWidget {
  final Episode episode;

  const _SeasonEpisodeBadge({required this.episode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        episode.seasonEpisodeLabel,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}
