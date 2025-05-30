import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get local => _locale;

  // I will keep this function in case I wanted to add more than two languages to the app
  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void changeLocale(String newLang) {
    (newLang == 'en') ? _locale = const Locale('en') : _locale = const Locale('ar');
    notifyListeners();
  }
}
