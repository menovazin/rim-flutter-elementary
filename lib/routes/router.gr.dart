// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:rim_elementary/features/characters/domain/model/character.dart'
    as _i10;
import 'package:rim_elementary/presentation/screens/character_detail_screen/character_detail_page.dart'
    as _i1;
import 'package:rim_elementary/presentation/screens/characters_screen/characters_page.dart'
    as _i2;
import 'package:rim_elementary/presentation/screens/episodes_screen/episodes_page.dart'
    as _i3;
import 'package:rim_elementary/presentation/screens/locations_screen/locations_page.dart'
    as _i4;
import 'package:rim_elementary/presentation/screens/login_screen/login_page.dart'
    as _i5;
import 'package:rim_elementary/presentation/screens/shell_screen/shell_page.dart'
    as _i6;
import 'package:rim_elementary/presentation/screens/splash_screen/splash_page.dart'
    as _i7;

/// generated route for
/// [_i1.CharacterDetailPage]
class CharacterDetailRoute extends _i8.PageRouteInfo<CharacterDetailRouteArgs> {
  CharacterDetailRoute({
    _i9.Key? key,
    required _i10.Character character,
    List<_i8.PageRouteInfo>? children,
  }) : super(
         CharacterDetailRoute.name,
         args: CharacterDetailRouteArgs(key: key, character: character),
         initialChildren: children,
       );

  static const String name = 'CharacterDetailRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CharacterDetailRouteArgs>();
      return _i1.CharacterDetailPage(key: args.key, character: args.character);
    },
  );
}

class CharacterDetailRouteArgs {
  const CharacterDetailRouteArgs({this.key, required this.character});

  final _i9.Key? key;

  final _i10.Character character;

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
class CharactersRoute extends _i8.PageRouteInfo<void> {
  const CharactersRoute({List<_i8.PageRouteInfo>? children})
    : super(CharactersRoute.name, initialChildren: children);

  static const String name = 'CharactersRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.CharactersPage();
    },
  );
}

/// generated route for
/// [_i3.EpisodesPage]
class EpisodesRoute extends _i8.PageRouteInfo<void> {
  const EpisodesRoute({List<_i8.PageRouteInfo>? children})
    : super(EpisodesRoute.name, initialChildren: children);

  static const String name = 'EpisodesRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.EpisodesPage();
    },
  );
}

/// generated route for
/// [_i4.LocationsPage]
class LocationsRoute extends _i8.PageRouteInfo<void> {
  const LocationsRoute({List<_i8.PageRouteInfo>? children})
    : super(LocationsRoute.name, initialChildren: children);

  static const String name = 'LocationsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.LocationsPage();
    },
  );
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginPage();
    },
  );
}

/// generated route for
/// [_i6.ShellPage]
class ShellRoute extends _i8.PageRouteInfo<void> {
  const ShellRoute({List<_i8.PageRouteInfo>? children})
    : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.ShellPage();
    },
  );
}

/// generated route for
/// [_i7.SplashPage]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashPage();
    },
  );
}
