import 'package:flutter/material.dart';
import 'package:you_are_a_star/generated/l10n.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_are_a_star/presentation/screens/account.dart';
import 'package:you_are_a_star/presentation/screens/home.dart';
import 'package:you_are_a_star/presentation/screens/intrests.dart';
import 'package:you_are_a_star/presentation/screens/prev_messages.dart';
import 'package:you_are_a_star/presentation/screens/settings.dart';

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
        backgroundColor: Colors.black,
        selectedIndex: selectedIndex,
        activeColor: Colors.white,
        color: Colors.white,
        onTabChange: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        tabs: [
          GButton(
            gap: 2,
            icon: Icons.home_outlined,
            iconSize: 23,
            text: S.of(context).home,
            textStyle: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
            ),
            hoverColor: const Color(0xff232023),
            backgroundColor: const Color(0xff232023),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          ),
          GButton(
            gap: 2,
            icon: Icons.message_outlined,
            iconSize: 23,
            text: S.of(context).prev_messages2,
            textStyle: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
            ),
            hoverColor: const Color(0xff232023),
            backgroundColor: const Color(0xff232023),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          ),
          GButton(
            gap: 2,
            icon: Icons.interests_outlined,
            iconSize: 23,
            text: S.of(context).intrests,
            textStyle: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
            ),
            hoverColor: const Color(0xff232023),
            backgroundColor: const Color(0xff232023),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          ),
          GButton(
            gap: 2,
            icon: Icons.account_circle_outlined,
            iconSize: 23,
            text: S.of(context).account,
            textStyle: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
            ),
            hoverColor: const Color(0xff232023),
            backgroundColor: const Color(0xff232023),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          ),
          GButton(
            gap: 2,
            icon: Icons.settings_outlined,
            iconSize: 23,
            text: S.of(context).settings,
            textStyle: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.white,
            ),
            hoverColor: const Color(0xff232023),
            backgroundColor: const Color(0xff232023),
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
          ),
        ],
      ),
    );
  }
}
