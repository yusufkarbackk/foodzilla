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
