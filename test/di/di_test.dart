import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:rim_elementary/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await GetIt.instance.reset();
  });

  test('configureDependencies initializes GetIt without throwing', () async {
    await expectLater(configureDependencies(), completes);
  });
}
