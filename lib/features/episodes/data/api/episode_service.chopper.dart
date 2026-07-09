// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'episode_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$EpisodeService extends EpisodeService {
  _$EpisodeService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = EpisodeService;

  @override
  Future<Response<EpisodeResponseDto>> getEpisodes(int page) {
    final Uri $url = Uri.parse('/episode');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<EpisodeResponseDto, EpisodeResponseDto>($request);
  }
}
