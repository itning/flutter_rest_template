library flutter_rest_template;

import 'package:flutter_rest_template/http_status.dart';
import 'package:flutter_rest_template/response_entity.dart';

/// 响应转换函数
/// 在flutter中已经禁用反射：
/// https://github.com/flutter/flutter/issues/1150
typedef ResponseConversion<T> = T? Function(Map<String, dynamic> responseMap);

///
class RestTemplate {
  Future<Map<String, dynamic>?> getForMap() async {
    return null;
  }

  Future<ResponseEntity<T>> getForEntry<T>(
      ResponseConversion<T> responseConversion,
      {Uri? uri,
      String? uriString}) async {
    assert(uri != null || uriString != null);
    T? a = responseConversion({});
    return ResponseEntity(HttpStatus(200), body: a);
  }
}
