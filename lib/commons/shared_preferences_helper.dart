import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _backgroundColor = "backgroundColor";
  static final String _joystickColor = "joystickColor";

  static Future<Color> getBackgroundColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int colorValue = prefs.getInt(_backgroundColor);
    return colorValue != null ? Color(colorValue) : Colors.redAccent;
  }

  static Future<bool> setBackgroundColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_backgroundColor, color.value);
  }

  static Future<Color> getJoystickColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int colorValue = prefs.getInt(_joystickColor);
    return colorValue != null ? Color(colorValue) : Colors.black54;
  }

  static Future<bool> setJoystickColor(Color color) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_joystickColor, color.value);
  }
}
