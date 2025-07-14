import 'package:flutter/material.dart';
import 'package:you_are_a_star/core/theme/colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentAppTheme = lightMode;

  ThemeData get currentAppTheme => _currentAppTheme;

  void setTheme(String newTheme) {
    _currentAppTheme = (newTheme == 'LightMode') ? lightMode : darkMode;
    notifyListeners();
  }

  void toggleTheme(){
    if(_currentAppTheme == lightMode){
      _currentAppTheme = darkMode;
    } else {
      _currentAppTheme = lightMode;
    }
    notifyListeners();
  }
}
