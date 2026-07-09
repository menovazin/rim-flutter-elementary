import 'package:chopper/chopper.dart';

import '../dto/location_dto.dart';

part 'location_service.chopper.dart';

@ChopperApi(baseUrl: '/location')
abstract class LocationService extends ChopperService {
  static LocationService create([ChopperClient? client]) =>
      _$LocationService(client);

  @GET()
  Future<Response<LocationResponseDto>> getLocations(@Query() int page);
}
