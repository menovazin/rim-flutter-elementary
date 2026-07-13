import 'package:elementary/elementary.dart';

import '../../../features/locations/domain/model/location.dart';
import 'location_detail_screen.dart';
import 'location_detail_screen_model.dart';

LocationDetailWidgetModel createLocationDetailWidgetModel(Location location) {
  return LocationDetailWidgetModel(
    LocationDetailModel(location: location),
  );
}

class LocationDetailWidgetModel
    extends WidgetModel<LocationDetailScreen, LocationDetailModel>
    implements ILocationDetailWidgetModel {
  LocationDetailWidgetModel(super._model);

  @override
  List<int> get residentIds => model.location.residentIds;
}

abstract interface class ILocationDetailWidgetModel implements IWidgetModel {
  List<int> get residentIds;
}
