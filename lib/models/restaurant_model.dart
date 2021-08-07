import 'dart:convert';
import 'package:foodzilla/models/menu_model.dart';

class Restaurant {
  final String id;
  final String name;
  final String desc;
  final String imageURL;
  final String city;
  final double rating;
  final Menus menus;
  final String openHour;

  Restaurant(
      {required this.id,
      required this.name,
      required this.desc,
      required this.imageURL,
      required this.city,
      required this.rating,
      required this.menus,
      required this.openHour});

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      desc: json["description"],
      imageURL: json["pictureId"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      menus: Menus.fromJson(json["menus"]),
      openHour: json["opening_hour"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": desc,
        "pictureId": imageURL,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
        "opening_hour": openHour
      };
}
