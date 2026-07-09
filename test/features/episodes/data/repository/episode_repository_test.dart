import 'package:chopper/chopper.dart' as chopper;
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:rim_elementary/features/common/data/dto/info_dto.dart';
import 'package:rim_elementary/features/episodes/data/api/episode_service.dart';
import 'package:rim_elementary/features/episodes/data/dto/episode_dto.dart';
import 'package:rim_elementary/features/episodes/data/repository/episode_repository.dart';
import 'package:rim_elementary/services/app_error.dart';
import 'package:rim_elementary/services/error_handler.dart';

class MockEpisodeService extends Mock implements EpisodeService {}

class MockErrorHandler extends Mock implements IErrorHandler {}

void main() {
  late MockEpisodeService service;
  late MockErrorHandler errorHandler;
  late EpisodeRepository repository;

  setUp(() {
    service = MockEpisodeService();
    errorHandler = MockErrorHandler();
    repository = EpisodeRepository(service, errorHandler);
  });

  group('getEpisodes', () {
    test('returns PageResult with mapped episodes and pagination', () async {
      const responseDto = EpisodeResponseDto(
        info: InfoDto(
          count: 51,
          pages: 3,
          next: 'https://api/episode?page=2',
        ),
        results: [
          EpisodeDto(
            id: 1,
            name: 'Pilot',
            airDate: 'December 2, 2013',
            episode: 'S01E01',
            characters: ['https://api/character/1'],
          ),
        ],
      );

      when(() => service.getEpisodes(1)).thenAnswer(
        (_) async => chopper.Response<EpisodeResponseDto>(
          http.Response('', 200),
          responseDto,
        ),
      );

      final result = await repository.getEpisodes(1);

      expect(result.page, 1);
      expect(result.totalPages, 3);
      expect(result.hasNext, true);
      expect(result.items.length, 1);
      expect(result.items.first.id, 1);
      expect(result.items.first.name, 'Pilot');
      expect(result.items.first.characterIds, [1]);
    });

    test('returns hasNext false when next is null', () async {
      const responseDto = EpisodeResponseDto(
        info: InfoDto(count: 51, pages: 3),
      );

      when(() => service.getEpisodes(3)).thenAnswer(
        (_) async => chopper.Response<EpisodeResponseDto>(
          http.Response('', 200),
          responseDto,
        ),
      );

      final result = await repository.getEpisodes(3);

      expect(result.page, 3);
      expect(result.hasNext, false);
      expect(result.items, isEmpty);
    });

    test('throws AppException with server error when body is null', () {
      when(() => service.getEpisodes(1)).thenAnswer(
        (_) async => chopper.Response<EpisodeResponseDto>(
          http.Response('', 200),
          null,
        ),
      );

      expect(
        () => repository.getEpisodes(1),
        throwsA(
          isA<AppException>().having(
            (e) => e.error,
            'error',
            const AppError.server(),
          ),
        ),
      );
    });

    test('throws AppException when service throws DioException', () {
      final dioException = DioException.connectionError(
        requestOptions: RequestOptions(path: '/episode'),
        reason: 'no connection',
      );

      when(() => service.getEpisodes(1)).thenThrow(dioException);
      when(() => errorHandler.map(dioException)).thenReturn(
        const AppError.network(),
      );

      expect(
        () => repository.getEpisodes(1),
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
