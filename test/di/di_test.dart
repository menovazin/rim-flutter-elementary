import 'package:flutter_test/flutter_test.dart';

import 'package:rim_elementary/di/di.dart';

void main() {
  test('configureDependencies initializes GetIt without throwing', () {
    expect(configureDependencies, returnsNormally);
  });

  test('getIt is ready after configureDependencies', () {
    configureDependencies();
    expect(getIt, isNotNull);
  });
}
