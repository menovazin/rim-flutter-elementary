import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/presentation/widgets/character_card.dart';
import 'package:rim_elementary/themes/app_theme.dart';

import '../../helpers/path_provider_mock.dart';

void main() {
  const character = Character(
    id: 1,
    name: 'Rick Sanchez',
    status: 'Alive',
    species: 'Human',
    type: '',
    gender: 'Male',
    image: '',
    originName: '',
    originUrl: '',
    locationName: '',
    locationUrl: '',
    episodeIds: [],
  );

  setUpAll(setUpPathProviderMock);

  testWidgets('CharacterCard renders name and status row', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme(fontFamily: kFontFamilyNunito),
        home: Scaffold(
          body: SizedBox(
            width: 180,
            height: 250,
            child: CharacterCard(
              character: character,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Rick Sanchez'), findsOneWidget);
    expect(find.text('Alive • Human'), findsOneWidget);
  });
}
