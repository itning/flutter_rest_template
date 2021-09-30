library flutter_rest_template;

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_rest_template/accept_header_request_callback.dart';
import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/client_http_request_factory.dart';
import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_entry_request_callback.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/media_type.dart';
import 'package:flutter_rest_template/request_call_back.dart';
import 'package:flutter_rest_template/response_entity.dart';

/// 响应转换函数
/// 在flutter中已经禁用反射：
/// https://github.com/flutter/flutter/issues/1150
typedef ResponseConversion<T> = T? Function(
    UnmodifiableUint8ListView responseBytes);

const Utf8Decoder utf8decoder = Utf8Decoder();

/// 实例应该被共享
class RestTemplate {
  final ClientHttpRequestFactory _clientHttpRequestFactory;

  RestTemplate(this._clientHttpRequestFactory);

  /// 转换成字符串
  static String stringResponseConversion(
          UnmodifiableUint8ListView responseBytes) =>
      utf8decoder.convert(responseBytes);

  /// 转换成MAP
  static Map<String, dynamic> mapResponseConversion(
          UnmodifiableUint8ListView responseBytes) =>
      json.decode(utf8decoder.convert(responseBytes));

  /// GET请求
  Future<T?> getForObject<T>(ResponseConversion<T> responseConversion,
      {Uri? uri, String? uriString, List<MediaType>? acceptMediaTypes}) async {
    assert(uri != null || uriString != null);
    uri = _toUri(uri, uriString);
    acceptMediaTypes ??= [MediaType.all];
    ClientHttpResponse response = await _doExecute(
        uri, HttpMethod.GET, AcceptHeaderRequestCallback(acceptMediaTypes));
    UnmodifiableUint8ListView? body = response.getBody();
    if (null != body) {
      return responseConversion(body);
    }
    return null;
  }

  /// GET请求
  Future<ResponseEntity<T>> getForEntry<T>(
      ResponseConversion<T> responseConversion,
      {Uri? uri,
      String? uriString,
      List<MediaType>? acceptMediaTypes}) async {
    assert(uri != null || uriString != null);
    uri = _toUri(uri, uriString);
    acceptMediaTypes ??= [MediaType.all];
    ClientHttpResponse response = await _doExecute(
        uri, HttpMethod.GET, AcceptHeaderRequestCallback(acceptMediaTypes));
    UnmodifiableUint8ListView? body = response.getBody();
    T? data;
    if (null != body) {
      data = responseConversion(body);
    }
    return ResponseEntity(response.getStatusCode(),
        body: data, headers: response.getHeaders());
  }

  /// POST请求
  Future<T?> postForObject<T>(ResponseConversion<T> responseConversion,
      {Uri? uri,
      String? uriString,
      request,
      List<MediaType>? acceptMediaTypes}) async {
    uri = _toUri(uri, uriString);
    acceptMediaTypes ??= [MediaType.all];
    ClientHttpResponse response = await _doExecute(uri, HttpMethod.POST,
        HttpEntityRequestCallback(request, acceptMediaTypes));
    UnmodifiableUint8ListView? body = response.getBody();
    if (null != body) {
      return responseConversion(body);
    }
    return null;
  }

  /// POST请求
  Future<ResponseEntity<T>> postForEntry<T>(
      ResponseConversion<T> responseConversion,
      {Uri? uri,
      String? uriString,
      request,
      List<MediaType>? acceptMediaTypes}) async {
    uri = _toUri(uri, uriString);
    acceptMediaTypes ??= [MediaType.all];
    ClientHttpResponse response = await _doExecute(uri, HttpMethod.POST,
        HttpEntityRequestCallback(request, acceptMediaTypes));
    UnmodifiableUint8ListView? body = response.getBody();
    T? data;
    if (null != body) {
      data = responseConversion(body);
    }
    return ResponseEntity(response.getStatusCode(),
        body: data, headers: response.getHeaders());
  }

  Future<ClientHttpResponse> _doExecute<T>(
      Uri uri, HttpMethod httpMethod, RequestCallback requestCallback) async {
    ClientHttpRequest clientHttpRequest =
        _clientHttpRequestFactory.createRequest(uri, httpMethod);
    requestCallback.doWithRequest(clientHttpRequest);
    return await clientHttpRequest.execute();
  }

  Uri _toUri(Uri? uri, String? uriString) {
    if (uriString != null) {
      uri = Uri.parse(uriString);
    }
    return uri!;
  }
}
