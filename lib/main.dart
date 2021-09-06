import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodzilla/providers/date_time_provider.dart';
import 'package:foodzilla/providers/restaurant_detail_provider.dart';
import 'package:foodzilla/providers/restaurant_provider.dart';
import 'package:foodzilla/providers/scheduling_provider.dart';
import 'package:foodzilla/providers/theme_provider.dart';
import 'package:foodzilla/services/background_service.dart';
import 'package:foodzilla/services/notofication_helper.dart';
import 'package:foodzilla/services/services.dart';
import 'package:foodzilla/shared/navigation.dart';
import 'package:foodzilla/shared/style.dart';
import 'package:provider/provider.dart';
import 'screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final NotificationHelper _notificationHelper = NotificationHelper();

  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeProvider = ThemeProvider();
  @override
  void initState() {
    super.initState();
    getAppTheme();
  }

  void getAppTheme() async {
    themeProvider.setDarkTheme = await themeProvider.getTheme();
  }

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
          ChangeNotifierProvider(
              create: (context) => FavouriteRestaurantServices()),
          ChangeNotifierProvider(create: (context) => SchedulingProvider()),
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, theme, _) {
            return MaterialApp(
              initialRoute: Wrapper.routeName,
              routes: {
                Wrapper.routeName: (context) => Wrapper(),
                DetailScreen.routeName: (context) => DetailScreen()
              },
              navigatorKey: navigatorKey,
              title: 'Flutter Demo',
              theme:
                  Styles.themeData(theme.getDarkTheme, context),
            );
          },
        ),
      ),
    );
  }
}
