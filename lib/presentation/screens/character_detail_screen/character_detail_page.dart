import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/characters/domain/model/character.dart';
import 'character_detail_screen.dart';

@RoutePage()
class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return CharacterDetailScreen(character: character);
  }
}
