// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EpisodeDto _$EpisodeDtoFromJson(Map<String, dynamic> json) => _EpisodeDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  airDate: json['air_date'] as String? ?? '',
  episode: json['episode'] as String? ?? '',
  characters:
      (json['characters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
);

Map<String, dynamic> _$EpisodeDtoToJson(_EpisodeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
    };

_EpisodeResponseDto _$EpisodeResponseDtoFromJson(Map<String, dynamic> json) =>
    _EpisodeResponseDto(
      info: json['info'] == null
          ? const InfoDto()
          : InfoDto.fromJson(json['info'] as Map<String, dynamic>),
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => EpisodeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EpisodeDto>[],
    );

Map<String, dynamic> _$EpisodeResponseDtoToJson(_EpisodeResponseDto instance) =>
    <String, dynamic>{'info': instance.info, 'results': instance.results};
