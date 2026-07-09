import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/episodes/domain/model/episode.dart';
import 'episode_detail_screen.dart';

@RoutePage()
class EpisodeDetailPage extends StatelessWidget {
  final Episode episode;

  const EpisodeDetailPage({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return EpisodeDetailScreen(episode: episode);
  }
}
