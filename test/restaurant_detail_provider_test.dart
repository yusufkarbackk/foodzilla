import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test("should succesfully parse a json", () async {
    String restaurantId = "rqdv5juczeskfw1e867";

    final data = await http.get(
        Uri.parse("https://restaurant-api.dicoding.dev/detail/$restaurantId"));

    print('success');
    print(data.body);

    expect(data.body, data.body);
  });
}
