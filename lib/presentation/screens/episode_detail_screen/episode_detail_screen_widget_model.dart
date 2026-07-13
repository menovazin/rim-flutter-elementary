import 'package:elementary/elementary.dart';

import '../../../features/episodes/domain/model/episode.dart';
import 'episode_detail_screen.dart';
import 'episode_detail_screen_model.dart';

EpisodeDetailWidgetModel createEpisodeDetailWidgetModel(Episode episode) {
  return EpisodeDetailWidgetModel(
    EpisodeDetailModel(episode: episode),
  );
}

class EpisodeDetailWidgetModel
    extends WidgetModel<EpisodeDetailScreen, EpisodeDetailModel>
    implements IEpisodeDetailWidgetModel {
  EpisodeDetailWidgetModel(super._model);

  @override
  List<int> get characterIds => model.episode.characterIds;
}

abstract interface class IEpisodeDetailWidgetModel implements IWidgetModel {
  List<int> get characterIds;
}
