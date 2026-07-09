import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DioHttpClient extends http.BaseClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final options = Options(
      responseType: ResponseType.stream,
      method: request.method,
      headers: request.headers,
    );

    final Object? data;
    if (request is http.Request) {
      data = request.bodyBytes.isNotEmpty ? request.bodyBytes : null;
    } else if (request is http.MultipartRequest) {
      throw UnimplementedError('Multipart requests are not supported');
    } else {
      data = null;
    }

    final response = await _dio.request<ResponseBody>(
      request.url.toString(),
      data: data,
      options: options,
    );

    final responseBody = response.data;
    if (responseBody == null) {
      throw StateError(
        'Dio returned an empty response body for ${request.url}',
      );
    }

    final headers = <String, String>{};
    responseBody.headers.forEach((name, values) {
      if (values.isNotEmpty) {
        headers[name] = values.first;
      }
    });

    return http.StreamedResponse(
      responseBody.stream,
      responseBody.statusCode,
      contentLength: responseBody.contentLength,
      headers: headers,
      isRedirect: responseBody.isRedirect,
      reasonPhrase: responseBody.statusMessage,
      request: request,
    );
  }
}
