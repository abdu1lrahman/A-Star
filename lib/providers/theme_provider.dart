import 'package:flutter/material.dart';
import 'package:you_are_a_star/providers/prefs.dart';

enum ThemeModes {
  light,
  dark,
  system,
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void loadTheme() {
    String theme = Prefs.prefs.getString("theme") ?? "system";
    if (theme == "LightMode") {
      _themeMode = ThemeMode.light;
    } else if (theme == "DarkMode") {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await Prefs.prefs.setString('theme', mode.name);
    notifyListeners();
  }
}
