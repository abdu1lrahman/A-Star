import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';
import 'package:you_are_a_star/providers/user_provider.dart';
import 'package:you_are_a_star/presentation/screens/mainpage.dart';
import 'package:you_are_a_star/presentation/screens/intro.dart';
import 'package:you_are_a_star/presentation/screens/intro2.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "constants.env");
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final String? language = prefs.getString("language");
  // Make arabic as a deafult language on First launch
  if (language == null) {
    await prefs.setString("language", "ar");
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  NotificationTimeProvider().getNotificationTimes();
  NotificationService().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationTimeProvider()),
      ],
      child: MyApp(
        isFirstTime: isFirstTime,
        prefs: prefs,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;
  final SharedPreferences prefs;
  const MyApp({super.key, required this.isFirstTime, required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String appGroupId = "group.homeScreenApp";
  String iOSWidgetName = "MyHomeWidget";
  String androidWidgetName = "MyHomeWidget";
  String datakey = "text_from_flutter_app";

  void triggerGetUserData() async {
    UserProvider().getUserData(widget.prefs);
  }

  void setLanguage(SharedPreferences prefs) async {
    String language = prefs.getString("language") ?? "ar";
    LanguageProvider().setLocale(Locale(language));
  }

  @override
  void initState() {
    triggerGetUserData();
    setLanguage(widget.prefs);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      title: "A Star",
      debugShowCheckedModeBanner: false,
      routes: {
        "mainPage": (context) => const Mainpage(),
        "intro": (context) => const Intro(),
        "login": (context) => const Login(),
      },
      // This one is for the app language
      localizationsDelegates: const [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: languageProvider.local,
      theme: Provider.of<ThemeProvider>(context).currentAppTheme,

      home: widget.isFirstTime ? const Intro() : const Mainpage(),
    );
  }
}
