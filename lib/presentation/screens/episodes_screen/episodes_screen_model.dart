import 'package:elementary/elementary.dart';

import '../../../features/common/domain/model/page_result.dart';
import '../../../features/episodes/domain/contract/episode_repository.dart';
import '../../../features/episodes/domain/model/episode.dart';

class EpisodesModel extends ElementaryModel {
  final IEpisodeRepository _episodeRepository;

  EpisodesModel(this._episodeRepository);

  Future<PageResult<Episode>> getEpisodes(int page) {
    return _episodeRepository.getEpisodes(page);
  }
}
