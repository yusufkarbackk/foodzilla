import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodzilla/models/restaurant_detail.dart';
import 'package:foodzilla/providers/restaurant_detail_provider.dart';
import 'package:foodzilla/shared/navigation.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantDetail restaurantDetail) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "foodzilla";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Don't forget to visit this restaurant</b>";
    var titleNews = restaurantDetail.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(restaurantDetail.toJson()));
  }

//NOTE:menangani ketika mengetuk notifikasi yang mengarah ke halaman detail
  void configureSelectNotificationSubject(String route, BuildContext context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantDetail.fromJson(json.decode(payload));

        Provider.of<RestaurantDetailProvider>(context, listen: false)
            .setRestaurantDetail = data;

        Navigation.intentWithData(route);
      },
    );
  }
}
