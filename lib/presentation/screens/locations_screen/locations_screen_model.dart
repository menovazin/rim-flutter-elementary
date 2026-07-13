import 'package:elementary/elementary.dart';

import '../../../features/common/domain/model/page_result.dart';
import '../../../features/locations/domain/contract/location_repository.dart';
import '../../../features/locations/domain/model/location.dart';

class LocationsModel extends ElementaryModel {
  final ILocationRepository _locationRepository;

  LocationsModel(this._locationRepository);

  Future<PageResult<Location>> getLocations(int page) {
    return _locationRepository.getLocations(page);
  }
}
