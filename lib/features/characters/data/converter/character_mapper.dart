import '../../../../utils/avatar_url_utils.dart';
import '../../../common/data/converter/url_id_extractor.dart';
import '../../domain/model/character.dart';
import '../dto/character_dto.dart';

Character mapCharacter(CharacterDto dto) {
  return Character(
    id: dto.id,
    name: dto.name,
    status: dto.status,
    species: dto.species,
    type: dto.type,
    gender: dto.gender,
    image: AvatarUrlUtils.getCustomAvatarUrl(dto.image),
    originName: dto.origin.name,
    originUrl: dto.origin.url,
    locationName: dto.location.name,
    locationUrl: dto.location.url,
    episodeIds: extractIdsFromUrls(dto.episode),
  );
}

List<Character> mapCharacterList(List<CharacterDto> dtos) {
  return dtos.map(mapCharacter).toList();
}
