import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_rest_template/flutter_rest_template.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/impl/dio_client_http_request_factory.dart';
import 'package:flutter_rest_template/response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  // });
  test("run", () async {
    expect(HttpMethod.GET.toShortString(), "GET");
  });

  test('', () async {
    DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
    RestTemplate restTemplate = RestTemplate(factory);
    ResponseEntity<String> responseEntity = await restTemplate.getForEntry(
        (responseBytes) => Utf8Decoder().convert(responseBytes),
        uriString: "http://www.baidu.com");
    print(responseEntity);
  });
}
