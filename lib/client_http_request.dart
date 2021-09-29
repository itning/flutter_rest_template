import 'package:flutter_rest_template/client_http_response.dart';
import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/http_method.dart';

abstract class ClientHttpRequest {
  Future<ClientHttpResponse> execute();

  Uri getURI();

  HttpMethod getMethod();

  HttpHeaders getHeaders();

  getBody();
}
