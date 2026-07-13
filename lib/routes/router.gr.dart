// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:rim_elementary/features/characters/domain/model/character.dart'
    as _i12;
import 'package:rim_elementary/features/episodes/domain/model/episode.dart'
    as _i13;
import 'package:rim_elementary/features/locations/domain/model/location.dart'
    as _i14;
import 'package:rim_elementary/presentation/screens/character_detail_screen/character_detail_page.dart'
    as _i1;
import 'package:rim_elementary/presentation/screens/characters_screen/characters_page.dart'
    as _i2;
import 'package:rim_elementary/presentation/screens/episode_detail_screen/episode_detail_page.dart'
    as _i3;
import 'package:rim_elementary/presentation/screens/episodes_screen/episodes_page.dart'
    as _i4;
import 'package:rim_elementary/presentation/screens/location_detail_screen/location_detail_page.dart'
    as _i5;
import 'package:rim_elementary/presentation/screens/locations_screen/locations_page.dart'
    as _i6;
import 'package:rim_elementary/presentation/screens/login_screen/login_page.dart'
    as _i7;
import 'package:rim_elementary/presentation/screens/shell_screen/shell_page.dart'
    as _i8;
import 'package:rim_elementary/presentation/screens/splash_screen/splash_page.dart'
    as _i9;

/// generated route for
/// [_i1.CharacterDetailPage]
class CharacterDetailRoute
    extends _i10.PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    _i11.Key? key,
    required _i12.Character character,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         CharacterDetailRoute.name,
         args: CharacterDetailRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharacterDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterDetailRouteArgs>();
      return _i1.CharacterDetailPage(key: args.key, character: args.character);
    },
  );
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({this.key, required this.character});

  final _i11.Key? key;

  final _i12.Character character;

  @override
  String toString() {
    return 'CharacterDetailRouteArgs{key: $key, character: $character}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CharacterDetailRouteArgs) return false;
    return key == other.key && character == other.character;
  }

  @override
  int get hashCode => key.hashCode ^ character.hashCode;
}

/// generated route for
/// [_i2.CharactersPage]
class CharactersRoute extends _i10.PageRouteInfo<void> {
  const CharactersRoute({List<_i10.PageRouteInfo>? children})
    : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.CharactersPage();
    },
  );
}

/// generated route for
/// [_i3.EpisodeDetailPage]
class EpisodeDetailRoute extends _i10.PageRouteInfo<EpisodeDetailRouteArgs> {
  EpisodeDetailRoute({
    _i11.Key? key,
    required _i13.Episode episode,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         EpisodeDetailRoute.name,
         args: EpisodeDetailRouteArgs(key: key, episode: episode),
         initialChildren: children,
       );

  static const String name = 'EpisodeDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EpisodeDetailRouteArgs>();
      return _i3.EpisodeDetailPage(key: args.key, episode: args.episode);
    },
  );
}

class EpisodeDetailRouteArgs {
  const EpisodeDetailRouteArgs({this.key, required this.episode});

  final _i11.Key? key;

  final _i13.Episode episode;

  @override
  String toString() {
    return 'EpisodeDetailRouteArgs{key: $key, episode: $episode}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EpisodeDetailRouteArgs) return false;
    return key == other.key && episode == other.episode;
  }

  @override
  int get hashCode => key.hashCode ^ episode.hashCode;
}

/// generated route for
/// [_i4.EpisodesPage]
class EpisodesRoute extends _i10.PageRouteInfo<void> {
  const EpisodesRoute({List<_i10.PageRouteInfo>? children})
    : super(EpisodesRoute.name, initialChildren: children);

  static const String name = 'EpisodesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.EpisodesPage();
    },
  );
}

/// generated route for
/// [_i5.LocationDetailPage]
class LocationDetailRoute extends _i10.PageRouteInfo<LocationDetailRouteArgs> {
  LocationDetailRoute({
    _i11.Key? key,
    required _i14.Location location,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         LocationDetailRoute.name,
         args: LocationDetailRouteArgs(key: key, location: location),
         initialChildren: children,
       );

  static const String name = 'LocationDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LocationDetailRouteArgs>();
      return _i5.LocationDetailPage(key: args.key, location: args.location);
    },
  );
}

class LocationDetailRouteArgs {
  const LocationDetailRouteArgs({this.key, required this.location});

  final _i11.Key? key;

  final _i14.Location location;

  @override
  String toString() {
    return 'LocationDetailRouteArgs{key: $key, location: $location}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LocationDetailRouteArgs) return false;
    return key == other.key && location == other.location;
  }

  @override
  int get hashCode => key.hashCode ^ location.hashCode;
}

/// generated route for
/// [_i6.LocationsPage]
class LocationsRoute extends _i10.PageRouteInfo<void> {
  const LocationsRoute({List<_i10.PageRouteInfo>? children})
    : super(LocationsRoute.name, initialChildren: children);

  static const String name = 'LocationsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.LocationsPage();
    },
  );
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute({List<_i10.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.LoginPage();
    },
  );
}

/// generated route for
/// [_i8.ShellPage]
class ShellRoute extends _i10.PageRouteInfo<void> {
  const ShellRoute({List<_i10.PageRouteInfo>? children})
    : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.ShellPage();
    },
  );
}

/// generated route for
/// [_i9.SplashPage]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashPage();
    },
  );
}
