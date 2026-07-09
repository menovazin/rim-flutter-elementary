import '../../../common/data/converter/url_id_extractor.dart';
import '../../domain/model/location.dart';
import '../dto/location_dto.dart';

Location mapLocation(LocationDto dto) {
  return Location(
    id: dto.id,
    name: dto.name,
    type: dto.type,
    dimension: dto.dimension,
    residentIds: extractIdsFromUrls(dto.residents),
  );
}

List<Location> mapLocationList(List<LocationDto> dtos) {
  return dtos.map(mapLocation).toList();
}
