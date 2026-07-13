import 'package:elementary/elementary.dart';

import '../../../features/episodes/domain/model/episode.dart';

class EpisodeDetailModel extends ElementaryModel {
  final Episode episode;

  EpisodeDetailModel({required this.episode});
}
