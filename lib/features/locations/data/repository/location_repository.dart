import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/app_error.dart';
import '../../../../services/error_handler.dart';
import '../../../common/domain/model/page_result.dart';
import '../../domain/contract/location_repository.dart';
import '../../domain/model/location.dart';
import '../api/location_service.dart';
import '../converter/location_mapper.dart';

@LazySingleton(as: ILocationRepository)
class LocationRepository implements ILocationRepository {
  final LocationService _service;
  final IErrorHandler _errorHandler;

  LocationRepository(this._service, this._errorHandler);

  @override
  Future<PageResult<Location>> getLocations(int page) async {
    try {
      final response = await _service.getLocations(page);
      final body = response.body;

      if (body == null) {
        throw AppException(const AppError.server());
      }

      return PageResult<Location>(
        items: mapLocationList(body.results),
        page: page,
        totalPages: body.info.pages,
        hasNext: body.info.next != null,
      );
    } on DioException catch (e) {
      throw AppException(_errorHandler.map(e));
    }
  }
}
