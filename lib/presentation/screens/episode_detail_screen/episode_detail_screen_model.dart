import 'package:elementary/elementary.dart';

import '../../../features/characters/domain/contract/character_repository.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../features/episodes/domain/model/episode.dart';

class EpisodeDetailModel extends ElementaryModel {
  final ICharacterRepository _characterRepository;
  final Episode episode;

  EpisodeDetailModel(this._characterRepository, {required this.episode});

  Future<List<Character>> getCharactersByIds(List<int> ids) {
    return _characterRepository.getCharactersByIds(ids);
  }
}
