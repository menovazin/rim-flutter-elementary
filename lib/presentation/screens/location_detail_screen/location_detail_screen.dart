import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:pinch_to_zoom_scrollable/pinch_to_zoom_scrollable.dart';

import '../../../features/locations/domain/model/location.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../../themes/app_theme.dart';
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
        final designs = context.designs;
        final dimension = location.dimension.isEmpty
            ? 'Unknown'
            : location.dimension;
        final locType =
            location.type.isEmpty ? 'Unknown' : location.type;

        return Scaffold(
          backgroundColor: designs.background,
          appBar: AppBar(
            backgroundColor: designs.background,
            iconTheme: IconThemeData(color: designs.textPrimary),
            title: Text(
              location.name,
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          designs.secondary.withValues(alpha: 0.15),
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
                        Icon(
                          locType.locationIcon,
                          color: designs.secondary,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          location.name,
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: designs.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _Badge(
                              label: locType,
                              color: designs.secondary,
                              textColor: designs.onSecondary,
                            ),
                            _Badge(
                              label: dimension,
                              color: Colors.transparent,
                              textColor: designs.secondary,
                              border: Border.all(
                                color: designs.secondary.withValues(alpha: 0.4),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _ResidentsSection(wm: wm, l10n: l10n),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final BoxBorder? border;

  const _Badge({
    required this.label,
    required this.color,
    required this.textColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      child: Text(
        label,
        style: context.textTheme.labelMedium?.copyWith(
          color: textColor,
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
    final designs = context.designs;
    final residentIds = wm.residentIds;

    if (residentIds.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.sectionResidentsCount(0),
            style: context.textTheme.titleMedium?.copyWith(
              color: designs.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.noResidentsMessage,
            style: context.textTheme.bodyMedium?.copyWith(
              color: designs.textSecondary,
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