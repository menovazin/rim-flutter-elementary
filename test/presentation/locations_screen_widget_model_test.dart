import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/common/domain/model/page_result.dart';
import 'package:rim_elementary/features/locations/domain/model/location.dart';
import 'package:rim_elementary/presentation/screens/locations_screen/locations_screen.dart';
import 'package:rim_elementary/presentation/screens/locations_screen/locations_screen_model.dart';
import 'package:rim_elementary/presentation/screens/locations_screen/locations_screen_widget_model.dart';
import 'package:rim_elementary/routes/router.gr.dart';
import 'package:rim_elementary/services/app_error.dart';

import '../mocks/app_router_mock.dart';
import '../mocks/location_repository_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(
      LocationDetailRoute(
        location: const Location(
          id: 0,
          name: '',
          type: '',
          dimension: '',
          residentIds: [],
        ),
      ),
    );
  });

  late LocationRepositoryMock repository;
  late AppRouterMock router;
  late LocationsModel model;

  LocationsWidgetModel setUpWm() {
    repository = LocationRepositoryMock();
    router = AppRouterMock();
    model = LocationsModel(repository);

    when(() => router.push(any())).thenAnswer((_) async => null);

    return LocationsWidgetModel(model, router);
  }

  Location createLocation(int id) {
    return Location(
      id: id,
      name: 'Location $id',
      type: 'Planet',
      dimension: 'Dimension C-137',
      residentIds: [1, 2],
    );
  }

  PageResult<Location> createPageResult({
    required int page,
    required bool hasNext,
    int itemCount = 20,
  }) {
    return PageResult(
      items: List.generate(itemCount, (i) => createLocation(page * 20 + i)),
      page: page,
      totalPages: 5,
      hasNext: hasNext,
    );
  }

  group('LocationsWidgetModel', () {
    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'loadInitial loads first page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.locationsState.value.data, isNotNull);
        expect(wm.locationsState.value.data!.length, 20);
        expect(wm.hasNext, true);
        expect(wm.isLoadingMore.value, false);
        expect(wm.error.value, isNull);

        verify(() => repository.getLocations(1)).called(1);
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'loadMore appends next page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getLocations(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.locationsState.value.data!.length, 40);
        expect(wm.hasNext, false);
        expect(wm.isLoadingMore.value, false);

        verify(() => repository.getLocations(2)).called(1);
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'loadMore stops when hasNext is false',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: false),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.locationsState.value.data!.length, 20);
        expect(wm.hasNext, false);

        verifyNever(() => repository.getLocations(2));
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'loadMore sets network error on AppException',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getLocations(2)).thenThrow(
          AppException(const AppError.network()),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.error.value, const AppError.network());
        expect(wm.isLoadingMore.value, false);
        expect(wm.locationsState.value.data!.length, 20);
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'refresh resets to page 1',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );
        when(() => repository.getLocations(2)).thenAnswer(
          (_) async => createPageResult(page: 2, hasNext: true),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await wm.loadMore();

        expect(wm.locationsState.value.data!.length, 40);

        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true, itemCount: 10),
        );

        await wm.refresh();

        expect(wm.locationsState.value.data!.length, 10);
        expect(wm.hasNext, true);
        expect(wm.error.value, isNull);

        verify(() => repository.getLocations(1)).called(2);
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'retry reloads current page',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenThrow(
          AppException(const AppError.server()),
        );

        tester.init();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        expect(wm.error.value, const AppError.server());

        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: true),
        );

        await wm.retry();

        expect(wm.locationsState.value.data!.length, 20);
        expect(wm.error.value, isNull);

        verify(() => repository.getLocations(1)).called(2);
      },
    );

    testWidgetModel<LocationsWidgetModel, LocationsScreen>(
      'openLocation pushes LocationDetailRoute',
      setUpWm,
      (wm, tester, context) async {
        when(() => repository.getLocations(1)).thenAnswer(
          (_) async => createPageResult(page: 1, hasNext: false, itemCount: 1),
        );

        tester.init();
        await Future<void>.delayed(const Duration(milliseconds: 100));

        final location = wm.locationsState.value.data!.first;
        wm.openLocation(location);

        verify(
          () => router.push(LocationDetailRoute(location: location)),
        ).called(1);
      },
    );
  });
}
