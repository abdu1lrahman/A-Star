import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/data/api/ai_quote.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class QuoteService extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, String> _todayQuote = {'body': 'Loading...', 'title': 'Loading...'};

  bool get isLoading => _isLoading;
  Map<String, String> get todayQuote => _todayQuote;

  Future<void> getTodayQuote(BuildContext context) async {
    HomeWidget.setAppGroupId("group.homeScreenApp");
    debugPrint("=========Get Today Quote=========");
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

      // This is for the app widget on android
      await HomeWidget.saveWidgetData("today_quote_body", "${quote['body']}");
      await HomeWidget.saveWidgetData("today_quote_title", "${quote['title']}");

      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );

      await Prefs.prefs.setInt('quotes_count', UserProvider().quotesCount + 1);
      _isLoading = false;
      _todayQuote = quote;
      notifyListeners();
    } catch (e) {
      // if there's any error role back to the last saved offline quote
      debugPrint("=========Get Today Quote error ${e.toString()}=========");
      final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
      final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

      _todayQuote = {
        'body': savedQuoteBody ?? 'Failed to load quote',
        'title': savedQuoteTitle ?? 'Error'
      };
      _isLoading = false;
      notifyListeners();

      Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> loadDailyQuote(BuildContext context) async {
    HomeWidget.setAppGroupId("group.homeScreenApp");
    // Get current date in YYYY-MM-DD format
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // Check if we have a saved quote and if it's from today
    final lastQuoteDate = Prefs.prefs.getString('last_quote_date');
    final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
    final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

    if (lastQuoteDate == today && savedQuoteBody != null && savedQuoteTitle != null) {
      // Use the saved quote from today
      _todayQuote = {'body': savedQuoteBody, 'title': savedQuoteTitle};
      _isLoading = false;
      notifyListeners();

      await HomeWidget.saveWidgetData("today_quote_body", savedQuoteBody);
      await HomeWidget.saveWidgetData("today_quote_title", savedQuoteTitle);
      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );
    } else {
      // Fetch a new quote and save it
      await getTodayQuote(context);
    }
  }
}
