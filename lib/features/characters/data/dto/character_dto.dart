import 'package:json_annotation/json_annotation.dart';

import '../../../common/data/dto/info_dto.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final OriginDto origin;
  final LocationDto location;
  final List<String> episode;

  const CharacterDto({
    this.id = 0,
    this.name = '',
    this.status = '',
    this.species = '',
    this.type = '',
    this.gender = '',
    this.image = '',
    this.origin = const OriginDto(),
    this.location = const LocationDto(),
    this.episode = const [],
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);
}

@JsonSerializable()
class OriginDto {
  final String name;
  final String url;

  const OriginDto({
    this.name = '',
    this.url = '',
  });

  factory OriginDto.fromJson(Map<String, dynamic> json) =>
      _$OriginDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OriginDtoToJson(this);
}

@JsonSerializable()
class LocationDto {
  final String name;
  final String url;

  const LocationDto({
    this.name = '',
    this.url = '',
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}

@JsonSerializable()
class CharacterResponseDto {
  final InfoDto info;
  final List<CharacterDto> results;

  const CharacterResponseDto({
    this.info = const InfoDto(),
    this.results = const [],
  });

  factory CharacterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterResponseDtoToJson(this);
}
