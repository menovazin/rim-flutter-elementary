import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/episode_dto.dart';

part 'episode_service.g.dart';

@RestApi()
abstract class EpisodeService {
  factory EpisodeService(Dio dio, {String? baseUrl}) = _EpisodeService;

  @GET('')
  Future<EpisodeResponseDto> getEpisodes(@Query('page') int page);
}
