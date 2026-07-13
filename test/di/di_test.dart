import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('configureDependencies initializes GetIt without throwing', () async {
    await expectLater(configureDependencies(), completes);
  });
}