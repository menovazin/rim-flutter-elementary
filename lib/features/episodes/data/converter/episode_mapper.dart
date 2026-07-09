import '../../../common/data/converter/url_id_extractor.dart';
import '../../domain/model/episode.dart';
import '../dto/episode_dto.dart';

Episode mapEpisode(EpisodeDto dto) {
  return Episode(
    id: dto.id,
    name: dto.name,
    episodeCode: dto.episode,
    airDate: dto.airDate,
    characterIds: extractIdsFromUrls(dto.characters),
  );
}

List<Episode> mapEpisodeList(List<EpisodeDto> dtos) {
  return dtos.map(mapEpisode).toList();
}
