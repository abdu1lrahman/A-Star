import 'package:flutter/material.dart';
import 'package:you_are_a_star/data/services/notification_service.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_are_a_star/presentation/screens/account.dart';
import 'package:you_are_a_star/presentation/screens/home.dart';
import 'package:you_are_a_star/presentation/screens/intrests.dart';
import 'package:you_are_a_star/presentation/screens/prev_messages.dart';
import 'package:you_are_a_star/presentation/screens/settings.dart';
import 'package:you_are_a_star/presentation/widgets/custom_GButton.dart';

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
