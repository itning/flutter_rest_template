import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_rest_template/abstract_client_http_request.dart';
import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/impl/dio_client_http_response.dart';

class DioClientHttpRequest extends AbstractClientHttpRequest {
  final Dio _client;
  final Uri _uri;
  final HttpMethod _httpMethod;

  DioClientHttpRequest(this._client, this._uri, this._httpMethod);

  @override
  HttpMethod getMethod() {
    return _httpMethod;
  }

  @override
  Uri getURI() {
    return _uri;
  }

  @override
  Future<ClientHttpResponse> executeInternal(
      HttpHeaders headers, List<int>? body) async {
    Response<List<int>> response = await _client.requestUri(_uri,
        data: body == null ? null : utf8.decode(body),
        options: Options(
            headers: headers.toSingleValueMap(),
            method: _httpMethod.name(),
            responseType: ResponseType.bytes));
    return DioClientHttpResponse(response);
  }
}
