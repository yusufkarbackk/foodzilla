import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodzilla/providers/date_time_provider.dart';
import 'package:foodzilla/providers/restaurant_detail_provider.dart';
import 'package:foodzilla/providers/restaurant_provider.dart';
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      initialData: FirebaseAuth.instance.currentUser,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserServices()),
          ChangeNotifierProvider(create: (context) => RestaurantProvider()),
          ChangeNotifierProvider(create: (context) => DateTimeProvider()),
          ChangeNotifierProvider(
              create: (context) => RestaurantDetailProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.red, textTheme: myTextTheme),
          home: Wrapper(),
        ),
      ),
    );
  }
}
