// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rim_elementary/di/services_module.dart' as _i407;
import 'package:rim_elementary/di/storage_module.dart' as _i213;
import 'package:rim_elementary/features/characters/data/api/character_service.dart'
    as _i316;
import 'package:rim_elementary/features/characters/data/repository/character_repository.dart'
    as _i363;
import 'package:rim_elementary/features/characters/domain/contract/character_repository.dart'
    as _i227;
import 'package:rim_elementary/features/episodes/data/api/episode_service.dart'
    as _i861;
import 'package:rim_elementary/features/episodes/data/repository/episode_repository.dart'
    as _i963;
import 'package:rim_elementary/features/episodes/domain/contract/episode_repository.dart'
    as _i568;
import 'package:rim_elementary/features/locations/data/api/location_service.dart'
    as _i657;
import 'package:rim_elementary/features/locations/data/repository/location_repository.dart'
    as _i895;
import 'package:rim_elementary/features/locations/domain/contract/location_repository.dart'
    as _i700;
import 'package:rim_elementary/routes/router.dart' as _i897;
import 'package:rim_elementary/services/error_handler.dart' as _i1044;
import 'package:rim_elementary/services/network/dio_factory.dart' as _i10;
import 'package:rim_elementary/services/storage/theme_service.dart' as _i1017;
import 'package:rim_elementary/services/theme_controller.dart' as _i1045;
import 'package:rim_elementary/services/token_service.dart' as _i218;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final storageModule = _$StorageModule();
    final servicesModule = _$ServicesModule();
    final dioFactory = _$DioFactory();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => storageModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i218.ITokenService>(() => servicesModule.tokenService());
    gh.lazySingleton<_i897.AppRouter>(() => servicesModule.appRouter());
    gh.factory<_i1017.ThemeService>(
      () => _i1017.ThemeService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i1045.ThemeController>(
      () => _i1045.ThemeController(gh<_i1017.ThemeService>()),
    );
    gh.lazySingleton<_i1044.IErrorHandler>(() => _i1044.TypedErrorHandler());
    gh.lazySingleton<_i361.Dio>(
      () => dioFactory.create(gh<_i218.ITokenService>()),
    );
    gh.factory<_i316.CharacterService>(
      () => servicesModule.characterService(gh<_i361.Dio>()),
    );
    gh.factory<_i861.EpisodeService>(
      () => servicesModule.episodeService(gh<_i361.Dio>()),
    );
    gh.factory<_i657.LocationService>(
      () => servicesModule.locationService(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i568.IEpisodeRepository>(
      () => _i963.EpisodeRepository(
        gh<_i861.EpisodeService>(),
        gh<_i1044.IErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i700.ILocationRepository>(
      () => _i895.LocationRepository(
        gh<_i657.LocationService>(),
        gh<_i1044.IErrorHandler>(),
      ),
    );
    gh.lazySingleton<_i227.ICharacterRepository>(
      () => _i363.CharacterRepository(
        gh<_i316.CharacterService>(),
        gh<_i1044.IErrorHandler>(),
      ),
    );
    return this;
  }
}

class _$StorageModule extends _i213.StorageModule {}

class _$ServicesModule extends _i407.ServicesModule {}

class _$DioFactory extends _i10.DioFactory {}
