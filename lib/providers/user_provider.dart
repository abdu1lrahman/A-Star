import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  static String? _userName;
  static bool? _userGender;
  static int _userAge = 18;
  File? _image;

  String? get userName => _userName;
  bool? get userGender => _userGender;
  int get userAge => _userAge;
  File? get image => _image;

  void getUserData(SharedPreferences pref) async {
    _userName = pref.getString('name')!;
    _userGender = pref.getBool('gender')!;
    _userAge = pref.getInt('age')!;
    notifyListeners();
  }

  changeName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    _userName = newName;
    notifyListeners();
  }

  changeAge(int newAge) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', newAge);
    _userAge = newAge;
    notifyListeners();
  }

  changeGender(bool newGender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('gender', newGender);
    _userGender = newGender;
    notifyListeners();
  }

  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_image');
    if (imagePath != null) {
      _image = File(imagePath);
      notifyListeners();
    }
  }

  Widget getUserAvatar() {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
        width: 140.0,
        height: 140.0,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.add_a_photo_outlined);
        },
      );
    }
    return const Icon(Icons.add_a_photo_outlined);
  }
}
