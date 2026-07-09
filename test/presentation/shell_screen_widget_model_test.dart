import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/presentation/screens/shell_screen/shell_screen.dart';
import 'package:rim_elementary/presentation/screens/shell_screen/shell_screen_model.dart';
import 'package:rim_elementary/presentation/screens/shell_screen/shell_screen_widget_model.dart';
import 'package:rim_elementary/routes/router.gr.dart';

import '../mocks/app_router_mock.dart';
import '../mocks/token_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const LoginRoute());
  });

  late TokenServiceMock tokenService;
  late AppRouterMock router;
  late ShellModel model;

  ShellWidgetModel setUpWm() {
    tokenService = TokenServiceMock();
    router = AppRouterMock();
    model = ShellModel(tokenService);

    when(() => tokenService.deleteToken())
        .thenAnswer((_) => Future<void>.value());
    when(() => router.replaceAll(any()))
        .thenAnswer((_) => Future<void>.value());

    return ShellWidgetModel(model, router);
  }

  group('ShellWidgetModel', () {
    testWidgetModel<ShellWidgetModel, ShellScreen>(
      'signOut clears token and navigates to login',
      setUpWm,
      (wm, tester, context) async {
        tester.init();

        await wm.signOut();

        verify(() => tokenService.deleteToken()).called(1);
        verify(() => router.replaceAll([const LoginRoute()])).called(1);
      },
    );

    testWidgetModel<ShellWidgetModel, ShellScreen>(
      'signOut clears token before navigation',
      setUpWm,
      (wm, tester, context) async {
        tester.init();

        await wm.signOut();

        verifyInOrder([
          () => tokenService.deleteToken(),
          () => router.replaceAll([const LoginRoute()]),
        ]);
      },
    );
  });
}
