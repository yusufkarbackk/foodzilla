part of 'services.dart';

class UserServices extends ChangeNotifier {
  late FoodzillaUser foodzillaUser;

  static CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Foodzilla users");

  static Future<void> storeUser(FoodzillaUser user) async {
    _userCollection.doc(user.id).set({
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "phone": user.phone
    });
  }

  static Future<FoodzillaUser> getUser(String userId) async {
    DocumentSnapshot snapshot = await _userCollection.doc(userId).get();

    return FoodzillaUser(
        id: userId,
        name: (snapshot.data() as dynamic)['name'],
        email: (snapshot.data() as dynamic)['email'],
        phone: (snapshot.data() as dynamic)['phone']);
  }

  static Future<String> uploadImage(File imageFile) async {
    Future<String>? downloadURL;
    String fileName = basename(imageFile.path);
    Reference ref = FirebaseStorage.instance.ref().child(fileName);
    UploadTask task = ref.putFile(imageFile);
    await task.whenComplete(() {
      downloadURL = ref.getDownloadURL();
    });
    return downloadURL!;
  }
}
