import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

import '../../../di/di.dart';
import '../../../features/characters/domain/contract/character_repository.dart';
import '../../../features/characters/domain/model/character.dart';
import '../../../features/locations/domain/model/location.dart';
import 'location_detail_screen.dart';
import 'location_detail_screen_model.dart';

LocationDetailWidgetModel createLocationDetailWidgetModel(Location location) {
  return LocationDetailWidgetModel(
    LocationDetailModel(
      getIt<ICharacterRepository>(),
      location: location,
    ),
  );
}

class LocationDetailWidgetModel
    extends WidgetModel<LocationDetailScreen, LocationDetailModel>
    implements ILocationDetailWidgetModel {
  final _residentsState = EntityStateNotifier<List<Character>>();

  @override
  EntityValueListenable<List<Character>> get residentsState =>
      _residentsState;

  LocationDetailWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    unawaited(_loadResidents(model.location.residentIds));
  }

  @override
  void dispose() {
    _residentsState.dispose();
    super.dispose();
  }

  Future<void> _loadResidents(List<int> ids) async {
    if (ids.isEmpty) {
      _residentsState.content([]);
      return;
    }

    _residentsState.loading(_residentsState.value.data);

    try {
      final residents = await model.getResidentsByIds(ids);
      _residentsState.content(residents);
    } on Exception catch (e) {
      _residentsState.error(e, _residentsState.value.data);
    }
  }
}

abstract interface class ILocationDetailWidgetModel implements IWidgetModel {
  EntityValueListenable<List<Character>> get residentsState;
}
