class FoodzillaTransaction {
  final String userId;
  final String name;
  final String restaurant;
  final String email;
  final int? phone;
  final int bookingCode;
  final int timeInMilliseccondEpoch;

  FoodzillaTransaction(
      {required this.userId,
      required this.name,
      required this.restaurant,
      required this.email,
      required this.phone,
      required this.bookingCode,
      required this.timeInMilliseccondEpoch});
}
