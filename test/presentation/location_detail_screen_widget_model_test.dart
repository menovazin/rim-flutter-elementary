import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/features/locations/domain/model/location.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen_model.dart';
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_screen_widget_model.dart';

void main() {
  LocationDetailWidgetModel setUpWm(Location location) {
    final model = LocationDetailModel(location: location);

    return LocationDetailWidgetModel(model);
  }

  group('LocationDetailWidgetModel', () {
    testWidgetModel<LocationDetailWidgetModel, LocationDetailScreen>(
      'empty residents returns empty residentIds',
      () => setUpWm(
        const Location(
          id: 1,
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
          residentIds: [],
        ),
      ),
      (wm, tester, context) {
        tester.init();

        expect(wm.residentIds, isEmpty);
      },
    );

    testWidgetModel<LocationDetailWidgetModel, LocationDetailScreen>(
      'residentIds returns ids from location',
      () => setUpWm(
        const Location(
          id: 1,
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
          residentIds: [1, 2],
        ),
      ),
      (wm, tester, context) {
        tester.init();

        expect(wm.residentIds, [1, 2]);
      },
    );
  });
}
