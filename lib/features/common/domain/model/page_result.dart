import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_result.freezed.dart';

@Freezed(copyWith: false, equal: true)
abstract class PageResult<T> with _$PageResult<T> {
  const factory PageResult({
    required List<T> items,
    required int page,
    required int totalPages,
    required bool hasNext,
  }) = _PageResult<T>;
}
