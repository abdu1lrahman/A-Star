import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get local => _locale;

  // I will keep this function in case I wanted to add more than two languages to the app
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void changeLocale(String newLang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (newLang == 'en') {
      _locale = const Locale('en');
      await prefs.setString('language', newLang);
    } else {
      _locale = const Locale('ar');
      await prefs.setString('language', newLang);
    }

    notifyListeners();
  }

  void changeLocale2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_locale == const Locale('en')) {
      _locale = const Locale('ar');
      await prefs.setString('language', _locale.languageCode);
    } else {
      _locale = const Locale('en');
      await prefs.setString('language', _locale.languageCode);
    }

    notifyListeners();
  }
}
