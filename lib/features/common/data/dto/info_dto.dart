import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_dto.freezed.dart';
part 'info_dto.g.dart';

@freezed
abstract class InfoDto with _$InfoDto {
  const factory InfoDto({
    @Default(0) int count,
    @Default(0) int pages,
    String? next,
    String? prev,
  }) = _InfoDto;

  factory InfoDto.fromJson(Map<String, dynamic> json) =>
      _$InfoDtoFromJson(json);
}
