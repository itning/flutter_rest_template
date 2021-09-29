enum HttpMethod { GET, POST }

extension HttpMethodToString on HttpMethod {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
