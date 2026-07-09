import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/app_error.dart';
import '../../../../services/error_handler.dart';
import '../../../common/domain/model/page_result.dart';
import '../../domain/contract/character_repository.dart';
import '../../domain/model/character.dart';
import '../api/character_service.dart';
import '../converter/character_mapper.dart';

@LazySingleton(as: ICharacterRepository)
class CharacterRepository implements ICharacterRepository {
  final CharacterService _service;
  final IErrorHandler _errorHandler;

  CharacterRepository(this._service, this._errorHandler);

  @override
  Future<PageResult<Character>> getCharacters(int page) async {
    try {
      final response = await _service.getCharacters(page);
      final body = response.body;

      if (body == null) {
        throw AppException(const AppError.server());
      }

      return PageResult<Character>(
        items: mapCharacterList(body.results),
        page: page,
        totalPages: body.info.pages,
        hasNext: body.info.next != null,
      );
    } on DioException catch (e) {
      throw AppException(_errorHandler.map(e));
    }
  }
}
