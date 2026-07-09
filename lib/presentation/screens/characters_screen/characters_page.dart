import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'characters_screen.dart';

@RoutePage()
class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharactersScreen();
  }
}
