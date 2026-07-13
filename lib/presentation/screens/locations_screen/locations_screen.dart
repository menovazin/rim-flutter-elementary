import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/locations/domain/model/location.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routes/router.gr.dart';
import '../../widgets/location_type_x.dart';
import 'locations_screen_widget_model.dart';

class LocationsScreen extends ElementaryWidget<ILocationsWidgetModel> {
  const LocationsScreen({
    WidgetModelFactory wmFactory = locationsWidgetModelFactory,
    super.key,
  }) : super(wmFactory);

  @override
  Widget build(ILocationsWidgetModel wm) {
    return _LocationsBody(wm: wm);
  }
}

class _LocationsBody extends StatefulWidget {
  final ILocationsWidgetModel wm;

  const _LocationsBody({required this.wm});

  @override
  State<_LocationsBody> createState() => _LocationsBodyState();
}

class _LocationsBodyState extends State<_LocationsBody> {
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

    return EntityStateNotifierBuilder<List<Location>>(
      listenableEntityState: widget.wm.locationsState,
      loadingBuilder: (_, _) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorBuilder: (_, _, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.errorLoadingLocations),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: widget.wm.retry,
              child: Text(l10n.retryButton),
            ),
          ],
        ),
      ),
      builder: (_, locations) {
        if (locations == null || locations.isEmpty) {
          return Center(
            child: Text(l10n.tabLocations),
          );
        }

        return RefreshIndicator(
          onRefresh: widget.wm.refresh,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final location = locations[index];
                      return _LocationListItem(
                        location: location,
                        onTap: () => context.router.push(
                          LocationDetailRoute(location: location),
                        ),
                      );
                    },
                    childCount: locations.length,
                  ),
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
                  if (!hasError || locations.isEmpty) {
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

class _LocationListItem extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const _LocationListItem({
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locType = location.type.isEmpty ? 'Unknown' : location.type;
    final dimension =
        location.dimension.isEmpty ? 'Unknown' : location.dimension;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: CircleAvatar(
              backgroundColor:
                  theme.colorScheme.secondary.withValues(alpha: 0.18),
              child: Icon(
                location.type.locationIcon,
                color: theme.colorScheme.secondary,
              ),
            ),
            title: Text(
              location.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            subtitle: Text(
              '$locType • $dimension',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
