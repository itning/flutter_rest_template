import 'dart:convert';

import 'package:flutter_rest_template/accept_header_request_callback.dart';
import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/http_entity.dart';
import 'package:flutter_rest_template/media_type.dart';

class HttpEntityRequestCallback extends AcceptHeaderRequestCallback {
  late final HttpEntity requestEntity;

  HttpEntityRequestCallback(request, List<MediaType> mediaTypes)
      : super(mediaTypes) {
    if (request is HttpEntity) {
      requestEntity = request;
    } else if (request != null) {
      requestEntity = HttpEntity(body: request);
    } else {
      requestEntity = HttpEntity.empty;
    }
  }

  @override
  void doWithRequest(ClientHttpRequest request) {
    super.doWithRequest(request);
    if (requestEntity.body == null) {
      request.getHeaders().addAll(requestEntity.httpHeaders.toMap());
      String? length = request.getHeaders().getFirst("Content-Length");
      if (null == length) {
        request.getHeaders().set("Content-Length", 0);
      } else {
        num? l = num.tryParse(length);
        if (null == l || l < 0) {
          request.getHeaders().set("Content-Length", 0);
        }
      }
    } else {
      request.getHeaders().addAll(requestEntity.httpHeaders.toMap());
      if (requestEntity.body is String) {
        request
            .getHeaders()
            .set("Content-Type", MediaType.textPlain.toString());
        request.setBody(utf8.encode(requestEntity.body as String));
      } else if (requestEntity.body is Map) {
        request
            .getHeaders()
            .set("Content-Type", MediaType.applicationJson.toString());
        String json = jsonEncode(requestEntity.body);
        request.setBody(utf8.encode(json));
      } else {
        throw UnsupportedError('不支持的请求体 ${requestEntity.body}');
      }
    }
  }
}
