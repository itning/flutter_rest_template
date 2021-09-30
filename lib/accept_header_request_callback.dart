import 'package:flutter_rest_template/client_http_request.dart';
import 'package:flutter_rest_template/http_headers.dart';
import 'package:flutter_rest_template/media_type.dart';
import 'package:flutter_rest_template/request_call_back.dart';

class AcceptHeaderRequestCallback implements RequestCallback {
  List<MediaType> mediaTypes;

  AcceptHeaderRequestCallback(this.mediaTypes);

  @override
  void doWithRequest(ClientHttpRequest request) {
    HttpHeaders httpHeaders = request.getHeaders();
    for (MediaType mediaType in mediaTypes) {
      httpHeaders.add("accept", mediaType.toString());
    }
  }
}
