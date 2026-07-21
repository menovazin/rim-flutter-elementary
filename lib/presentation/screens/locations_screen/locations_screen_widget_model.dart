import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../di/di.dart';
import '../../../features/locations/domain/model/location.dart';
import '../../../routes/router.gr.dart';
import '../../../services/app_error.dart';
import '../../controllers/paged_list_controller.dart';
import 'locations_screen.dart';
import 'locations_screen_model.dart';

LocationsWidgetModel locationsWidgetModelFactory(BuildContext context) {
  return LocationsWidgetModel(
    LocationsModel(di.locationRepository),
    di.appRouter,
  );
}

class LocationsWidgetModel
    extends WidgetModel<LocationsScreen, LocationsModel>
    implements ILocationsWidgetModel {
  final StackRouter _router;
  late final PagedListController<Location> _controller;

  LocationsWidgetModel(super._model, this._router) {
    _controller = PagedListController(fetch: model.getLocations);
  }

  @override
  EntityValueListenable<List<Location>> get locationsState => _controller.state;

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
  void openLocation(Location location) {
    unawaited(_router.push(LocationDetailRoute(location: location)));
  }
}

abstract interface class ILocationsWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Location>> get locationsState;
  bool get hasNext;
  ValueListenable<bool> get isLoadingMore;
  ValueListenable<AppError?> get error;
  Future<void> loadMore();
  Future<void> refresh();
  Future<void> retry();
  void openLocation(Location location);
}
