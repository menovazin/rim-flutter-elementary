import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/app/app.dart';
import 'package:rim_elementary/di/di.dart';
import 'package:rim_elementary/features/characters/domain/contract/character_repository.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/features/common/domain/model/page_result.dart';
import 'package:rim_elementary/features/episodes/domain/contract/episode_repository.dart';
import 'package:rim_elementary/features/locations/domain/contract/location_repository.dart';
import 'package:rim_elementary/routes/router.dart';
import 'package:rim_elementary/services/storage/theme_service.dart';
import 'package:rim_elementary/services/theme_controller.dart';
import 'package:rim_elementary/services/token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/path_provider_mock.dart';
import '../mocks/character_repository_mock.dart';
import '../mocks/episode_repository_mock.dart';
import '../mocks/location_repository_mock.dart';
import '../mocks/token_service_mock.dart';

void main() {
  setUpAll(setUpPathProviderMock);

  tearDown(() async {
    await GetIt.instance.reset();
  });

  testWidgets(
    'cold start without token: Login → Shell → Characters content',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final tokenService = TokenServiceMock();
      final characterRepository = CharacterRepositoryMock();
      final episodeRepository = EpisodeRepositoryMock();
      final locationRepository = LocationRepositoryMock();

      String? storedToken;
      when(() => tokenService.readToken()).thenAnswer((_) async => storedToken);
      when(() => tokenService.writeToken(any())).thenAnswer((invocation) async {
        storedToken = invocation.positionalArguments.first as String;
      });

      when(() => characterRepository.getCharacters(any())).thenAnswer(
        (_) async => const PageResult(
          items: [
            Character(
              id: 1,
              name: 'Rick Sanchez',
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
          ],
          page: 1,
          totalPages: 1,
          hasNext: false,
        ),
      );
      when(() => episodeRepository.getEpisodes(any())).thenAnswer(
        (_) async => const PageResult(
          items: [],
          page: 1,
          totalPages: 1,
          hasNext: false,
        ),
      );
      when(() => locationRepository.getLocations(any())).thenAnswer(
        (_) async => const PageResult(
          items: [],
          page: 1,
          totalPages: 1,
          hasNext: false,
        ),
      );

      final getIt = GetIt.instance;
      await getIt.reset();
      getIt
        ..registerLazySingleton(() => ThemeService(prefs))
        ..registerLazySingleton(() => ThemeController(getIt()))
        ..registerLazySingleton<ITokenService>(() => tokenService)
        ..registerLazySingleton(AppRouter.new)
        ..registerLazySingleton<ICharacterRepository>(() => characterRepository)
        ..registerLazySingleton<IEpisodeRepository>(() => episodeRepository)
        ..registerLazySingleton<ILocationRepository>(() => locationRepository);

      final themeController = di.themeController;
      await themeController.init();

      await tester.pumpWidget(
        App(
          router: di.appRouter,
          themeController: themeController,
        ),
      );
      await tester.pump();

      // Splash gate delay before navigation.
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();

      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Morty');
      await tester.tap(find.text('Sign In'));
      await tester.pumpAndSettle();

      expect(find.text('Rick Sanchez'), findsOneWidget);
      expect(find.text('Alive • Human'), findsOneWidget);
      verify(() => characterRepository.getCharacters(1)).called(greaterThan(0));
    },
  );
}
