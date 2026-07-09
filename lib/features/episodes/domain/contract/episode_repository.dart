import '../../../common/domain/model/page_result.dart';
import '../model/episode.dart';

abstract interface class IEpisodeRepository {
  Future<PageResult<Episode>> getEpisodes(int page);
}
