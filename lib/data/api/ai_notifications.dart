import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiNotifications {
  SqfliteDb db = SqfliteDb();

  String? _dateTimeString;

  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    _dateTimeString = DateFormat('EEE, M/d/y').format(now);
  }

  Future<Map<String, String>?> requestAIMessage() async {
    final prefs = await SharedPreferences.getInstance();
    final model =
        FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');
    List<String>? intrests = prefs.getStringList('intrests');
    String? specialIntrests = prefs.getString('special_intrests');
    String? name = prefs.getString('name');
    int? age = prefs.getInt('age');
    bool? gender = prefs.getBool('gender');
    String? language = prefs.getString('language');

    debugPrint(
        "This is before parsing the api the intrests ${intrests.toString()} and the name $name,age $age,gender $gender");

    final prompt = [
      Content.text(
          '''Write a short (No more than three sentences) motivational message or a quote from famous inspirational figures
           for a notifications app, the user name is $name and he/she is $age years old
            ${gender == false ? 'male' : 'female'}, let the response match one or two of their intrests
             in ${intrests.toString()} and special intrests in ${specialIntrests.toString()},
             in '$language', Respond only with raw JSON. Do not include markdown or explanations.
              Format: {"title":"...", "body":"..."}
              ''')
    ];

    try {
      final response = await model.generateContent(prompt);
      if (response.text != null) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.text!);
        final String? title = decodedResponse['title'] as String?;
        final String? body = decodedResponse['body'] as String?;
        _getCurrentDateTime();
        db.insertData(
          '''INSERT INTO messages ('title','body','date') VALUES ("$title","$body","$_dateTimeString")''',
        );
        return {'title': title!, 'body': body!};
      }
      debugPrint("=================It works!=================");
    } on Exception catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg:
              "Faild to fetch ai generated messages, please check your wifi connection",
          toastLength: Toast.LENGTH_LONG);
      throw Exception('Failed to fetch motivational message');
    }
    return null;
  }
}
