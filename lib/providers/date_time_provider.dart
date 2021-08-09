import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  DateTime pickedDate = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  String date = "";
  String time = "";

  String get getDate => date;

  String get getTime => time;

  void addDate(String newDate) {
    date = newDate;
  }

  void addTime(String newTime) {
    time = newTime;
  }
}
