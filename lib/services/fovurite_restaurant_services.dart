part of 'services.dart';

class FavouriteRestaurantServices extends ChangeNotifier {
  bool? _isFavourite;

  bool get isFavourite => _isFavourite!;
  bool get reversedIsFavourite => !_isFavourite!;

  static CollectionReference _favouriteCollection =
      FirebaseFirestore.instance.collection("Favourite Restaurant");

  CollectionReference get getFavouriteCollection => _favouriteCollection;

  set setIsfavourite(bool value) {
    _isFavourite = value;
  }

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

  static Stream<QuerySnapshot> getFavourites(String userId) {
    Stream<QuerySnapshot> snapshot =
        _favouriteCollection.where("userId", isEqualTo: userId).snapshots();

    return snapshot;
  }

  static Future<void> deleteFavourite(
      String restaurantId, String userId) async {
    var userDocument = await _favouriteCollection
        .where(
          "userId",
          isEqualTo: userId,
        )
        .get();

    for (var item in userDocument.docs) {
      if ((item.data() as dynamic)['restaurant_id'] == restaurantId) {
        item.reference.delete();
      }
    }
  }

  Future<void> checkIsFavourited(String restaurantId, String userId) async {
    var userDocs = await _favouriteCollection
        .where(
          "userId",
          isEqualTo: userId,
        )
        .get();

    for (var item in userDocs.docs) {
      if ((item.data() as dynamic)['restaurant_id'] == restaurantId) {
        _isFavourite = true;
      } else {
        _isFavourite = false;
      }
    }
  }
}
