import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/services/storage/theme_service.dart';
import 'package:rim_elementary/services/theme_controller.dart';
import 'package:rim_elementary/themes/app_theme.dart';

class ThemeServiceMock extends Mock implements ThemeService {}

void main() {
  late ThemeServiceMock themeService;
  late ThemeController controller;

  setUp(() {
    themeService = ThemeServiceMock();
    controller = ThemeController(themeService);
  });

  tearDown(() {
    controller.themeType.dispose();
  });

  group('ThemeController', () {
    test('init loads saved theme from service', () async {
      when(() => themeService.getTheme()).thenReturn(ThemeType.dark);

      await controller.init();

      expect(controller.themeType.value, ThemeType.dark);
    });

    test('init defaults to system when service returns null', () async {
      when(() => themeService.getTheme()).thenReturn(null);

      await controller.init();

      expect(controller.themeType.value, ThemeType.system);
    });

    test('switchTheme toggles light to dark and persists', () async {
      controller.themeType.value = ThemeType.light;
      when(() => themeService.saveTheme(ThemeType.dark))
          .thenAnswer((_) async => true);

      await controller.switchTheme();

      expect(controller.themeType.value, ThemeType.dark);
      verify(() => themeService.saveTheme(ThemeType.dark)).called(1);
    });

    test('switchTheme toggles dark to light and persists', () async {
      controller.themeType.value = ThemeType.dark;
      when(() => themeService.saveTheme(ThemeType.light))
          .thenAnswer((_) async => true);

      await controller.switchTheme();

      expect(controller.themeType.value, ThemeType.light);
      verify(() => themeService.saveTheme(ThemeType.light)).called(1);
    });
  });
}