import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/presentation/widgets/character_status_x.dart';
import 'package:rim_elementary/themes/extensions/custom_designs.dart';

void main() {
  final designs = CustomDesigns.light();

  const base = Character(
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
    episodeIds: [],
  );

  group('CharacterStatusX', () {
    test('statusColorOf is statusAlive for alive', () {
      expect(base.statusColorOf(designs), designs.statusAlive);
    });

    test('statusColorOf is statusDead for dead', () {
      const dead = Character(
        id: 2,
        name: 'Birdperson',
        status: 'Dead',
        species: 'Bird-Person',
        type: '',
        gender: 'Male',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(dead.statusColorOf(designs), designs.statusDead);
    });

    test('statusColorOf is statusUnknown for unknown', () {
      const unknown = Character(
        id: 3,
        name: 'Unknown',
        status: 'unknown',
        species: 'Alien',
        type: '',
        gender: 'unknown',
        image: '',
        originName: '',
        originUrl: '',
        locationName: '',
        locationUrl: '',
        episodeIds: [],
      );
      expect(unknown.statusColorOf(designs), designs.statusUnknown);
    });
  });
}
