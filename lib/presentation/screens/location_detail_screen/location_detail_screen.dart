import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/locations/domain/model/location.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../widgets/character_avatar_circle.dart';
import '../../widgets/location_type_x.dart';
import 'location_detail_screen_widget_model.dart';

class LocationDetailScreen
    extends ElementaryWidget<ILocationDetailWidgetModel> {
  final Location location;

  LocationDetailScreen({
    required this.location,
    super.key,
  }) : super((context) => createLocationDetailWidgetModel(location));

  @override
  Widget build(ILocationDetailWidgetModel wm) {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        final theme = Theme.of(context);
        final dimension = location.dimension.isEmpty
            ? 'Unknown'
            : location.dimension;

        return Scaffold(
          appBar: AppBar(
            title: Text(location.name),
          ),
          body: PinchToZoomScrollableWidget(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.secondaryContainer,
                          theme.colorScheme.surfaceContainerHighest,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          location.type.locationIcon,
                          color: theme.colorScheme.secondary,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          location.name,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _DimensionBadge(label: dimension),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _ResidentsSection(
                    wm: wm,
                    l10n: l10n,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DimensionBadge extends StatelessWidget {
  final String label;

  const _DimensionBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.secondary.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ResidentsSection extends StatelessWidget {
  final ILocationDetailWidgetModel wm;
  final AppLocalizations l10n;

  const _ResidentsSection({
    required this.wm,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final residentIds = wm.residentIds;

    if (residentIds.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sectionResidentsCount(0),
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.noResidentsMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.sectionResidentsCount(residentIds.length),
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: residentIds.length,
            itemBuilder: (context, index) {
              final id = residentIds[index];
              return Padding(
                padding: EdgeInsets.only(
                  right: index < residentIds.length - 1 ? 12 : 0,
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
