import 'package:elementary/elementary.dart';

import '../../../features/locations/domain/model/location.dart';

class LocationDetailModel extends ElementaryModel {
  final Location location;

  LocationDetailModel({required this.location});
}
