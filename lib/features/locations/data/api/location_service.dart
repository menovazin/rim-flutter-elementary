import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/location_dto.dart';

part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  factory LocationService(Dio dio, {String? baseUrl}) = _LocationService;

  @GET('')
  Future<LocationResponseDto> getLocations(@Query('page') int page);
}
