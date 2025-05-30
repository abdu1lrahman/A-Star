import 'package:flutter/material.dart';
import 'package:you_are_a_star/core/theme/colors.dart';

AppBarTheme appBarTheme() => AppBarTheme(
      backgroundColor: theme1.fifthColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
