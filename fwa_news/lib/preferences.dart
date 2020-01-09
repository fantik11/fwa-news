import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static Future<String> getKeyValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? false;
  }


  static Future<bool> setKeyValue(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    return prefs.setString(key, value);
  }
}