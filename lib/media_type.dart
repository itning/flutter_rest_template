class MediaType {
  static MediaType all = MediaType.ofType("*");
  static MediaType applicationJson =
      MediaType.ofCharset("application", "json", "UTF-8");
  static MediaType textPlain = MediaType.ofCharset("text", "plain", "UTF-8");

  String type;

  String subtype;

  Map<String, String> parameters;

  MediaType(this.type, this.subtype, this.parameters);

  MediaType.of(this.type, this.subtype) : parameters = {};

  MediaType.ofType(this.type)
      : subtype = "*",
        parameters = {};

  MediaType.ofCharset(this.type, this.subtype, String charset)
      : parameters = {"charset": charset};

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    _appendTo(buffer);
    return buffer.toString();
  }

  void _appendTo(StringBuffer buffer) {
    buffer.write(type);
    buffer.write('/');
    buffer.write(subtype);
    _appendToByMap(parameters, buffer);
  }

  void _appendToByMap(Map<String, String> map, StringBuffer buffer) {
    map.forEach((key, value) {
      buffer.write(';');
      buffer.write(key);
      buffer.write('=');
      buffer.write(value);
    });
  }
}
