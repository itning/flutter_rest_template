import 'dart:collection';

class HttpHeaders {
  final Map<String, List<String>> _map;

  HttpHeaders() : _map = caseInsensitiveKeyMap<List<String>>();

  HttpHeaders.fromMap(Map<String, List<String>> map)
      : _map = caseInsensitiveKeyMap<List<String>>(
          map.map((k, v) => MapEntry(k.trim().toLowerCase(), v)),
        );

  List<String>? operator [](String name) {
    return _map[name.trim().toLowerCase()];
  }

  String? getFirst(String name) {
    List<String>? values = _map[name.trim().toLowerCase()];
    if (null == values || values.isEmpty) {
      return null;
    } else {
      return values[0];
    }
  }

  Map<String, List<String>> toMap() {
    return _map;
  }

  Map<String, String> toSingleValueMap() {
    Map<String, String> result = HashMap();
    _map.forEach((key, value) {
      result[key] = value.reduce((value, element) => "$value,$element");
    });
    return result;
  }

  void addAll(Map<String, List<String>> map) {
    map.forEach((key, value) {
      set(key, value);
    });
  }

  void add(String name, String value) {
    var arr = this[name];
    if (arr == null) return set(name, value);
    arr.add(value);
  }

  void set(String name, dynamic value) {
    name = name.trim().toLowerCase();
    if (value is List) {
      _map[name] = value.map<String>((e) => e.toString()).toList();
    } else {
      _map[name] = [value.trim()];
    }
  }

  void remove(String name, String value) {
    var arr = this[name];
    if (arr == null) return;
    arr.removeWhere((v) => v == value);
  }

  void removeAll(String name) {
    _map.remove(name);
  }

  void clear() {
    _map.clear();
  }

  @override
  String toString() {
    var stringBuffer = StringBuffer();
    _map.forEach((key, value) {
      for (var e in value) {
        stringBuffer.writeln('$key: $e');
      }
    });
    return stringBuffer.toString();
  }
}

Map<String, V> caseInsensitiveKeyMap<V>([Map<String, V>? value]) {
  final map = LinkedHashMap<String, V>(
    equals: (key1, key2) => key1.toLowerCase() == key2.toLowerCase(),
    hashCode: (key) => key.toLowerCase().hashCode,
  );
  if (value != null && value.isNotEmpty) map.addAll(value);
  return map;
}
