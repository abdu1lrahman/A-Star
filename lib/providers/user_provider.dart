import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class UserProvider extends ChangeNotifier {
  static String? _userName;
  static bool? _userGender;
  static int _userAge = 18;
  static int _quotesCount = 0;
  static int _messagesCount = 0;

  File? _image;

  String? get userName => _userName;
  bool? get userGender => _userGender;
  int get userAge => _userAge;
  File? get image => _image;
  int get quotesCount => _quotesCount;
  int get messagesCount => _messagesCount;

  void getUserData() async {
    _userName = Prefs.prefs.getString('name')!;
    _userGender = Prefs.prefs.getBool('gender')!;
    _userAge = Prefs.prefs.getInt('age')!;
    _quotesCount = Prefs.prefs.getInt('quotes_count') ?? 0;
    _messagesCount = Prefs.prefs.getInt('messages_count') ?? 0;

    notifyListeners();
  }

  changeName(String newName) async {
    await Prefs.prefs.setString('name', newName);
    _userName = newName;
    notifyListeners();
  }

  changeAge(int newAge) async {
    await Prefs.prefs.setInt('age', newAge);
    _userAge = newAge;
    notifyListeners();
  }

  changeGender(bool newGender) async {
    await Prefs.prefs.setBool('gender', newGender);
    _userGender = newGender;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await Prefs.prefs.setString('user_image', pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> loadImage() async {
    String? imagePath = Prefs.prefs.getString('user_image');
    if (imagePath != null && imagePath.isNotEmpty) {
      try {
        File imageFile = File(imagePath);
        // Check if the file actually exists
        if (await imageFile.exists()) {
          _image = imageFile;
        } else {
          // Remove invalid path from preferences
          await Prefs.prefs.remove('user_image');
          _image = null;
        }
      } catch (e) {
        debugPrint("========= error while loading the image: $e =========");
        // Remove invalid path from preferences
        await Prefs.prefs.remove('user_image');
        _image = null;
      }
      notifyListeners();
    }
  }

  Future<void> removeImage() async {
    await Prefs.prefs.remove('user_image');
    _image = null;
    notifyListeners();
  }

  Widget getUserAvatar() {
    if (image != null) {
      return Image.file(
        image!,
        fit: BoxFit.cover,
        width: 140.0,
        height: 140.0,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person);
        },
      );
    }
    return Icon(
      Icons.person,
      color: Colors.grey[400],
      size: 60,
    );
  }
}
