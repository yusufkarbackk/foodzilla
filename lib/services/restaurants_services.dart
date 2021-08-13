part of 'services.dart';

class RestaurantServices {
  static Future<List<Restaurant>> getRestaurants() async {
    try {
      final data =
          await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));
      WelcomeRestaurant list = WelcomeRestaurant.fromRawJson(data.body);
      print('success');
      return list.restaurants;
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final data =
        await http.get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
    WelcomeRestaurantDetail restaurant =
        WelcomeRestaurantDetail.fromRawJson(data.body);
    print('success');
    return restaurant.restaurant;
  }

  static getRestaurantLocation(String url, BuildContext context) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Flushbar(
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
        message: "Seems like the page that you were\nrequested is already gone",
      )..show(context);
    }
  }
}
