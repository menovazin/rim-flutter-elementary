import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/features/locations/domain/model/location.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen_model.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen_widget_model.dart';

import '../mocks/character_repository_mock.dart';

void main() {
  late CharacterRepositoryMock repository;

  LocationDetailWidgetModel setUpWm(Location location) {
    repository = CharacterRepositoryMock();
    final model = LocationDetailModel(repository, location: location);

    return LocationDetailWidgetModel(model);
  }

  Character createCharacter(int id) {
    return Character(
      id: id,
      name: 'Character $id',
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
    );
  }

  group('LocationDetailWidgetModel', () {
    testWidgetModel<LocationDetailWidgetModel, LocationDetailScreen>(
      'empty residents sets empty list without repository call',
      () => setUpWm(
        const Location(
          id: 1,
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
          residentIds: [],
        ),
      ),
      (wm, tester, context) async {
        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.residentsState.value.data, isEmpty);
        verifyNever(() => repository.getCharactersByIds(any()));
      },
    );

    testWidgetModel<LocationDetailWidgetModel, LocationDetailScreen>(
      'loads residents by ids',
      () => setUpWm(
        const Location(
          id: 1,
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
          residentIds: [1, 2],
        ),
      ),
      (wm, tester, context) async {
        when(() => repository.getCharactersByIds([1, 2])).thenAnswer(
          (_) async => [createCharacter(1), createCharacter(2)],
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.residentsState.value.data, hasLength(2));
        verify(() => repository.getCharactersByIds([1, 2])).called(1);
      },
    );
  });
}
