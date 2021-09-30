enum HttpMethod { GET, POST }

extension HttpMethodToString on HttpMethod {
  String name() {
    return toString().split('.').last;
  }
}
