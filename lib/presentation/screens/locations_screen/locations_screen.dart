import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

import '../../../features/locations/domain/model/location.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../routes/router.gr.dart';
import '../../../themes/app_theme.dart';
import '../../../utils/app_error_utils.dart';
import '../../widgets/grid_error_tile.dart';
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
    final designs = context.designs;

    return EntityStateNotifierBuilder<List<Location>>(
      listenableEntityState: widget.wm.locationsState,
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
      builder: (_, locations) {
        if (locations == null || locations.isEmpty) {
          return Center(
            child: Text(
              l10n.tabLocations,
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
                  if (appError == null || locations.isEmpty) {
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

class _LocationListItem extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const _LocationListItem({
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final designs = context.designs;
    final locType = location.type.isEmpty ? 'Unknown' : location.type;
    final dimension =
        location.dimension.isEmpty ? 'Unknown' : location.dimension;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: designs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: designs.secondary.withValues(alpha: 0.18),
          child: Icon(
            location.type.locationIcon,
            color: designs.secondary,
          ),
        ),
        title: Text(
          location.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleSmall?.copyWith(
            color: designs.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          '$locType • $dimension',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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