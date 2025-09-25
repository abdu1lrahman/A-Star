import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/core/theme/colors.dart';
import 'package:you_are_a_star/data/services/auth_gate.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/data/services/quote_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/routes.dart';
import 'package:you_are_a_star/presentation/screens/account.dart';
import 'package:you_are_a_star/providers/notification_time_provider.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/theme_provider.dart';
import 'package:you_are_a_star/providers/user_provider.dart';
import 'package:you_are_a_star/providers/language_provider.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "constants.env");
  // Initialize SharedPreferences
  await Prefs.init();
  // Initialize Firebase
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
        ChangeNotifierProvider(create: (_) => QuoteService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: "A Star",
      debugShowCheckedModeBanner: false,
      routes: routes,
      locale: languageProvider.local,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: themeProvider.themeMode,
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
      home: const AuthGate(),
    );
  }
}
