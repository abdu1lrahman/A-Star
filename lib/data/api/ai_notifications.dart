import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiNotifications {
  final dio = Dio();
  SqfliteDb db = SqfliteDb();

  String? _dateTimeString;

  void _getCurrentDateTime() {
    DateTime now = DateTime.now();
    _dateTimeString = DateFormat('EEE, M/d/y').format(now);
  }

  Future<List<String>> requestAIMessage() async {
    final Response response;
    final prefs = await SharedPreferences.getInstance();
    List<String>? intrests = prefs.getStringList('intrests');
    String? specialIntrests = prefs.getString('special_intrests');
    String? name = prefs.getString('name');
    int? age = prefs.getInt('age');
    bool? gender = prefs.getBool('gender');
    String? language = prefs.getString('language');

    debugPrint(intrests.toString());
    var url = 'https://api.aimlapi.com/v1/chat/completions';
    var headers = {
      "Authorization": "Bearer ${dotenv.env['apikey']}",
      "Content-Type": "application/json",
    };
    var data = {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              '''Write a short (No more than three sentences) motivational message or an advice for a notifications app, the user name is
            $name and he/she is $age years old ${gender == true ? 'male' : 'female'},
            let the response match one or two of their intrests in ${intrests.toString()} and special intrests in ${specialIntrests.toString()},
            make the response in $language with this format {"title":"...", "body":"..."},
          '''
        },
      ],
      "stream": false,
      "stream_options": {"include_usage": true},
      "top_p": 1,
      "temperature": 1,
      "stop": "",
      "reasoning_effort": "low",
      "modalities": ["text"]
    };

    try {
      debugPrint(data.toString());
      response = await dio.post(
        url,
        data: data,
        options: Options(headers: headers),
      );
      final contentString = response.data['choices'][0]['message']['content'];
      final decodedContent = json.decode(contentString);
      final String title = decodedContent['title'];
      final String body = decodedContent['body'];
      _getCurrentDateTime();
      db.insertData(
        '''INSERT INTO messages ('title','body','date') VALUES ("$title","$body","$_dateTimeString")''',
      );

      debugPrint("=================It works!=================");

      return [title, body];
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to fetch motivational message');
    }
  }
}
