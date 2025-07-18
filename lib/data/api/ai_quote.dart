import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:you_are_a_star/providers/prefs.dart';

class AiQuote {
  Future<Map<String, String>> getAiQoute(String language) async {
    final model =
        FirebaseAI.googleAI().generativeModel(model: 'gemini-2.5-flash');

    List<String>? intrests = Prefs.prefs.getStringList('intrests');

    final prompt = [
      Content.text(
          '''Write a quote from random famous inspirational figures for a notifications app,             
          in '$language' language, the user has intrests in ${intrests.toString()} Respond only with raw JSON. Do not include markdown or explanations,
          in this Format: {"title":"The quote's author", "body":"The Quote"}
          ''')
    ];
    try {
      final response = await model.generateContent(prompt);
      if (response.text != null) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.text!);
        final String title = decodedResponse['title'];
        final String body = decodedResponse['body'];
        debugPrint("===============Every thing went successfuly===========");
        return {'title': title, 'body': body};
      }
    } catch (e) {
      debugPrint("==========${e.toString()}==========");
    }
    throw {};
  }
}
