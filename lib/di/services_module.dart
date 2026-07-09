import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../config/urls.dart';
import '../features/characters/data/api/character_service.dart';
import '../features/episodes/data/api/episode_service.dart';
import '../features/locations/data/api/location_service.dart';
import '../routes/router.dart';
import '../services/token_service.dart';

@module
abstract class ServicesModule {
  CharacterService characterService(Dio dio) =>
      CharacterService(dio, baseUrl: '${AppUrls.base}/character');

  EpisodeService episodeService(Dio dio) =>
      EpisodeService(dio, baseUrl: '${AppUrls.base}/episode');

  LocationService locationService(Dio dio) =>
      LocationService(dio, baseUrl: '${AppUrls.base}/location');

  @lazySingleton
  ITokenService tokenService() => const TokenService();

  @lazySingleton
  AppRouter appRouter() => AppRouter();
}
