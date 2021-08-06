part of 'services.dart';

class AuthServices {
  static FirebaseAuth mAuth = FirebaseAuth.instance;

  static Future<AuthResult> signIn(String email, String password) async {
    try {
      UserCredential result = await mAuth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      return AuthResult(message: null, user: user);
    } catch (e) {
      return AuthResult(user: null, message: e.toString().split(']')[1]);
    }
  }

  static Future<AuthResult> signUp(
      String name, String email, String password, int? phone) async {
    try {
      UserCredential result = await mAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      FoodzillaUser foodzillaUser = FoodzillaUser(
          id: result.user!.uid, name: name, email: email, phone: phone);
      await UserServices.storeUser(foodzillaUser);

      User? user = result.user;
      return AuthResult(user: user, message: null);
    } catch (e) {
      return AuthResult(user: null, message: e.toString().split(']')[1]);
    }
  }

  static Future<void> signOut(context) async {
    final User? firebaseUser = mAuth.currentUser;

    if (firebaseUser != null) {
      FirebaseAuth.instance.signOut().then((value) => {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (route) => false)
          });
    }
  }

  static Stream<User?> get firebaseUserStream {
    return mAuth.authStateChanges();
  }
}

class AuthResult {
  late final User? user;
  late final String? message;

  AuthResult({required this.user, required this.message});
}
