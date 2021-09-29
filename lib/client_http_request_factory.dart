import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/http_method.dart';

abstract class ClientHttpRequestFactory {
  ClientHttpRequest createRequest(Uri uri, HttpMethod httpMethod);
}
