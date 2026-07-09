import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen.dart';
import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen_model.dart';
import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen_widget_model.dart';

void main() {
  group('SplashWidgetModel', () {
    testWidgetModel<SplashWidgetModel, SplashScreen>(
      'exposes the app title',
      () => SplashWidgetModel(SplashModel()),
      (wm, tester, context) {
        tester.init();
        expect(wm.title, 'Rick and Morty');
      },
    );
  });
}
