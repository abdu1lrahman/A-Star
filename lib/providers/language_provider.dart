import 'package:flutter/material.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class LanguageProvider extends ChangeNotifier {
  static Locale _locale = const Locale('en');

  Locale get local => _locale;

  // I will keep this function in case I wanted to add more than two languages to the app
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  void changeLocale(String newLang) async {
    if (newLang == 'en') {
      _locale = const Locale('en');
      await Prefs.prefs.setString('language', newLang);
    } else {
      _locale = const Locale('ar');
      await Prefs.prefs.setString('language', newLang);
    }

    notifyListeners();
  }

  void changeLocale2() async {
    if (_locale == const Locale('en')) {
      _locale = const Locale('ar');
      await Prefs.prefs.setString('language', _locale.languageCode);
    } else {
      _locale = const Locale('en');
      await Prefs.prefs.setString('language', _locale.languageCode);
    }

    notifyListeners();
  }
}
