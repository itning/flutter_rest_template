library flutter_rest_template;

import 'dart:typed_data';

import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/client_http_request_factory.dart';
import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/response_entity.dart';

/// 响应转换函数
/// 在flutter中已经禁用反射：
/// https://github.com/flutter/flutter/issues/1150
typedef ResponseConversion<T> = T? Function(Uint8List responseBytes);

/// 实例应该被共享
class RestTemplate {
  final ClientHttpRequestFactory _clientHttpRequestFactory;

  RestTemplate(this._clientHttpRequestFactory);

  /// GET请求
  Future<T?> getForMap<T>(ResponseConversion<T> responseConversion,
      {Uri? uri, String? uriString}) async {
    assert(uri != null || uriString != null);
    if (uriString != null) {
      uri = Uri.parse(uriString);
    }
    ClientHttpResponse response = await _doExecute(uri!, HttpMethod.GET, null);
    Uint8List? body = response.getBody();
    if (null != body) {
      return responseConversion(body);
    }
    return null;
  }

  Future<ResponseEntity<T>> getForEntry<T>(
      ResponseConversion<T> responseConversion,
      {Uri? uri,
      String? uriString}) async {
    assert(uri != null || uriString != null);
    if (uriString != null) {
      uri = Uri.parse(uriString);
    }
    ClientHttpResponse response = await _doExecute(uri!, HttpMethod.GET, null);
    Uint8List? body = response.getBody();
    T? data;
    if (null != body) {
      data = responseConversion(body);
    }
    return ResponseEntity(response.getStatusCode(),
        body: data, headers: response.getHeaders());
  }

  Future<ClientHttpResponse> _doExecute<T>(
      Uri uri, HttpMethod httpMethod, request) async {
    ClientHttpRequest request =
        _clientHttpRequestFactory.createRequest(uri, httpMethod);
    return await request.execute();
  }
}
