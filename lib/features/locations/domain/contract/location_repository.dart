import '../../../common/domain/model/page_result.dart';
import '../model/location.dart';

abstract interface class ILocationRepository {
  Future<PageResult<Location>> getLocations(int page);
}
