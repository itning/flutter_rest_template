import 'package:dio/dio.dart';
import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/client_http_request_factory.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/impl/dio_client_http_request.dart';

class DioClientHttpRequestFactory implements ClientHttpRequestFactory {
  Dio _client;

  DioClientHttpRequestFactory(this._client);

  @override
  ClientHttpRequest createRequest(Uri uri, HttpMethod httpMethod) {
    return DioClientHttpRequest(_client, uri, httpMethod);
  }
}
