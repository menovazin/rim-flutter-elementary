import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../di/di.dart';
import '../../../features/locations/domain/contract/location_repository.dart';
import '../../../features/locations/domain/model/location.dart';
import 'locations_screen.dart';
import 'locations_screen_model.dart';

LocationsWidgetModel locationsWidgetModelFactory(BuildContext context) {
  return LocationsWidgetModel(
    LocationsModel(getIt<ILocationRepository>()),
  );
}

class LocationsWidgetModel
    extends WidgetModel<LocationsScreen, LocationsModel>
    implements ILocationsWidgetModel {
  final _locationsState = EntityStateNotifier<List<Location>>();
  final _loadingMoreState = ValueNotifier<bool>(false);
  final _hasErrorState = ValueNotifier<bool>(false);
  int _currentPage = 1;
  bool _hasNext = true;

  @override
  EntityValueListenable<List<Location>> get locationsState => _locationsState;

  @override
  bool get hasNext => _hasNext;

  @override
  ValueListenable<bool> get isLoadingMore => _loadingMoreState;

  @override
  ValueListenable<bool> get hasError => _hasErrorState;

  LocationsWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_loadLocations());
  }

  @override
  void dispose() {
    _locationsState.dispose();
    _loadingMoreState.dispose();
    _hasErrorState.dispose();
    super.dispose();
  }

  @override
  Future<void> loadMore() async {
    if (!_hasNext || _loadingMoreState.value) {
      return;
    }

    _loadingMoreState.value = true;
    _hasErrorState.value = false;

    try {
      final result = await model.getLocations(_currentPage);
      final currentItems = _locationsState.value.data ?? [];
      _locationsState.content([...currentItems, ...result.items]);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      _hasErrorState.value = true;
      _locationsState.error(e, _locationsState.value.data);
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
    await _loadLocations();
  }

  @override
  Future<void> retry() async {
    _hasErrorState.value = false;
    await _loadLocations();
  }

  Future<void> _loadLocations() async {
    _locationsState.loading(_locationsState.value.data);

    try {
      final result = await model.getLocations(_currentPage);
      _locationsState.content(result.items);
      _currentPage = result.page + 1;
      _hasNext = result.hasNext;
    } on Exception catch (e) {
      _hasErrorState.value = true;
      _locationsState.error(e, _locationsState.value.data);
    }
  }
}

abstract interface class ILocationsWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Location>> get locationsState;
  bool get hasNext;
  ValueListenable<bool> get isLoadingMore;
  ValueListenable<bool> get hasError;
  Future<void> loadMore();
  Future<void> refresh();
  Future<void> retry();
}
