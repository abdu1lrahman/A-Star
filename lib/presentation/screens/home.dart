import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/data/api/ai_quote.dart';
import 'package:you_are_a_star/data/database/sqflite_db.dart';
import 'package:you_are_a_star/data/services/quote_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/widgets/custom_shimmereffect.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';
import 'package:home_widget/home_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  SqfliteDb db = SqfliteDb();
  final QuoteService _quoteService = QuoteService();
  // ignore: non_constant_identifier_names
  Map<String, String> today_quote = {'body': 'Loading...', 'title': 'Loading...'};
  late AnimationController _controller;
  late String animation;
  bool isLoading = true;

  String getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      animation = "assets/animations/morning_animation.json";
      return S.of(context).morning;
    } else if (hour >= 12 && hour < 17) {
      animation = "assets/animations/morning_animation.json";
      return S.of(context).afternoon;
    } else if (hour >= 17 && hour < 21) {
      animation = "assets/animations/night_animation.json";
      return S.of(context).evening;
    } else {
      animation = "assets/animations/night_animation.json";
      return S.of(context).night;
    }
  }

  @override
  void initState() {
    _initLoadQuote();
    HomeWidget.setAppGroupId("group.homeScreenApp");
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initLoadQuote() async {
    await _loadDailyQuote();
  }

  Future<void> _loadDailyQuote() async {
    // Get current date in YYYY-MM-DD format
    final today = DateTime.now().toIso8601String().substring(0, 10);

    // Check if we have a saved quote and if it's from today
    final lastQuoteDate = Prefs.prefs.getString('last_quote_date');
    final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
    final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

    if (lastQuoteDate == today && savedQuoteBody != null && savedQuoteTitle != null) {
      // Use the saved quote from today
      setState(() {
        today_quote = {'body': savedQuoteBody, 'title': savedQuoteTitle};
        isLoading = false;
      });
      await HomeWidget.saveWidgetData("today_quote_body", savedQuoteBody);
      await HomeWidget.saveWidgetData("today_quote_title", savedQuoteTitle);
      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );
    } else {
      // Fetch a new quote and save it
      await getTodayQuote();
    }
  }

  Future<void> getTodayQuote() async {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    final toastMessage = S.of(context).todayQuote_message_error;

    setState(() {
      isLoading = true;
    });

    try {
      final quote = await AiQuote().getAiQoute(languageProvider.local.languageCode);
      final today = DateTime.now().toIso8601String().substring(0, 10);

      // Save the new quote and date
      await Prefs.prefs.setString('last_quote_date', today);
      await Prefs.prefs.setString('saved_quote_body', quote['body'] ?? '');
      await Prefs.prefs.setString('saved_quote_title', quote['title'] ?? '');

      await HomeWidget.saveWidgetData("today_quote_body", "${quote['body']}");
      await HomeWidget.saveWidgetData("today_quote_title", "${quote['title']}");

      await HomeWidget.updateWidget(
        iOSName: "MyHomeWidget",
        androidName: "messagesWidget",
      );

      await Prefs.prefs.setInt('quotes_count', UserProvider().quotesCount + 1);

      setState(() {
        today_quote = quote;
        isLoading = false;
      });
    } catch (e) {
      final savedQuoteBody = Prefs.prefs.getString('saved_quote_body');
      final savedQuoteTitle = Prefs.prefs.getString('saved_quote_title');

      setState(() {
        today_quote = {
          'body': savedQuoteBody ?? 'Failed to load quote',
          'title': savedQuoteTitle ?? 'Error'
        };
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: toastMessage,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final greeting = getGreeting(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).home)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // welcome message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  Lottie.asset(
                    animation,
                    width: 110,
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller.duration = composition.duration * 1;
                      _controller.repeat();
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$greeting,\n${userProvider.userName}",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // today's quote
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: isLoading
                    ? CustomShimmereffect(screenWidth: screenWidth)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: screenWidth,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, right: 5),
                                  child: Container(
                                    width: 140,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          // ignore: deprecated_member_use
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 3,
                                          offset: const Offset(0, 2),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Text(
                                        S.of(context).today_quote,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Image.asset(
                                        "assets/icons/double_qoute.png",
                                        width: screenWidth * 0.12,
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .computeLuminance() >
                                                0.5
                                            ? Colors.black
                                            : Colors.grey[200],
                                      ),
                                    ),
                                    Text(
                                      textDirection: languageProvider.local.languageCode == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      today_quote['body']!,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.099,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    .computeLuminance() >
                                                0.5
                                            ? Colors.black
                                            : Colors.grey[200],
                                      ),
                                    ),
                                    Align(
                                      alignment: languageProvider.local.languageCode == 'ar'
                                          ? Alignment.bottomLeft
                                          : Alignment.bottomRight,
                                      child: Text(
                                        today_quote['title']!,
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .computeLuminance() >
                                                  0.5
                                              ? Colors.black
                                              : Colors.grey[200],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              onPressed: () async {
                await getTodayQuote();
              },
              child: Text(S.of(context).get_new_quote),
            ),
          ],
        ),
      ),
    );
  }
}
