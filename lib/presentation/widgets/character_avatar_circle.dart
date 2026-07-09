import 'package:flutter/material.dart';

import '../../config/urls.dart';
import '../../features/characters/domain/model/character.dart';

class CharacterAvatarCircle extends StatelessWidget {
  final Character character;
  final double radius;

  const CharacterAvatarCircle({
    super.key,
    required this.character,
    this.radius = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: character.image.isNotEmpty
              ? NetworkImage('${AppUrls.base}${character.image}')
              : null,
          child: character.image.isEmpty
              ? Text(
                  character.name.isNotEmpty
                      ? character.name[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: radius * 3,
          child: Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
