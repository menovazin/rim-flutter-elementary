import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/presentation/screens/login_screen/login_screen.dart';
import 'package:rim_elementary/presentation/screens/login_screen/login_screen_model.dart';
import 'package:rim_elementary/presentation/screens/login_screen/login_screen_widget_model.dart';
import 'package:rim_elementary/routes/router.gr.dart';

import '../mocks/app_router_mock.dart';
import '../mocks/token_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const ShellRoute());
  });

  late TokenServiceMock tokenService;
  late AppRouterMock router;
  late LoginModel model;

  LoginWidgetModel setUpWm() {
    tokenService = TokenServiceMock();
    router = AppRouterMock();
    model = LoginModel(tokenService);

    when(() => tokenService.writeToken(any()))
        .thenAnswer((_) => Future<void>.value());
    when(() => router.replace(any()))
        .thenAnswer((_) => Future<void>.value());

    return LoginWidgetModel(model, router);
  }

  group('LoginWidgetModel', () {
    testWidgetModel<LoginWidgetModel, LoginScreen>(
      'signIn persists a fake token and navigates to shell',
      setUpWm,
      (wm, tester, context) async {
        tester.init();

        await wm.signIn('Rick');

        final tokenVerification = verify(
          () => tokenService.writeToken(captureAny()),
        )..called(1);
        expect(tokenVerification.captured.single, startsWith('fake_token_'));

        verify(() => router.replace(const ShellRoute())).called(1);
      },
    );

    testWidgetModel<LoginWidgetModel, LoginScreen>(
      'signIn works with empty username',
      setUpWm,
      (wm, tester, context) async {
        tester.init();

        await wm.signIn('');

        final tokenVerification = verify(
          () => tokenService.writeToken(captureAny()),
        )..called(1);
        expect(tokenVerification.captured.single, startsWith('fake_token_'));

        verify(() => router.replace(const ShellRoute())).called(1);
      },
    );
  });
}
