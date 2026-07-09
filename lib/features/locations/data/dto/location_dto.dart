import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/dto/info_dto.dart';

part 'location_dto.freezed.dart';
part 'location_dto.g.dart';

@freezed
abstract class LocationDto with _$LocationDto {
  const factory LocationDto({
    @Default(0) int id,
    @Default('') String name,
    @Default('') String type,
    @Default('') String dimension,
    @Default(<String>[]) List<String> residents,
  }) = _LocationDto;

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
}

@freezed
abstract class LocationResponseDto with _$LocationResponseDto {
  const factory LocationResponseDto({
    @Default(InfoDto()) InfoDto info,
    @Default(<LocationDto>[]) List<LocationDto> results,
  }) = _LocationResponseDto;

  factory LocationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseDtoFromJson(json);
}
