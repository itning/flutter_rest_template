import 'package:flutter/foundation.dart';
import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_headers.dart';

abstract class AbstractClientHttpRequest implements ClientHttpRequest {
  final HttpHeaders _headers = HttpHeaders();

  bool _executed = false;

  HttpHeaders? _readOnlyHeaders;

  List<int>? body;

  @nonVirtual
  @override
  HttpHeaders getHeaders() {
    if (_readOnlyHeaders != null) {
      return _readOnlyHeaders!;
    } else if (_executed) {
      //this.readOnlyHeaders = HttpHeaders.readOnlyHttpHeaders(this.headers);
      _readOnlyHeaders = _headers;
      return _readOnlyHeaders!;
    } else {
      return _headers;
    }
  }

  @nonVirtual
  @override
  void setBody(List<int> bytes) {
    body = bytes;
  }

  @nonVirtual
  @override
  Future<ClientHttpResponse> execute() async {
    assert(!_executed);
    ClientHttpResponse result = await executeInternal(_headers, body);
    _executed = true;
    return result;
  }

  Future<ClientHttpResponse> executeInternal(
      HttpHeaders headers, List<int>? body);
}
