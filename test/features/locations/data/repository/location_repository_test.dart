import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/common/data/dto/info_dto.dart';
import 'package:rim_elementary/features/locations/data/api/location_service.dart';
import 'package:rim_elementary/features/locations/data/dto/location_dto.dart';
import 'package:rim_elementary/features/locations/data/repository/location_repository.dart';
import 'package:rim_elementary/services/app_error.dart';
import 'package:rim_elementary/services/error_handler.dart';

class MockLocationService extends Mock implements LocationService {}

class MockErrorHandler extends Mock implements IErrorHandler {}

void main() {
  late MockLocationService service;
  late MockErrorHandler errorHandler;
  late LocationRepository repository;

  setUp(() {
    service = MockLocationService();
    errorHandler = MockErrorHandler();
    repository = LocationRepository(service, errorHandler);
  });

  group('getLocations', () {
    test('returns PageResult with mapped locations and pagination', () async {
      const responseDto = LocationResponseDto(
        info: InfoDto(
          count: 126,
          pages: 7,
          next: 'https://api/location?page=2',
        ),
        results: [
          LocationDto(
            id: 1,
            name: 'Earth (C-137)',
            type: 'Planet',
            dimension: 'Dimension C-137',
            residents: ['https://api/character/1'],
          ),
        ],
      );

      when(() => service.getLocations(1)).thenAnswer(
        (_) async => responseDto,
      );

      final result = await repository.getLocations(1);

      expect(result.page, 1);
      expect(result.totalPages, 7);
      expect(result.hasNext, true);
      expect(result.items.length, 1);
      expect(result.items.first.id, 1);
      expect(result.items.first.name, 'Earth (C-137)');
      expect(result.items.first.residentIds, [1]);
    });

    test('returns hasNext false when next is null', () async {
      const responseDto = LocationResponseDto(
        info: InfoDto(count: 126, pages: 7),
      );

      when(() => service.getLocations(7)).thenAnswer(
        (_) async => responseDto,
      );

      final result = await repository.getLocations(7);

      expect(result.page, 7);
      expect(result.hasNext, false);
      expect(result.items, isEmpty);
    });

    test('throws AppException when service throws DioException', () {
      final dioException = DioException.connectionError(
        requestOptions: RequestOptions(path: '/location'),
        reason: 'no connection',
      );

      when(() => service.getLocations(1)).thenThrow(dioException);
      when(() => errorHandler.map(dioException)).thenReturn(
        const AppError.network(),
      );

      expect(
        () => repository.getLocations(1),
        throwsA(
          isA<AppException>().having(
            (e) => e.error,
            'error',
            const AppError.network(),
          ),
        ),
      );
    });
  });
}
