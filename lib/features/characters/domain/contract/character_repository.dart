import '../../../common/domain/model/page_result.dart';
import '../model/character.dart';

abstract interface class ICharacterRepository {
  Future<PageResult<Character>> getCharacters(int page);

  Future<List<Character>> getCharactersByIds(List<int> ids);
}
