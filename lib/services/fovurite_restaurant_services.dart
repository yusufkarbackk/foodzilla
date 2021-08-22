part of 'services.dart';

class FavouriteRestaurantServices {
  List<String> _favouriedRestaurant = [];

  List<String> get getFavouritedRestaurantName => _favouriedRestaurant;

  static CollectionReference _favouriteCollection =
      FirebaseFirestore.instance.collection("Favourite Restaurant");

  static Future<String> addFavourite(
      RestaurantDetail restaurant, String userId) async {
    try {
      await _favouriteCollection.doc().set({
        "userId": userId,
        "restaurant_id": restaurant.id,
        "name": restaurant.name,
        "rating": restaurant.rating,
        "imageURL": restaurant.pictureId,
        "city": restaurant.city
      });
      return "success";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<QuerySnapshot> getFavourites(String userId) async {
    QuerySnapshot snapshot =
        await _favouriteCollection.where("userId", isEqualTo: userId).get();

    return snapshot;
  }

  static Future<void> deleteFavourite(String restaurantId) async {
    var result = await _favouriteCollection
        .where("restaurant_id", isEqualTo: restaurantId)
        .get();

    for (var doc in result.docs) {
      await doc.reference.delete();
    }
  }
}
