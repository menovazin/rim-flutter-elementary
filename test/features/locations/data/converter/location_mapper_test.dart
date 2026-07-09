import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/locations/data/converter/location_mapper.dart';
import 'package:rim_elementary/features/locations/data/dto/location_dto.dart';

void main() {
  group('mapLocation', () {
    test('maps a complete LocationDto to Location', () {
      const dto = LocationDto(
        id: 1,
        name: 'Earth (C-137)',
        type: 'Planet',
        dimension: 'Dimension C-137',
        residents: [
          'https://api/character/1',
          'https://api/character/2',
        ],
      );

      final location = mapLocation(dto);

      expect(location.id, 1);
      expect(location.name, 'Earth (C-137)');
      expect(location.type, 'Planet');
      expect(location.dimension, 'Dimension C-137');
      expect(location.residentIds, [1, 2]);
    });

    test('extracts resident ids and drops invalid ones', () {
      const dto = LocationDto(
        id: 2,
        name: 'Test',
        type: 'Unknown',
        dimension: 'unknown',
        residents: [
          'https://api/character/5',
          'not-a-url',
          'https://api/character/',
          'https://api/character/12',
        ],
      );

      final location = mapLocation(dto);

      expect(location.residentIds, [5, 12]);
    });
  });

  group('mapLocationList', () {
    test('maps a list preserving order', () {
      const dtos = [
        LocationDto(
          id: 1,
          name: 'Earth (C-137)',
          type: 'Planet',
          dimension: 'Dimension C-137',
        ),
        LocationDto(
          id: 2,
          name: 'Abadango',
          type: 'Cluster',
          dimension: 'unknown',
        ),
      ];

      final locations = mapLocationList(dtos);

      expect(locations.length, 2);
      expect(locations[0].id, 1);
      expect(locations[1].id, 2);
    });
  });
}
