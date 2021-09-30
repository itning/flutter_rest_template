import 'dart:typed_data';

import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/http_status.dart';

abstract class ClientHttpResponse {
  HttpStatus getStatusCode();

  int getRawStatusCode();

  String getStatusText();

  HttpHeaders getHeaders();

  UnmodifiableUint8ListView? getBody();
}
