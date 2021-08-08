part of 'services.dart';

class TransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection("Foodzilla transactions");

  static Future<String> storeTransaction(
      FoodzillaTransaction transaction, String userId) async {
    try {
      await _transactionCollection.doc().set({
        "userId": userId,
        "name": transaction.name,
        "restaurant": transaction.restaurant,
        "email": transaction.email,
        "phone": transaction.phone,
        "booking_code": transaction.bookingCode,
        "date": transaction.date,
        "time": transaction.time,
        "time_in_milliseccondEpoch": transaction.timeInMilliseccondEpoch
      });
      return "success";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<QuerySnapshot> getTransaction(String userId) async {
    QuerySnapshot snapshot =
        await _transactionCollection.where("userId", isEqualTo: userId).get();

    return snapshot;
  }
}
