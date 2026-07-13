import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/episodes/domain/model/episode.dart';
import 'package:rim_elementary/presentation/screens/episode_detail_screen/episode_detail_screen.dart';
import 'package:rim_elementary/presentation/screens/episode_detail_screen/episode_detail_screen_model.dart';
import 'package:rim_elementary/presentation/screens/episode_detail_screen/episode_detail_screen_widget_model.dart';

void main() {
  EpisodeDetailWidgetModel setUpWm(Episode episode) {
    final model = EpisodeDetailModel(episode: episode);

    return EpisodeDetailWidgetModel(model);
  }

  group('EpisodeDetailWidgetModel', () {
    testWidgetModel<EpisodeDetailWidgetModel, EpisodeDetailScreen>(
      'empty characterIds returns empty list',
      () => setUpWm(
        const Episode(
          id: 1,
          name: 'Pilot',
          episodeCode: 'S01E01',
          airDate: 'December 2, 2013',
          characterIds: [],
        ),
      ),
      (wm, tester, context) {
        tester.init();

        expect(wm.characterIds, isEmpty);
      },
    );

    testWidgetModel<EpisodeDetailWidgetModel, EpisodeDetailScreen>(
      'characterIds returns ids from episode',
      () => setUpWm(
        const Episode(
          id: 1,
          name: 'Pilot',
          episodeCode: 'S01E01',
          airDate: 'December 2, 2013',
          characterIds: [1, 2, 3],
        ),
      ),
      (wm, tester, context) {
        tester.init();

        expect(wm.characterIds, [1, 2, 3]);
      },
    );
  });
}
