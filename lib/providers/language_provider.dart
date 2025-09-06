import 'package:flutter/material.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class LanguageProvider extends ChangeNotifier {
  static Locale _locale = const Locale('ar');

  Locale get local => _locale;

  void toggleLanguage() async {
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
