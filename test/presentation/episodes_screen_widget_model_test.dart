import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/common/domain/model/page_result.dart';
import 'package:rim_elementary/features/episodes/domain/model/episode.dart';
import 'package:rim_elementary/presentation/screens/episodes_screen/episodes_screen.dart';
import 'package:rim_elementary/presentation/screens/episodes_screen/episodes_screen_model.dart';
import 'package:rim_elementary/presentation/screens/episodes_screen/episodes_screen_widget_model.dart';
import 'package:rim_elementary/routes/router.gr.dart';
import 'package:rim_elementary/services/app_error.dart';

import '../mocks/app_router_mock.dart';
import '../mocks/episode_repository_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
      EpisodeDetailRoute(
        episode: const Episode(
          id: 0,
          name: '',
          episodeCode: '',
          airDate: '',
          characterIds: [],
        ),
      ),
    );
  });

  late EpisodeRepositoryMock repository;
  late AppRouterMock router;
  late EpisodesModel model;

  EpisodesWidgetModel setUpWm() {
    repository = EpisodeRepositoryMock();
    router = AppRouterMock();
    model = EpisodesModel(repository);

    when(() => router.push(any())).thenAnswer((_) async => null);

    return EpisodesWidgetModel(model, router);
  }

  Episode createEpisode(int id) {
    return Episode(
      id: id,
      name: 'Episode $id',
      episodeCode: 'S01E${id.toString().padLeft(2, '0')}',
      airDate: 'January 1, 2026',
      characterIds: [1, 2, 3],
    );
  }

  PageResult<Episode> createPageResult({
    required int page,
    required bool hasNext,
    int itemCount = 20,
  }) {
    return PageResult(
      items: List.generate(itemCount, (i) => createEpisode(page * 20 + i)),
      page: page,
      totalPages: 5,
      hasNext: hasNext,
    );
  }

  group('EpisodesWidgetModel', () {
    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'loadInitial loads first page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.episodesState.value.data, isNotNull);
        expect(wm.episodesState.value.data!.length, 20);
        expect(wm.hasNext, true);
        expect(wm.isLoadingMore.value, false);
        expect(wm.error.value, isNull);

        verify(() => repository.getEpisodes(1)).called(1);
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'loadMore appends next page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getEpisodes(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.episodesState.value.data!.length, 40);
        expect(wm.hasNext, false);
        expect(wm.isLoadingMore.value, false);

        verify(() => repository.getEpisodes(2)).called(1);
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'loadMore stops when hasNext is false',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.episodesState.value.data!.length, 20);
        expect(wm.hasNext, false);

        verifyNever(() => repository.getEpisodes(2));
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'loadMore sets network error on AppException',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getEpisodes(2)).thenThrow(
          AppException(const AppError.network()),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.error.value, const AppError.network());
        expect(wm.isLoadingMore.value, false);
        expect(wm.episodesState.value.data!.length, 20);
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'refresh resets to page 1',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getEpisodes(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.episodesState.value.data!.length, 40);

        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true, itemCount: 10),
        );

        await wm.refresh();

        expect(wm.episodesState.value.data!.length, 10);
        expect(wm.hasNext, true);
        expect(wm.error.value, isNull);

        verify(() => repository.getEpisodes(1)).called(2);
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'retry reloads current page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenThrow(
          AppException(const AppError.server()),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.error.value, const AppError.server());

        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        await wm.retry();

        expect(wm.episodesState.value.data!.length, 20);
        expect(wm.error.value, isNull);

        verify(() => repository.getEpisodes(1)).called(2);
      },
    );

    testWidgetModel<EpisodesWidgetModel, EpisodesScreen>(
      'openEpisode pushes EpisodeDetailRoute',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getEpisodes(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: false, itemCount: 1),
        );

        tester.init();
        await Future<void>.delayed(const Duration(milliseconds: 100));

        final episode = wm.episodesState.value.data!.first;
        wm.openEpisode(episode);

        verify(
          () => router.push(EpisodeDetailRoute(episode: episode)),
        ).called(1);
      },
    );
  });
}
