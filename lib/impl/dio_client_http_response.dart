import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/http_status.dart';

class DioClientHttpResponse implements ClientHttpResponse {
  final Response<List<int>> _response;

  DioClientHttpResponse(this._response);

  @override
  UnmodifiableUint8ListView? getBody() {
    List<int>? data = _response.data;
    if (null == data) {
      return null;
    }
    return UnmodifiableUint8ListView(Uint8List.fromList(data));
  }

  @override
  HttpHeaders getHeaders() {
    Headers headers = _response.headers;
    return HttpHeaders.fromMap(headers.map);
  }

  @override
  int getRawStatusCode() {
    return _response.statusCode ?? 0;
  }

  @override
  HttpStatus getStatusCode() {
    return HttpStatus(_response.statusCode ?? 0,
        reasonPhrase: _response.statusMessage);
  }

  @override
  String getStatusText() {
    return _response.statusMessage ?? '';
  }
}
