import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class UserProvider extends ChangeNotifier {
  static String? _uuid;
  static String? _userName;
  static bool? _userGender;
  static int _userAge = 18;
  static int _quotesCount = 0;
  static int _messagesCount = 0;
  static String? _intrests;
  static String? _specialIntrests;

  String? _imagePath;

  String? get uuid => _uuid;
  String? get userName => _userName;
  bool? get userGender => _userGender;
  int get userAge => _userAge;
  String? get imagePath => _imagePath;
  int get quotesCount => _quotesCount;
  int get messagesCount => _messagesCount;
  Set<String>? get intrests => _intrests!
      .replaceAll('{', '')
      .replaceAll('}', '')
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toSet();
  String? get specialIntrests => _specialIntrests;

  changeUserId(String uuid) {
    _uuid = uuid;
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

  changeIntrests(String intrests) async {
    await Prefs.prefs.setString('intrests', intrests);
    _intrests = intrests;
    notifyListeners();
  }

  changeSpecialIntrests(String newSpecialIntrests) async {
    await Prefs.prefs.setString('special_intrests', newSpecialIntrests);
    _specialIntrests = newSpecialIntrests;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await Prefs.prefs.setString('user_image', pickedFile.path);
      _imagePath = pickedFile.path;
      notifyListeners();
    }
  }

  Future<void> removeImage() async {
    await Prefs.prefs.remove('user_image');
    _imagePath = null;
    notifyListeners();
  }

  Widget getUserAvatar() {
    if (_imagePath != null) {
      return Image.file(
        File(_imagePath!),
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

  _getDataFromDatabase(String uuid) async {
    debugPrint("====================Get Data From Database====================");
    try {
      final FirebaseFirestore firestoreClient = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestoreClient
          .collection('profiles')
          .where('uuid', isEqualTo: uuid)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        changeName(data['name'] ?? 'User');
        changeAge(data['age'] ?? 0);
        changeGender(data['gender'] ?? true);
        changeSpecialIntrests(data['special_intrests'] ?? '');
        changeIntrests(data['intrests'] ?? '');

        debugPrint(
            "====================Get Data From Database finished successfuly====================");
        notifyListeners();
      }
    } catch (e) {
      debugPrint("========= error while getting user data from database: $e =========");
    }
  }

  getUserData(String uuid) {
    if (Prefs.prefs.getString('name') == null) {
      _getDataFromDatabase(uuid);
      notifyListeners();
    } else {
      _userName = Prefs.prefs.getString('name')!;
      _userGender = Prefs.prefs.getBool('gender')!;
      _userAge = Prefs.prefs.getInt('age')!;
      _intrests = Prefs.prefs.getString('intrests') ?? '';
      _specialIntrests = Prefs.prefs.getString('special_intrests') ?? '';
      _quotesCount = Prefs.prefs.getInt('quotes_count') ?? 0;
      _messagesCount = Prefs.prefs.getInt('messages_count') ?? 0;
      _imagePath = Prefs.prefs.getString('user_image');
      notifyListeners();
    }
  }
}
