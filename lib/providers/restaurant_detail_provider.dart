import 'package:flutter/foundation.dart';
import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:http/http.dart' as http;

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  RestaurantDetail? _restaurantDetail;
  String message = "";
  ResultState _state = ResultState.Loading;

  RestaurantDetail? get getRestaurantDetail => _restaurantDetail;
  ResultState get getState => _state;
  String get getMessage => message;

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final data = await http
          .get(Uri.parse("https://restaurant-api.dicoding.dev/detail/$id"));
      WelcomeRestaurantDetail restaurant =
          WelcomeRestaurantDetail.fromRawJson(data.body);
      _state = ResultState.HasData;
      print('success');

      notifyListeners();
      return _restaurantDetail = restaurant.restaurant;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return message = 'Error => $e';
    }
  }
}
