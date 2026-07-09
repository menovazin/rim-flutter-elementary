import 'package:flutter/material.dart';

import '../../features/characters/domain/model/character.dart';

extension CharacterGenderX on Character {
  IconData get genderIcon {
    switch (gender.toLowerCase()) {
      case 'male':
        return Icons.male;
      case 'female':
        return Icons.female;
      case 'genderless':
        return Icons.transgender;
      default:
        return Icons.question_mark;
    }
  }

  String get genderSymbol {
    switch (gender.toLowerCase()) {
      case 'male':
        return '♂';
      case 'female':
        return '♀';
      case 'genderless':
        return '⚪';
      default:
        return '?';
    }
  }
}
