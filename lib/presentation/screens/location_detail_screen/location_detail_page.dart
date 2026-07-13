import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../features/locations/domain/model/location.dart';
import 'location_detail_screen.dart';

@RoutePage()
class LocationDetailPage extends StatelessWidget {
  final Location location;

  const LocationDetailPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return LocationDetailScreen(location: location);
  }
}
