import 'package:flutter_rest_template/http_headers.dart';

class HttpEntity<T> {
  static HttpEntity empty = HttpEntity();

  final T? body;
  final HttpHeaders httpHeaders = HttpHeaders();

  HttpEntity.of({this.body});

  HttpEntity({this.body, Map<String, List<String>>? headers}) {
    if (null != headers) {
      httpHeaders.addAll(headers);
    }
  }
}
