import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';

GButton customGButton({
  required IconData icon,
  required String text,
  required double screenWidth,
  required BuildContext context,
}) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return GButton(
    style: GnavStyle.google,
    gap: 2,
    icon: icon,
    iconSize: 23,
    text: text,
    textStyle: TextStyle(
      fontSize: screenWidth * 0.03,
      color: Colors.white,
    ),
    hoverColor: themeProvider.currentAppTheme.sixthColor,
    backgroundColor: themeProvider.currentAppTheme.sixthColor,
    padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
  );
}
