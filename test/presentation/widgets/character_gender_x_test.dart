import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/characters/domain/model/character.dart';
import 'package:rim_elementary/presentation/widgets/character_gender_x.dart';

void main() {
  Character characterWithGender(String gender) {
    return Character(
      id: 1,
      name: 'Test',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: gender,
      image: '',
      originName: '',
      originUrl: '',
      locationName: '',
      locationUrl: '',
      episodeIds: const [],
    );
  }

  group('CharacterGenderX.genderIcon', () {
    test('returns male icon for male', () {
      expect(characterWithGender('Male').genderIcon, Icons.male);
    });

    test('returns female icon for female', () {
      expect(characterWithGender('Female').genderIcon, Icons.female);
    });

    test('returns transgender icon for genderless', () {
      expect(characterWithGender('Genderless').genderIcon, Icons.transgender);
    });

    test('returns question mark for unknown', () {
      expect(characterWithGender('unknown').genderIcon, Icons.question_mark);
    });

    test('is case-insensitive', () {
      expect(characterWithGender('MALE').genderIcon, Icons.male);
      expect(characterWithGender('female').genderIcon, Icons.female);
    });
  });
}
