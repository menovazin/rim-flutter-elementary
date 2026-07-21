import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/locations/domain/model/location.dart';
import 'package:rim_elementary/l10n/localization_helper.dart';
import 'package:rim_elementary/presentation/widgets/location_type_x.dart';

void main() {
  testWidgets('Location list item structure renders without error', (
    tester,
  ) async {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6CA51E),
      useMaterial3: true,
    );
    const location = Location(
      id: 1,
      name: 'Earth (C-137)',
      type: 'Planet',
      dimension: 'Dimension C-137',
      residentIds: [1, 2],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
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
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  '${location.type} • ${location.dimension}',
                  style: theme.textTheme.bodySmall,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Earth (C-137)'), findsOneWidget);
    expect(find.text('Planet • Dimension C-137'), findsOneWidget);
    expect(find.byIcon(Icons.public), findsOneWidget);
  });

  testWidgets('Location detail hero structure renders without error', (
    tester,
  ) async {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6CA51E),
      useMaterial3: true,
    );
    const location = Location(
      id: 1,
      name: 'Earth (C-137)',
      type: 'Planet',
      dimension: 'Dimension C-137',
      residentIds: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
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
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.secondary
                                .withValues(alpha: 0.4),
                          ),
                        ),
                        child: Text(
                          location.dimension,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Builder(
                  builder: (context) {
                    final l10n = context.strings;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.sectionResidentsCount(0),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(l10n.noResidentsMessage),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Earth (C-137)'), findsOneWidget);
    expect(find.text('Dimension C-137'), findsOneWidget);
    expect(find.text('Residents (0)'), findsOneWidget);
    expect(find.text('No residents'), findsOneWidget);
    expect(find.byIcon(Icons.public), findsOneWidget);
  });
}
