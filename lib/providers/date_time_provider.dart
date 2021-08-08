import 'package:flutter/foundation.dart';

class DateTimeProvider extends ChangeNotifier {
  late String date = "";
  late String time = "";

  String get getDate => date;

  String get getTime => time;

  void addDate(String newDate) {
    date = newDate;
    notifyListeners();
  }

  void addTime(String newTime) {
    time = newTime;
    notifyListeners();
  }
}
