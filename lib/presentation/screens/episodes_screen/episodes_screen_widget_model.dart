import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../di/di.dart';
import '../../../features/episodes/domain/contract/episode_repository.dart';
import '../../../features/episodes/domain/model/episode.dart';
import 'episodes_screen.dart';
import 'episodes_screen_model.dart';

EpisodesWidgetModel episodesWidgetModelFactory(BuildContext context) {
  return EpisodesWidgetModel(
    EpisodesModel(getIt<IEpisodeRepository>()),
  );
}

class EpisodesWidgetModel
    extends WidgetModel<EpisodesScreen, EpisodesModel>
    implements IEpisodesWidgetModel {
  final _episodesState = EntityStateNotifier<List<Episode>>();
  final _loadingMoreState = ValueNotifier<bool>(false);
  final _hasErrorState = ValueNotifier<bool>(false);
  int _currentPage = 1;
  bool _hasNext = true;

  @override
  EntityValueListenable<List<Episode>> get episodesState => _episodesState;

  @override
  bool get hasNext => _hasNext;

  @override
  ValueListenable<bool> get isLoadingMore => _loadingMoreState;

  @override
  ValueListenable<bool> get hasError => _hasErrorState;

  EpisodesWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_loadEpisodes());
  }

  @override
  void dispose() {
    _episodesState.dispose();
    _loadingMoreState.dispose();
    _hasErrorState.dispose();
    super.dispose();
  }

  @override
  Future<void> loadMore() async {
    if (!_hasNext || _loadingMoreState.value) return;

    _loadingMoreState.value = true;
    _hasErrorState.value = false;

    try {
      final result = await model.getEpisodes(_currentPage);
      final currentItems = _episodesState.value.data ?? [];
      _episodesState.content([...currentItems, ...result.items]);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      _hasErrorState.value = true;
      _episodesState.error(e, _episodesState.value.data);
    } finally {
      _loadingMoreState.value = false;
    }
  }

  @override
  Future<void> refresh() async {
    _currentPage = 1;
    _hasNext = true;
    _hasErrorState.value = false;
    _loadingMoreState.value = false;
    await _loadEpisodes();
  }

  @override
  Future<void> retry() async {
    _hasErrorState.value = false;
    await _loadEpisodes();
  }

  Future<void> _loadEpisodes() async {
    _episodesState.loading(_episodesState.value.data);

    try {
      final result = await model.getEpisodes(_currentPage);
      _episodesState.content(result.items);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      _hasErrorState.value = true;
      _episodesState.error(e, _episodesState.value.data);
    }
  }
}

abstract interface class IEpisodesWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Episode>> get episodesState;
  bool get hasNext;
  ValueListenable<bool> get isLoadingMore;
  ValueListenable<bool> get hasError;
  Future<void> loadMore();
  Future<void> refresh();
  Future<void> retry();
}
