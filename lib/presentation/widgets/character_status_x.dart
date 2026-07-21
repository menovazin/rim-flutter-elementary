import 'package:flutter/material.dart';

import '../../features/characters/domain/model/character.dart';
import '../../themes/extensions/custom_designs.dart';

extension CharacterStatusX on Character {
  Color statusColorOf(CustomDesigns designs) {
    switch (status.toLowerCase()) {
      case 'alive':
        return designs.statusAlive;
      case 'dead':
        return designs.statusDead;
      default:
        return designs.statusUnknown;
    }
  }
}
