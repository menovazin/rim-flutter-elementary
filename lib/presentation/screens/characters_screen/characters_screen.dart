import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/characters/domain/model/character.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routes/router.gr.dart';
import '../../../themes/app_theme.dart';
import '../../widgets/adaptive_sliver_grid.dart';
import '../../widgets/character_status_x.dart';
import '../../widgets/grid_error_tile.dart';
import 'characters_screen_widget_model.dart';

class CharactersScreen extends ElementaryWidget<ICharactersWidgetModel> {
  const CharactersScreen({
    WidgetModelFactory wmFactory = charactersWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(ICharactersWidgetModel wm) {
    return _CharactersBody(wm: wm);
  }
}

class _CharactersBody extends StatefulWidget {
  final ICharactersWidgetModel wm;

  const _CharactersBody({required this.wm});

  @override
  State<_CharactersBody> createState() => _CharactersBodyState();
}

class _CharactersBodyState extends State<_CharactersBody> {
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
    final designs = context.designs;

    return EntityStateNotifierBuilder<List<Character>>(
      listenableEntityState: widget.wm.charactersState,
      loadingBuilder: (_, _) => Center(
        child: CircularProgressIndicator(color: designs.primary),
      ),
      errorBuilder: (_, _, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: GridErrorTile(
            message: l10n.errorLoadingCharacters,
            onRetry: widget.wm.retry,
          ),
        ),
      ),
      builder: (_, characters) {
        if (characters == null || characters.isEmpty) {
          return Center(
            child: Text(
              l10n.tabCharacters,
              style: context.textTheme.bodyLarge?.copyWith(
                color: designs.textSecondary,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: widget.wm.refresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              AdaptiveSliverGrid(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final character = characters[index];
                  return _CharacterCard(
                    character: character,
                    onTap: () => context.router.push(
                      CharacterDetailRoute(character: character),
                    ),
                  );
                },
                childAspectRatio: 0.72,
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
              ValueListenableBuilder<bool>(
                valueListenable: widget.wm.hasError,
                builder: (context, hasError, _) {
                  if (!hasError || characters.isEmpty) {
                    return const SliverToBoxAdapter();
                  }
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: GridErrorTile(
                        message: l10n.errorLoadingCharacters,
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

class _CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const _CharacterCard({
    required this.character,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: designs.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: character.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(
                  color: designs.background,
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: designs.primary,
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => ColoredBox(
                  color: designs.background,
                  child: Icon(
                    Icons.broken_image,
                    color: designs.textSecondary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall?.copyWith(
                      color: designs.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: character.statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          '${character.status} • ${character.species}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: designs.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}