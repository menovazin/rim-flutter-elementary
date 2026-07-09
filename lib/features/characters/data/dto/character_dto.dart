import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/dto/info_dto.dart';

part 'character_dto.freezed.dart';
part 'character_dto.g.dart';

@freezed
abstract class CharacterDto with _$CharacterDto {
  const factory CharacterDto({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String status,
    @Default('') String species,
    @Default('') String type,
    @Default('') String gender,
    @Default('') String image,
    @Default(OriginDto()) OriginDto origin,
    @Default(LocationDto()) LocationDto location,
    @Default(<String>[]) List<String> episode,
  }) = _CharacterDto;

  factory CharacterDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterDtoFromJson(json);
}

@freezed
abstract class OriginDto with _$OriginDto {
  const factory OriginDto({
    @Default('') String name,
    @Default('') String url,
  }) = _OriginDto;

  factory OriginDto.fromJson(Map<String, dynamic> json) =>
      _$OriginDtoFromJson(json);
}

@freezed
abstract class LocationDto with _$LocationDto {
  const factory LocationDto({
    @Default('') String name,
    @Default('') String url,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}

@freezed
abstract class CharacterResponseDto with _$CharacterResponseDto {
  const factory CharacterResponseDto({
    @Default(InfoDto()) InfoDto info,
    @Default(<CharacterDto>[]) List<CharacterDto> results,
  }) = _CharacterResponseDto;

  factory CharacterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseDtoFromJson(json);
}
