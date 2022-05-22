import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    accentColor: Colors.blue,
    scaffoldBackgroundColor: Color(0xfff1f1f1));


ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  accentColor: Colors.deepPurple,);


class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _prefe;
  bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  lightTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    if (_prefe == null) _prefe = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefe.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefe.setBool(key, _darkTheme);
  }
}
