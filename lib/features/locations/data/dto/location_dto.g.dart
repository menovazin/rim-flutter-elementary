// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => _LocationDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  name: json['name'] as String? ?? '',
  type: json['type'] as String? ?? '',
  dimension: json['dimension'] as String? ?? '',
  residents:
      (json['residents'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$LocationDtoToJson(_LocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'dimension': instance.dimension,
      'residents': instance.residents,
    };

_LocationResponseDto _$LocationResponseDtoFromJson(Map<String, dynamic> json) =>
    _LocationResponseDto(
      info: json['info'] == null
          ? const InfoDto()
          : InfoDto.fromJson(json['info'] as Map<String, dynamic>),
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => LocationDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LocationDto>[],
    );

Map<String, dynamic> _$LocationResponseDtoToJson(
  _LocationResponseDto instance,
) => <String, dynamic>{'info': instance.info, 'results': instance.results};
