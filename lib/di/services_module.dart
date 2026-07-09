import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

import '../features/characters/data/api/character_service.dart';
import '../features/episodes/data/api/episode_service.dart';
import '../features/locations/data/api/location_service.dart';
import '../routes/router.dart';
import '../services/token_service.dart';

@module
abstract class ServicesModule {
  CharacterService characterService(ChopperClient client) =>
      CharacterService.create(client);

  EpisodeService episodeService(ChopperClient client) =>
      EpisodeService.create(client);

  LocationService locationService(ChopperClient client) =>
      LocationService.create(client);

  @lazySingleton
  ITokenService tokenService() => const TokenService();

  @lazySingleton
  AppRouter appRouter() => AppRouter();
}
