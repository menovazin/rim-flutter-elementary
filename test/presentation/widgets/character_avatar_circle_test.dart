import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/presentation/widgets/character_avatar_circle.dart';
import 'package:rim_elementary/themes/app_theme.dart';

import '../../helpers/path_provider_mock.dart';

void main() {
  setUpAll(setUpPathProviderMock);

  testWidgets('CharacterAvatarCircle renders character id label', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme(fontFamily: kFontFamilyNunito),
        home: const Scaffold(
          body: CharacterAvatarCircle(
            characterId: 1,
            name: '#1',
          ),
        ),
      ),
    );

    expect(find.text('#1'), findsOneWidget);
  });
}