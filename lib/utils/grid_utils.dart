import 'package:flutter/widgets.dart';

abstract class GridUtils {
  static const double tileTargetWidth = 200;

  static const int minColumns = 1;

  static const int maxColumns = 6;

  static int crossAxisCount(double width) {
    final raw = width ~/ tileTargetWidth;
    return raw.clamp(minColumns, maxColumns);
  }
}

extension GridContextX on BuildContext {
  int get gridCrossAxisCount =>
      GridUtils.crossAxisCount(MediaQuery.sizeOf(this).width);
}
