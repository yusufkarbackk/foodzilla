import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static DateTime format() {
    // Date and Time Format
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final timeSpecific = "14:36:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    // Today Format
    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    // Tomorrow Format
    var formatted = resultToday.add(Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
