import 'package:flutter_test/flutter_test.dart';
import 'package:rim_elementary/utils/grid_utils.dart';

void main() {
  group('GridUtils.crossAxisCount', () {
    test('returns 1 for narrow screens', () {
      expect(GridUtils.crossAxisCount(199), 1);
      expect(GridUtils.crossAxisCount(200), 1);
    });

    test('uses width ~/ 200', () {
      expect(GridUtils.crossAxisCount(400), 2);
      expect(GridUtils.crossAxisCount(600), 3);
      expect(GridUtils.crossAxisCount(1200), 6);
    });

    test('clamps to maxColumns', () {
      expect(GridUtils.crossAxisCount(2000), 6);
    });

    test('clamps to minColumns', () {
      expect(GridUtils.crossAxisCount(0), 1);
    });
  });
}
