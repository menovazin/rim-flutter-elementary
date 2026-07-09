import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/app_error.dart';
import '../../../../services/error_handler.dart';
import '../../../common/domain/model/page_result.dart';
import '../../domain/contract/episode_repository.dart';
import '../../domain/model/episode.dart';
import '../api/episode_service.dart';
import '../converter/episode_mapper.dart';

@LazySingleton(as: IEpisodeRepository)
class EpisodeRepository implements IEpisodeRepository {
  final EpisodeService _service;
  final IErrorHandler _errorHandler;

  EpisodeRepository(this._service, this._errorHandler);

  @override
  Future<PageResult<Episode>> getEpisodes(int page) async {
    try {
      final dto = await _service.getEpisodes(page);

      return PageResult<Episode>(
        items: mapEpisodeList(dto.results),
        page: page,
        totalPages: dto.info.pages,
        hasNext: dto.info.next != null,
      );
    } on DioException catch (e) {
      throw AppException(_errorHandler.map(e));
    }
  }
}
