import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:you_are_a_star/data/api/ai_quote.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class QuoteService extends ChangeNotifier {
  bool _isLoading = false;
  final supabaseClient = Supabase.instance.client;

  bool get isLoading => _isLoading;

  Future<Map<String, String>> getTodayQuote(BuildContext context) async {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final toastMessage = S.of(context).todayQuote_message_error;
    AiQuote aiQuote = AiQuote();

    _isLoading = true;
    notifyListeners();

    try {
      final quote = await aiQuote.getAiQoute(languageProvider.local.languageCode);
      final today = DateTime.now().toIso8601String().substring(0, 10);

      // Save the new quote and date for offline
      await Prefs.prefs.setString('last_quote_date', today);
      await Prefs.prefs.setString('saved_quote_body', quote['body'] ?? '');
      await Prefs.prefs.setString('saved_quote_title', quote['title'] ?? '');

      // Save the new quote and date in the Database
      try {
        await supabaseClient.from('todays_quote').insert({
          'id': Supabase.instance.client.auth.currentUser!.id,
          'quote': quote['body'],
          'quote_author': quote['title']
        });
      } on Exception catch (e) {
        debugPrint("anything $e");
      }

      // This is for the app widget on android
      await HomeWidget.saveWidgetData("today_quote_body", "${quote['body']}");
      await HomeWidget.saveWidgetData("today_quote_title", "${quote['title']}");

      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );

      await Prefs.prefs.setInt('quotes_count', UserProvider().quotesCount + 1);
      _isLoading = false;
      notifyListeners();
      return quote;
    } catch (e) {
      // if there's any error role back to the last saved offline quote

      final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
      final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

      _isLoading = false;
      notifyListeners();

      Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
      );
      return {
        'body': savedQuoteBody ?? 'Failed to load quote',
        'title': savedQuoteTitle ?? 'Error'
      };
    }
  }

  Future<Map<String, String>> loadDailyQuote(BuildContext context) async {
    // Get current date in YYYY-MM-DD format
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // Check if we have a saved quote and if it's from today
    final lastQuoteDate = Prefs.prefs.getString('last_quote_date');
    final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
    final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

    if (lastQuoteDate == today && savedQuoteBody != null && savedQuoteTitle != null) {
      // Use the saved quote from today

      _isLoading = false;
      notifyListeners();

      await HomeWidget.saveWidgetData("today_quote_body", savedQuoteBody);
      await HomeWidget.saveWidgetData("today_quote_title", savedQuoteTitle);
      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );

      return {'body': savedQuoteBody, 'title': savedQuoteTitle};
    } else {
      // Fetch a new quote and save it
      return getTodayQuote(context);
    }
  }
}
