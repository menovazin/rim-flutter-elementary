import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/presentation/widgets/character_status_x.dart';

void main() {
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
    test('statusColor is green for alive', () {
      expect(base.statusColor, const Color(0xFF34E27A));
    });

    test('statusColor is red for dead', () {
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
      expect(dead.statusColor, const Color(0xFFE5484D));
    });

    test('statusColor is grey for unknown', () {
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
      expect(unknown.statusColor, const Color(0xFF9DB5B1));
    });
  });
}