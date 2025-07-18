// This is a prefs class to share the sharedpreferences instance across the app
// and to apply the singleton pattern

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      init();
    }
    return _prefs!;
  }
}
