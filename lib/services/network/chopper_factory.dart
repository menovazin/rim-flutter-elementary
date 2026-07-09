import 'package:chopper/chopper.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'dio_http_client.dart';
import 'typed_json_converter.dart';

@module
abstract class ChopperFactory {
  @lazySingleton
  ChopperClient create(Dio dio) {
    return ChopperClient(
      baseUrl: Uri.parse(dio.options.baseUrl),
      client: DioHttpClient(dio),
      converter: const TypedJsonConverter.withDefaults(),
    );
  }
}
