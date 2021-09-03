import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:foodzilla/providers/date_time_provider.dart';
import 'package:foodzilla/services/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print("Scheduling active");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(minutes: 2),
        1,
        BackgroundService.callback,
        startAt: DateTimeProvider.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
