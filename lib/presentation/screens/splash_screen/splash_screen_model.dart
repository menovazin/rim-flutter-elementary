import 'package:elementary/elementary.dart';

import '../../../config/urls.dart';

/// Model for the placeholder splash screen.
class SplashModel extends ElementaryModel {
  /// App title; replaced by localizations later.
  String get title => 'Rick and Morty';

  /// Whether mock data should be used.
  bool get useMock => AppUrls.useMock;
}
