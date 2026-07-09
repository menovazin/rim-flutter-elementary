import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dto/character_dto.dart';

part 'character_service.g.dart';

@RestApi()
abstract class CharacterService {
  factory CharacterService(Dio dio, {String? baseUrl}) = _CharacterService;

  @GET('')
  Future<CharacterResponseDto> getCharacters(@Query('page') int page);

  @GET('/{ids}')
  Future<dynamic> getMultipleCharacters(@Path('ids') String ids);
}
