import 'dart:async';

import 'package:chopper/chopper.dart';

import '../../features/characters/data/dto/character_dto.dart'
    show CharacterResponseDto;
import '../../features/episodes/data/dto/episode_dto.dart'
    show EpisodeResponseDto;
import '../../features/locations/data/dto/location_dto.dart'
    show LocationResponseDto;

class TypedJsonConverter extends JsonConverter {
  final Map<Type, dynamic Function(Map<String, dynamic>)> _factories;

  const TypedJsonConverter(this._factories);

  const TypedJsonConverter.withDefaults()
      : _factories = const {
          CharacterResponseDto: CharacterResponseDto.fromJson,
          EpisodeResponseDto: EpisodeResponseDto.fromJson,
          LocationResponseDto: LocationResponseDto.fromJson,
        };

  @override
  FutureOr<Response<BodyType>> convertResponse<BodyType, InnerType>(
    Response<dynamic> response,
  ) async {
    final decoded = await super.convertResponse<BodyType, InnerType>(response);
    final body = decoded.body;

    if (body == null) {
      return decoded;
    }

    if (body is Map<String, dynamic>) {
      final factory = _factories[BodyType];
      if (factory != null) {
        return response.copyWith<BodyType>(
          body: factory(body) as BodyType,
        );
      }
    }

    if (body is List && InnerType != BodyType) {
      final itemFactory = _factories[InnerType];
      if (itemFactory != null) {
        final list = body
            .map((item) =>
                item is Map<String, dynamic> ? itemFactory(item) : item)
            .toList();
        return response.copyWith<BodyType>(body: list as BodyType);
      }
    }

    return decoded;
  }
}
