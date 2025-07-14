import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

GButton customGButton({
  required IconData icon,
  required String text,
  required double screenWidth,
  required BuildContext context,
}) {
  // final themeProvider = Provider.of<ThemeProvider>(context);
  return GButton(
    gap: 2,
    icon: icon,
    style: GnavStyle.google,
    iconSize: 23,
    text: text,
    textStyle: TextStyle(
      fontSize: screenWidth * 0.03,
      color: Colors.white,
    ),
    hoverColor: Theme.of(context).colorScheme.tertiary,
    backgroundColor: Theme.of(context).colorScheme.tertiary,
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
  );
}
