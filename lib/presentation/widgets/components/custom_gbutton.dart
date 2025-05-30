import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:you_are_a_star/core/theme/colors.dart';

GButton customGButton({
  required IconData icon,
  required String text,
  required double screenWidth,
}) =>
    GButton(
      style: GnavStyle.google,
      gap: 2,
      icon: icon,
      iconSize: 23,
      text: text,
      textStyle: TextStyle(
        fontSize: screenWidth * 0.03,
        color: Colors.white,
      ),
      hoverColor: theme1.sexthColor,
      backgroundColor: theme1.sexthColor,
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
    );
