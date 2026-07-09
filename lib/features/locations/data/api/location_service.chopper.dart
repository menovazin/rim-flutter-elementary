// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'location_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$LocationService extends LocationService {
  _$LocationService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = LocationService;

  @override
  Future<Response<LocationResponseDto>> getLocations(int page) {
    final Uri $url = Uri.parse('/location');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<LocationResponseDto, LocationResponseDto>($request);
  }
}
