import 'dart:convert';

import 'package:foodzilla/models/restaurant_model.dart';

class LocalRestaurant {
  LocalRestaurant({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory LocalRestaurant.fromRawJson(String str) =>
      LocalRestaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LocalRestaurant.fromJson(Map<String, dynamic> json) =>
      LocalRestaurant(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
