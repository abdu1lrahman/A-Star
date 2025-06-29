import 'package:flutter/material.dart';
import 'package:you_are_a_star/core/theme/colors.dart';

class AppTheme {
  final Color mainColor;
  final Color secondColor;
  final Color thirdColor;
  final Color forthColor;
  final Color fifthColor;
  final Color? sixthColor;

  AppTheme({
    required this.mainColor,
    required this.secondColor,
    required this.thirdColor,
    required this.forthColor,
    required this.fifthColor,
    required this.sixthColor,
  });
}

class ThemeProvider extends ChangeNotifier {
  AppTheme _currentAppTheme = _theme1;

  static final AppTheme _theme1 = AppTheme(
    mainColor: theme1.mainColor,
    secondColor: theme1.secondColor,
    thirdColor: theme1.thirdColor,
    forthColor: theme1.forthColor,
    fifthColor: theme1.fifthColor,
    sixthColor: theme1.sixthColor,
  );

  static final AppTheme _theme2 = AppTheme(
    mainColor: theme2.mainColor,
    secondColor: theme2.secondColor,
    thirdColor: theme2.thirdColor,
    forthColor: theme2.forthColor,
    fifthColor: theme2.fifthColor,
    sixthColor: theme2.sixthColor,
  );

  AppTheme get currentAppTheme => _currentAppTheme;

  void setTheme(String newTheme) {
    _currentAppTheme = newTheme == 'theme1' ? _theme1 : _theme2;
    notifyListeners();
  }
}
