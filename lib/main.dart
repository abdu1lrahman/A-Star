import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';
import 'package:you_are_a_star/presentation/providers/user_provider.dart';
import 'package:you_are_a_star/presentation/screens/mainpage.dart';
import 'package:you_are_a_star/presentation/screens/intro.dart';
import 'package:you_are_a_star/presentation/screens/intro2.dart';
import 'package:you_are_a_star/presentation/providers/language_provider.dart';
import 'package:you_are_a_star/presentation/widgets/components/custom_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  NotificationService().scheduleNotification();
  await dotenv.load(fileName: "constants.env");
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

class MyApp extends StatefulWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context, listen: true);

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
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
          theme: ThemeData(
            appBarTheme: appBarTheme(context),
            // The font used in the app is notoKufiArabicTextTheme
            textTheme: GoogleFonts.notoKufiArabicTextTheme(),
          ),

          home: widget.isFirstTime ? const Intro() : const Mainpage(),
        );
      },
    );
  }
}
