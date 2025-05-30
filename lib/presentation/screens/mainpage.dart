import 'package:flutter/material.dart';
import 'package:you_are_a_star/core/theme/colors.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_are_a_star/presentation/screens/account.dart';
import 'package:you_are_a_star/presentation/screens/home.dart';
import 'package:you_are_a_star/presentation/screens/intrests.dart';
import 'package:you_are_a_star/presentation/screens/prev_messages.dart';
import 'package:you_are_a_star/presentation/screens/settings.dart';
import 'package:you_are_a_star/presentation/widgets/components/custom_GButton.dart';

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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: GNav(
        tabMargin: const EdgeInsets.all(10),
        backgroundColor: theme1.fifthColor,
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
          ),
          customGButton(
            icon: Icons.message_outlined,
            text: S.of(context).prev_messages2,
            screenWidth: screenWidth,
          ),
          customGButton(
            icon: Icons.interests_outlined,
            text: S.of(context).intrests,
            screenWidth: screenWidth,
          ),
          customGButton(
            icon: Icons.account_circle_outlined,
            text: S.of(context).account,
            screenWidth: screenWidth,
          ),
          customGButton(
            icon: Icons.settings_outlined,
            text: S.of(context).settings,
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }
}
