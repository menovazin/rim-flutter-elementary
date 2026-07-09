import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/characters/data/api/character_service.dart';
import 'package:rim_elementary/features/characters/data/dto/character_dto.dart';
import 'package:rim_elementary/features/characters/data/repository/character_repository.dart';
import 'package:rim_elementary/features/common/data/dto/info_dto.dart';
import 'package:rim_elementary/services/app_error.dart';
import 'package:rim_elementary/services/error_handler.dart';

class MockCharacterService extends Mock implements CharacterService {}

class MockErrorHandler extends Mock implements IErrorHandler {}

void main() {
  late MockCharacterService service;
  late MockErrorHandler errorHandler;
  late CharacterRepository repository;

  setUp(() {
    service = MockCharacterService();
    errorHandler = MockErrorHandler();
    repository = CharacterRepository(service, errorHandler);
  });

  group('getCharacters', () {
    test('returns PageResult with mapped characters and pagination', () async {
      const responseDto = CharacterResponseDto(
        info: InfoDto(
          count: 826,
          pages: 42,
          next: 'https://api/character?page=2',
        ),
        results: [
          CharacterDto(
            id: 1,
            name: 'Rick Sanchez',
            status: 'Alive',
            species: 'Human',
            gender: 'Male',
            image: 'https://example.com/1.jpeg',
            origin: OriginDto(
              name: 'Earth (C-137)',
              url: 'https://api/location/1',
            ),
            location: LocationDto(
              name: 'Citadel of Ricks',
              url: 'https://api/location/3',
            ),
            episode: ['https://api/episode/1'],
          ),
        ],
      );

      when(() => service.getCharacters(1)).thenAnswer(
        (_) async => responseDto,
      );

      final result = await repository.getCharacters(1);

      expect(result.page, 1);
      expect(result.totalPages, 42);
      expect(result.hasNext, true);
      expect(result.items.length, 1);
      expect(result.items.first.id, 1);
      expect(result.items.first.name, 'Rick Sanchez');
      expect(result.items.first.episodeIds, [1]);
    });

    test('returns hasNext false when next is null', () async {
      const responseDto = CharacterResponseDto(
        info: InfoDto(count: 826, pages: 42),
      );

      when(() => service.getCharacters(42)).thenAnswer(
        (_) async => responseDto,
      );

      final result = await repository.getCharacters(42);

      expect(result.page, 42);
      expect(result.hasNext, false);
      expect(result.items, isEmpty);
    });

    test('throws AppException when service throws DioException', () {
      final dioException = DioException.connectionError(
        requestOptions: RequestOptions(path: '/character'),
        reason: 'no connection',
      );

      when(() => service.getCharacters(1)).thenThrow(dioException);
      when(() => errorHandler.map(dioException)).thenReturn(
        const AppError.network(),
      );

      expect(
        () => repository.getCharacters(1),
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
