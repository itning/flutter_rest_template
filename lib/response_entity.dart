import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/http_status.dart';

class ResponseEntity<T> {
  T? body;
  late HttpHeaders headers;
  HttpStatus status;

  ResponseEntity(this.status, {this.body, HttpHeaders? headers}) {
    if (null == headers) {
      this.headers = HttpHeaders();
    } else {
      this.headers = headers;
    }
  }

  @override
  String toString() {
    StringBuffer builder = StringBuffer("<");
    builder.write(status);
    builder.write(',');
    if (body != null) {
      builder.write(body);
      builder.write(',');
    }
    builder.write(headers);
    builder.write('>');
    return builder.toString();
  }
}
