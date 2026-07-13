import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/episodes/domain/model/episode.dart';
import 'package:rim_elementary/features/locations/domain/model/location.dart';
import 'package:rim_elementary/l10n/generated/app_localizations.dart';
import 'package:rim_elementary/presentation/screens/episode_detail_screen/episode_detail_screen.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen.dart';
import 'package:rim_elementary/themes/app_theme.dart';

import '../helpers/path_provider_mock.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _MockHttpClient();
  }
}

class _MockHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    throw const SocketException('Network disabled in golden tests');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const episode = Episode(
    id: 1,
    name: 'Pilot',
    episodeCode: 'S01E01',
    airDate: 'December 2, 2013',
    characterIds: [1, 2],
  );

  const locationWithResidents = Location(
    id: 3,
    name: 'Citadel of Ricks',
    type: 'Space station',
    dimension: 'unknown',
    residentIds: [1, 2],
  );

  const locationEmpty = Location(
    id: 20,
    name: 'Earth (C-137)',
    type: 'Planet',
    dimension: 'Dimension C-137',
    residentIds: [],
  );

  setUpAll(() {
    setUpPathProviderMock();
    HttpOverrides.global = _TestHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  Widget wrap(Widget child) {
    return MaterialApp(
      theme: lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: child,
    );
  }

  Future<void> pumpDetailGolden(
    WidgetTester tester,
    Widget child,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    await tester.pumpWidget(wrap(child));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('Episode detail screen golden', (tester) async {
    await pumpDetailGolden(
      tester,
      EpisodeDetailScreen(episode: episode),
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/episode_detail_screen.png'),
    );
  }, tags: ['golden']);

  testWidgets('Location detail screen with residents golden', (tester) async {
    await pumpDetailGolden(
      tester,
      LocationDetailScreen(location: locationWithResidents),
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/location_detail_with_residents.png'),
    );
  }, tags: ['golden']);

  testWidgets('Location detail screen empty residents golden', (tester) async {
    await pumpDetailGolden(
      tester,
      LocationDetailScreen(location: locationEmpty),
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/location_detail_empty_residents.png'),
    );
  }, tags: ['golden']);
}