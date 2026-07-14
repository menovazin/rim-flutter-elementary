import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen.dart';
import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen_model.dart';
import 'package:rim_elementary/presentation/screens/splash_screen/splash_screen_widget_model.dart';
import 'package:rim_elementary/routes/router.gr.dart';

import '../mocks/app_router_mock.dart';
import '../mocks/token_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const ShellRoute());
    registerFallbackValue(const LoginRoute());
  });

  late TokenServiceMock tokenService;
  late AppRouterMock router;
  late SplashModel model;

  SplashWidgetModel setUpWm() {
    tokenService = TokenServiceMock();
    router = AppRouterMock();
    model = SplashModel(tokenService);

    when(() => router.replace(any()))
        .thenAnswer((_) => Future<void>.value());

    return SplashWidgetModel(model, router);
  }

  group('SplashWidgetModel', () {
    testWidgetModel<SplashWidgetModel, SplashScreen>(
      'routes to shell when token is present',
      setUpWm,
      (wm, tester, context) async {
        when(() => tokenService.readToken())
            .thenAnswer((_) async => 'secret_token');

        tester.init();
        await Future<void>.delayed(const Duration(milliseconds: 700));

        verify(() => router.replace(const ShellRoute())).called(1);
        verifyNever(() => router.replace(const LoginRoute()));
      },
    );

    testWidgetModel<SplashWidgetModel, SplashScreen>(
      'routes to login when token is absent',
      setUpWm,
      (wm, tester, context) async {
        when(() => tokenService.readToken()).thenAnswer((_) async => null);

        tester.init();
        await Future<void>.delayed(const Duration(milliseconds: 700));

        verify(() => router.replace(const LoginRoute())).called(1);
        verifyNever(() => router.replace(const ShellRoute()));
      },
    );
  });
}
