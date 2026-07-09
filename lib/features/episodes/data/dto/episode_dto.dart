import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/dto/info_dto.dart';

part 'episode_dto.freezed.dart';
part 'episode_dto.g.dart';

@freezed
abstract class EpisodeDto with _$EpisodeDto {
  const factory EpisodeDto({
    @Default(0) int id,
    @Default('') String name,
    @Default('') @JsonKey(name: 'air_date') String airDate,
    @Default('') String episode,
    @Default(<String>[]) List<String> characters,
  }) = _EpisodeDto;

  factory EpisodeDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeDtoFromJson(json);
}

@freezed
abstract class EpisodeResponseDto with _$EpisodeResponseDto {
  const factory EpisodeResponseDto({
    @Default(InfoDto()) InfoDto info,
    @Default(<EpisodeDto>[]) List<EpisodeDto> results,
  }) = _EpisodeResponseDto;

  factory EpisodeResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EpisodeResponseDtoFromJson(json);
}
