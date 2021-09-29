import 'package:flutter_rest_template/response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_rest_template/flutter_rest_template.dart';

void main() async {
  // test('adds one to input values', () {
  //   final calculator = Calculator();
  //   expect(calculator.addOne(2), 3);
  //   expect(calculator.addOne(-7), -6);
  //   expect(calculator.addOne(0), 1);
  // });
  test("run", () async {
    RestTemplate a = RestTemplate();
    ResponseEntity<String?> responseEntity =
        await a.getForEntry((responseMap) => null);
  });
}
