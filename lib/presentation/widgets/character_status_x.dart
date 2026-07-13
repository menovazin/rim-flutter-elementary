import 'package:flutter/material.dart';

import '../../features/characters/domain/model/character.dart';

extension CharacterStatusX on Character {
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'alive':
        return const Color(0xFF34E27A);
      case 'dead':
        return const Color(0xFFE5484D);
      default:
        return const Color(0xFF9DB5B1);
    }
  }
}