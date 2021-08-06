part of 'services.dart';

class RestaurantServices {
  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final data = await rootBundle.rootBundle
          .loadString('assets/local_restaurant.json');
      LocalRestaurant list = LocalRestaurant.fromRawJson(data);
      print('success');
      return list.restaurants;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
