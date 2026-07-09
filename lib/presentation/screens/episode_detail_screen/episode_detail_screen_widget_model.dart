import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

import '../../../di/di.dart';
import '../../../features/characters/domain/contract/character_repository.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../features/episodes/domain/model/episode.dart';
import 'episode_detail_screen.dart';
import 'episode_detail_screen_model.dart';

EpisodeDetailWidgetModel createEpisodeDetailWidgetModel(Episode episode) {
  return EpisodeDetailWidgetModel(
    EpisodeDetailModel(
      getIt<ICharacterRepository>(),
      episode: episode,
    ),
  );
}

class EpisodeDetailWidgetModel
    extends WidgetModel<EpisodeDetailScreen, EpisodeDetailModel>
    implements IEpisodeDetailWidgetModel {
  final _charactersState = EntityStateNotifier<List<Character>>();

  @override
  EntityValueListenable<List<Character>> get charactersState =>
      _charactersState;

  EpisodeDetailWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_loadCharacters(model.episode.characterIds));
  }

  @override
  void dispose() {
    _charactersState.dispose();
    super.dispose();
  }

  Future<void> _loadCharacters(List<int> ids) async {
    if (ids.isEmpty) {
      _charactersState.content([]);
      return;
    }

    _charactersState.loading(_charactersState.value.data);

    try {
      final characters = await model.getCharactersByIds(ids);
      _charactersState.content(characters);
    } on Exception catch (e) {
      _charactersState.error(e, _charactersState.value.data);
    }
  }
}

abstract interface class IEpisodeDetailWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Character>> get charactersState;
}
