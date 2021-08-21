import 'package:flutter/foundation.dart';
import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:foodzilla/services/database_helper.dart';

class DbProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;
  List<RestaurantDetail> _restaruants = [];

  List<RestaurantDetail> get getFavouritesRestaurant => _restaruants;

  void _getAllFavouriteRestaurants() async {
    _restaruants = await _dbHelper.getFavouritedRestaurants();
    notifyListeners();
  }

  Future<void> addNote(RestaurantDetail restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    _getAllFavouriteRestaurants();
  }

  void deleteRestaurant(String id) async {
    await _dbHelper.deleteRestaurant(id);
    _getAllFavouriteRestaurants();
  }

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavouriteRestaurants();
  }
}
