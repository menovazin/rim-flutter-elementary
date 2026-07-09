import 'package:elementary/elementary.dart';

import '../../../features/characters/domain/contract/character_repository.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../features/common/domain/model/page_result.dart';

class CharactersModel extends ElementaryModel {
  final ICharacterRepository _characterRepository;

  CharactersModel(this._characterRepository);

  Future<PageResult<Character>> getCharacters(int page) {
    return _characterRepository.getCharacters(page);
  }
}
