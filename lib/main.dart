import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzilla/services/services.dart';
import 'package:foodzilla/shared/constants.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      initialData: FirebaseAuth.instance.currentUser,
      child: ChangeNotifierProvider(
        create: (context) => UserServices(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue, textTheme: myTextTheme),
          home: Wrapper(),
        ),
      ),
    );
  }
}