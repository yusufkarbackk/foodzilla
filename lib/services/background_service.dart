import 'dart:isolate';
import 'dart:math';
import 'package:foodzilla/main.dart';
import 'dart:ui';
import 'package:foodzilla/services/services.dart';
import 'package:foodzilla/services/notofication_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service!;
  }
//NOTE:mendaftarkan SendPort isolate UI untuk memungkinkan komunikasi dari isolate background.
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await RestaurantServices.getRestaurants();
    Random random = Random();
    int randomNumber = random.nextInt(result.length);
    var restaurantDetailResult =
        await RestaurantServices.getRestaurantDetail(result[randomNumber].id);
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurantDetailResult);
    print("notification showed");
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
