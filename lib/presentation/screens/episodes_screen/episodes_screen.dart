import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/episodes/domain/model/episode.dart';
import '../../../l10n/localization_helper.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/app_error_utils.dart';
import '../../widgets/episode_code_x.dart';
import '../../widgets/grid_error_tile.dart';
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
    final l10n = context.strings;
    final designs = context.designs;

    return EntityStateNotifierBuilder<List<Episode>>(
      listenableEntityState: widget.wm.episodesState,
      loadingBuilder: (_, _) => Center(
        child: CircularProgressIndicator(color: designs.primary),
      ),
      errorBuilder: (_, error, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GridErrorTile(
            message: resolveAppError(error).localizedMessage(l10n),
            onRetry: widget.wm.retry,
          ),
        ),
      ),
      builder: (_, episodes) {
        if (episodes == null || episodes.isEmpty) {
          return Center(
            child: Text(
              l10n.emptyEpisodes,
              style: context.textTheme.bodyLarge?.copyWith(
                color: designs.textSecondary,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: widget.wm.refresh,
          child: CustomScrollView(
            key: const PageStorageKey<String>('episodes-scroll'),
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final episode = episodes[index];
                      return _EpisodeListItem(
                        key: ValueKey(episode.id),
                        episode: episode,
                        onTap: () => widget.wm.openEpisode(episode),
                      );
                    },
                    childCount: episodes.length,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: widget.wm.isLoadingMore,
                builder: (context, isLoadingMore, _) {
                  if (!isLoadingMore) {
                    return const SliverToBoxAdapter();
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(color: designs.primary),
                      ),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: widget.wm.error,
                builder: (context, appError, _) {
                  if (appError == null || episodes.isEmpty) {
                    return const SliverToBoxAdapter();
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridErrorTile(
                        message: appError.localizedMessage(l10n),
                        onRetry: widget.wm.retry,
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
    super.key,
    required this.episode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final s = episode.seasonNumber;
    final e = episode.episodeNumber;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: designs.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'S${s.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Text(
                'E${e.toString().padLeft(2, '0')}',
                style: context.textTheme.labelSmall?.copyWith(
                  color: designs.primary.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        title: Text(
          episode.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleSmall?.copyWith(
            color: designs.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          episode.airDate,
          style: context.textTheme.bodySmall?.copyWith(
            color: designs.textSecondary,
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: designs.textSecondary),
        onTap: onTap,
      ),
    );
  }
}
