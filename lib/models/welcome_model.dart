import 'dart:convert';

import 'package:foodzilla/models/restaurant_model.dart';

class WelcomeRestaurant {
  WelcomeRestaurant({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory WelcomeRestaurant.fromRawJson(String str) =>
      WelcomeRestaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WelcomeRestaurant.fromJson(Map<String, dynamic> json) =>
      WelcomeRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}
