import 'package:flutter_test/flutter_test.dart';
import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:http/http.dart' as http;

void main() {
  test("should succesfully parse a json", () async {
    String restaurantId = "rqdv5juczeskfw1e867";

    final data = await http.get(
        Uri.parse("https://restaurant-api.dicoding.dev/detail/$restaurantId"));
    WelcomeRestaurantDetail restaurant =
        WelcomeRestaurantDetail.fromRawJson(data.body);
    print('success');

    expect(restaurant.restaurant, restaurant.restaurant);
  });
}
