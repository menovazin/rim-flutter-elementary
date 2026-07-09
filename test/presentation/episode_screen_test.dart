import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/presentation/widgets/character_avatar_circle.dart';

void main() {
  testWidgets('CharacterAvatarCircle renders without error', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CharacterAvatarCircle(
                  character: Character(
                    id: 1,
                    name: 'Rick',
                    status: 'Alive',
                    species: 'Human',
                    type: '',
                    gender: 'Male',
                    image: '',
                    originName: 'Earth',
                    originUrl: '',
                    locationName: 'Earth',
                    locationUrl: '',
                    episodeIds: [1],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.text('Rick'), findsOneWidget);
  });

  testWidgets('Episode list item structure renders without error', (
    tester,
  ) async {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6CA51E),
      useMaterial3: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'S01E01',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pilot',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'December 2, 2013',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Pilot'), findsOneWidget);
    expect(find.text('S01E01'), findsOneWidget);
    expect(find.text('December 2, 2013'), findsOneWidget);
  });

  testWidgets('Episode season badge structure renders without error', (
    tester,
  ) async {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6CA51E),
      useMaterial3: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'S01E01',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('S01E01'), findsOneWidget);
  });
}
