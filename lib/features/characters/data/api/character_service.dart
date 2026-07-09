import 'package:chopper/chopper.dart';

import '../dto/character_dto.dart';

part 'character_service.chopper.dart';

@ChopperApi(baseUrl: '/character')
abstract class CharacterService extends ChopperService {
  static CharacterService create([ChopperClient? client]) =>
      _$CharacterService(client);

  @GET()
  Future<Response<CharacterResponseDto>> getCharacters(@Query() int page);
}
