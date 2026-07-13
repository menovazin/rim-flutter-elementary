import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../features/characters/domain/contract/character_repository.dart';
import '../features/episodes/domain/contract/episode_repository.dart';
import '../features/locations/domain/contract/location_repository.dart';
import '../routes/router.dart';
import '../services/theme_controller.dart';
import '../services/token_service.dart';
import 'di.config.dart';

final GetIt _getIt = GetIt.instance;

class Di {
  AppRouter get appRouter => _getIt<AppRouter>();

  ITokenService get tokenService => _getIt<ITokenService>();

  ThemeController get themeController => _getIt<ThemeController>();

  ICharacterRepository get characterRepository =>
      _getIt<ICharacterRepository>();

  IEpisodeRepository get episodeRepository => _getIt<IEpisodeRepository>();

  ILocationRepository get locationRepository => _getIt<ILocationRepository>();
}

final di = Di();

@InjectableInit()
Future<void> configureDependencies() => _getIt.init();
