import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../di/di.dart';
import '../../../features/episodes/domain/model/episode.dart';
import '../../../routes/router.gr.dart';
import '../../../services/app_error.dart';
import '../../controllers/paged_list_controller.dart';
import 'episodes_screen.dart';
import 'episodes_screen_model.dart';

EpisodesWidgetModel episodesWidgetModelFactory(BuildContext context) {
  return EpisodesWidgetModel(
    EpisodesModel(di.episodeRepository),
    di.appRouter,
  );
}

class EpisodesWidgetModel extends WidgetModel<EpisodesScreen, EpisodesModel>
    implements IEpisodesWidgetModel {
  final StackRouter _router;
  late final PagedListController<Episode> _controller;

  EpisodesWidgetModel(super._model, this._router) {
    _controller = PagedListController(fetch: model.getEpisodes);
  }

  @override
  EntityValueListenable<List<Episode>> get episodesState => _controller.state;

  @override
  bool get hasNext => _controller.hasNext;

  @override
  ValueListenable<bool> get isLoadingMore => _controller.isLoadingMore;

  @override
  ValueListenable<AppError?> get error => _controller.error;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_controller.loadInitial());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Future<void> loadMore() => _controller.loadMore();

  @override
  Future<void> refresh() => _controller.refresh();

  @override
  Future<void> retry() => _controller.retry();

  @override
  void openEpisode(Episode episode) {
    unawaited(_router.push(EpisodeDetailRoute(episode: episode)));
  }
}

abstract interface class IEpisodesWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Episode>> get episodesState;
  bool get hasNext;
  ValueListenable<bool> get isLoadingMore;
  ValueListenable<AppError?> get error;
  Future<void> loadMore();
  Future<void> refresh();
  Future<void> retry();
  void openEpisode(Episode episode);
}
