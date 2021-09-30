import 'package:dio/dio.dart';
import 'package:flutter_rest_template/flutter_rest_template.dart';
import 'package:flutter_rest_template/http_entity.dart';
import 'package:flutter_rest_template/http_method.dart';
import 'package:flutter_rest_template/impl/dio_client_http_request_factory.dart';
import 'package:flutter_rest_template/media_type.dart';
import 'package:flutter_rest_template/response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  test("HttpMethod#name", () async {
    expect(HttpMethod.GET.name(), "GET");
  });

  test('getForEntry', () async {
    DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
    RestTemplate restTemplate = RestTemplate(factory);

    ResponseEntity<Map<String, dynamic>> responseEntity = await restTemplate
        .getForEntry(RestTemplate.mapResponseConversion,
            uriString: "https://jsonplaceholder.typicode.com/todos/1",
            acceptMediaTypes: [MediaType.applicationJson]);

    expect(responseEntity.status.value, 200);
    expect(responseEntity.body == null, false);
    expect(responseEntity.body?['userId'], 1);
    expect(responseEntity.body?['id'], 1);
  });

  test('getForMapEntry', () async {
    DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
    RestTemplate restTemplate = RestTemplate(factory);

    ResponseEntity<Map<String, dynamic>> responseEntity = await restTemplate
        .getForMapEntry("https://jsonplaceholder.typicode.com/todos/1");

    expect(responseEntity.status.value, 200);
    expect(responseEntity.body == null, false);
    expect(responseEntity.body?['userId'], 1);
    expect(responseEntity.body?['id'], 1);
  });

  test('postForEntry', () async {
    DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
    RestTemplate restTemplate = RestTemplate(factory);

    ResponseEntity<Map<String, dynamic>> responseEntity =
        await restTemplate.postForEntry(RestTemplate.mapResponseConversion,
            uriString: "http://localhost:7865/a",
            request: HttpEntity(headers: {
              "aq": ['a']
            }, body: {
              'name': 'foo',
              'id': 1
            }),
            acceptMediaTypes: [MediaType.applicationJson]);

    print(responseEntity);
    // expect(responseEntity.status.value, 201);
    // expect(responseEntity.body == null, false);
    // expect(responseEntity.body?['userId'], 1);
    // expect(responseEntity.body?['id'], 101);
    // expect(responseEntity.body?['body'], 'bar');
    // expect(responseEntity.body?['title'], 'foo');
  });

  test('postForMapEntry', () async {
    DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
    RestTemplate restTemplate = RestTemplate(factory);

    ResponseEntity<Map<String, dynamic>> responseEntity =
        await restTemplate.postForMapEntry("http://localhost:7865/a",
            request: HttpEntity(headers: {
              "aq": ['a']
            }, body: {
              'name': 'foo',
              'id': 1
            }));

    print(responseEntity);
  });
}
