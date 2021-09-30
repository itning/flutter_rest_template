import 'package:flutter_rest_template/client_http_request.dart';

abstract class RequestCallback {
  void doWithRequest(ClientHttpRequest request);
}
