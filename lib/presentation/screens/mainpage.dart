import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/data/services/quote_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_are_a_star/presentation/screens/account.dart';
import 'package:you_are_a_star/presentation/screens/home.dart';
import 'package:you_are_a_star/presentation/screens/intrests.dart';
import 'package:you_are_a_star/presentation/screens/prev_messages.dart';
import 'package:you_are_a_star/presentation/screens/settings.dart';
import 'package:you_are_a_star/presentation/widgets/custom_GButton.dart';
import 'package:you_are_a_star/providers/prefs.dart';
import 'package:you_are_a_star/providers/user_provider.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _HomeState();
}

class _HomeState extends State<Mainpage> {
  int selectedIndex = 0;
  List pages = [
    const Home(),
    const PrevMessages(),
    const Intrests(),
    const Account(),
    const Settings(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final String? uuid = Prefs.prefs.getString("uuid");
      if (uuid != null) {
        userProvider.getUserData(uuid);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuoteService>(context, listen: false).loadDailyQuote(context);
    });
    
    NotificationService().scheduleNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: GNav(
          tabMargin: const EdgeInsets.all(10),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          selectedIndex: selectedIndex,
          activeColor: Colors.white,
          color: Colors.white,
          onTabChange: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: [
            customGButton(
              icon: Icons.home_outlined,
              screenWidth: screenWidth,
              text: S.of(context).home,
              context: context,
            ),
            customGButton(
              icon: Icons.message_outlined,
              text: S.of(context).prev_messages2,
              screenWidth: screenWidth,
              context: context,
            ),
            customGButton(
              icon: Icons.interests_outlined,
              text: S.of(context).intrests,
              screenWidth: screenWidth,
              context: context,
            ),
            customGButton(
              icon: Icons.account_circle_outlined,
              text: S.of(context).account,
              screenWidth: screenWidth,
              context: context,
            ),
            customGButton(
              icon: Icons.settings_outlined,
              text: S.of(context).settings,
              screenWidth: screenWidth,
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
