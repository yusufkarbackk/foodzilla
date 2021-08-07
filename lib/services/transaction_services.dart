part of 'services.dart';

class TransactionServices {
  static CollectionReference _transactionCollection =
      FirebaseFirestore.instance.collection("Foodzilla transactions");

  static Future<void> storeTransaction(
      FoodzillaTransaction transaction, String userId) async {
    await _transactionCollection.doc().set({
      "userId": userId,
      "name": transaction.name,
      "restaurant": transaction.restaurant,
      "email": transaction.email,
      "phone": transaction.phone,
      "booking_code": transaction.bookingCode,
      "time_in_milliseccondEpoch": transaction.timeInMilliseccondEpoch
    });
  }
}
