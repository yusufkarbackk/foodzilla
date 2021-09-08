import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _initTheme();
  }

  Future<void> _initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(key) ?? false;
    setDarkTheme(value);
  }

  bool _darkTheme = false;

  set setTheme(bool value) {
    _darkTheme = value;
  }

  final String key = "themeColor";

  bool get getDarkTheme => _darkTheme;

  setDarkTheme(bool value) async {
    if (value) {
      print('dark');
    } else {
      print('light');
    }

    setTheme = value;

    notifyListeners();
  }

  void getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) == false) {
      print('theme in light');
    } else {
      print('theme is dark');
    }
    _darkTheme = prefs.getBool(key) ?? false;
  }

  void saveTheme(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
