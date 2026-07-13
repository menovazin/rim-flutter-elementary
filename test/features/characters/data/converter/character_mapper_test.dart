import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/config/urls.dart';
import 'package:rim_elementary/features/characters/data/converter/character_mapper.dart';
import 'package:rim_elementary/features/characters/data/dto/character_dto.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';

void main() {
  group('mapCharacter', () {
    test('maps a complete CharacterDto to Character', () {
      const dto = CharacterDto(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        image: 'https://example.com/1.jpeg',
        origin: OriginDto(name: 'Earth (C-137)', url: 'https://api/location/1'),
        location: LocationDto(
          name: 'Citadel of Ricks',
          url: 'https://api/location/3',
        ),
        episode: [
          'https://api/episode/1',
          'https://api/episode/10',
          'https://api/episode/42',
        ],
      );

      final character = mapCharacter(dto);

      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      expect(character.status, 'Alive');
      expect(character.species, 'Human');
      expect(character.type, '');
      expect(character.gender, 'Male');
      expect(character.image, 'https://example.com/1.jpeg');
      expect(character.originName, 'Earth (C-137)');
      expect(character.originUrl, 'https://api/location/1');
      expect(character.locationName, 'Citadel of Ricks');
      expect(character.locationUrl, 'https://api/location/3');
      expect(character.episodeIds, [1, 10, 42]);
    });

    test('resolves relative image path against AppUrls.base', () {
      const dto = CharacterDto(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        image: '/character/avatar/1.jpeg',
      );

      final character = mapCharacter(dto);

      expect(
        character.image,
        '${AppUrls.base}/character/avatar/1.jpeg',
      );
    });

    test('extracts episode ids from URLs and drops invalid ones', () {
      const dto = CharacterDto(
        id: 2,
        name: 'Test',
        status: 'Alive',
        species: 'Human',
        gender: 'Male',
        episode: [
          'https://api/episode/5',
          'not-a-url',
          'https://api/episode/',
          'https://api/episode/12',
        ],
      );

      final character = mapCharacter(dto);

      expect(character.episodeIds, [5, 12]);
    });
  });

  group('mapCharacterList', () {
    test('maps a list of DTOs preserving order', () {
      final dtos = [
        const CharacterDto(
          id: 1,
          name: 'One',
          status: 'Alive',
          species: 'Human',
          gender: 'Male',
        ),
        const CharacterDto(
          id: 2,
          name: 'Two',
          status: 'Dead',
          species: 'Alien',
          gender: 'Female',
        ),
      ];

      final characters = mapCharacterList(dtos);

      expect(characters.length, 2);
      expect(characters[0], const Character(
        id: 1,
        name: 'One',
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
      ));
      expect(characters[1].id, 2);
      expect(characters[1].name, 'Two');
    });
  });
}
