import 'package:chopper/chopper.dart';

import '../dto/episode_dto.dart';

part 'episode_service.chopper.dart';

@ChopperApi(baseUrl: '/episode')
abstract class EpisodeService extends ChopperService {
  static EpisodeService create([ChopperClient? client]) =>
      _$EpisodeService(client);

  @GET()
  Future<Response<EpisodeResponseDto>> getEpisodes(@Query() int page);
}
