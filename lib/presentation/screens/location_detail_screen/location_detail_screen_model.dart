import 'package:elementary/elementary.dart';

import '../../../features/characters/domain/contract/character_repository.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../features/locations/domain/model/location.dart';

class LocationDetailModel extends ElementaryModel {
  final ICharacterRepository _characterRepository;
  final Location location;

  LocationDetailModel(this._characterRepository, {required this.location});

  Future<List<Character>> getResidentsByIds(List<int> ids) {
    return _characterRepository.getCharactersByIds(ids);
  }
}
