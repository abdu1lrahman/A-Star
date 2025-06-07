import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _userName = 'غفران';
  bool _userGender = false;
  int _userAge = 21;
  File? _image = File('assets/icons/app_icon.png');

  String get userName => _userName;
  bool get userGender => _userGender;
  int get userAge => _userAge;
  File? get image => _image;

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('name')!;
    _userGender = prefs.getBool('gender')!;
    _userAge = prefs.getInt('age')!;
  }

  changeName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', newName);
    _userName = newName;
    notifyListeners();
  }

  changeAge(int newAge) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('age', newAge);
    _userAge = newAge;
    notifyListeners();
  }

  changeGender(bool newGender) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('gender', newGender);
    _userGender = newGender;
    notifyListeners();
  }

  Future<bool> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_image');
    if (imagePath != null) {
      _image = File(imagePath);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Widget getUserAvatar() {
    if (loadImage() != false && image != null) {
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
