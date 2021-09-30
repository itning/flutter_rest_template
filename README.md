# RestTemplate在Dart语言Flutter上的实现

[![Hits](https://hitcount.itning.top?u=itning&r=itning)](https://github.com/itning/hit-count)

## Features

封装Http请求，使上层使用感知不到下层的实现。

默认实现为：Dio

## Getting started

`git clone https://github.com/itning/flutter_rest_template.git`

```yaml
dependencies:
  a:
    path: ../flutter_rest_template
```

## Usage

```dart
DioClientHttpRequestFactory factory = DioClientHttpRequestFactory(Dio());
RestTemplate restTemplate = RestTemplate(factory);

ResponseEntity<Map<String, dynamic>> responseEntity = await restTemplate
       .getForEntry(RestTemplate.mapResponseConversion,
            uriString: "https://jsonplaceholder.typicode.com/todos/1",
            acceptMediaTypes: [MediaType.applicationJson]);
```

## Additional information

Nothing...
