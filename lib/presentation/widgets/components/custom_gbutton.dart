import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

GButton customGButton({
  required IconData icon,
  required String text,
  required double screenWidth,
}) =>
    GButton(
      gap: 2,
      icon: icon,
      iconSize: 23,
      text: text,
      textStyle: TextStyle(
        fontSize: screenWidth * 0.03,
        color: Colors.white,
      ),
      hoverColor: const Color(0xff232023),
      backgroundColor: const Color(0xff232023),
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
    );
