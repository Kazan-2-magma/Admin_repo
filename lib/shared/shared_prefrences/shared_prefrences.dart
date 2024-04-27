import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class AppPreferences{
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }
  static Future<void> setData(String key, Map<String, dynamic> value) async {
    final jsonString = json.encode(value);
    await preferences!.setString(key, jsonString);
  }

  static Map<String, dynamic>? getData(String key) {
    final jsonString = preferences!.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }
}