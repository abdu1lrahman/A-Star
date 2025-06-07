import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_a_star/presentation/providers/theme_provider.dart';

AppBarTheme appBarTheme(BuildContext context) {
  final themeProvider = Provider.of<ThemeProvider>(context);
  return AppBarTheme(
    backgroundColor: themeProvider.currentAppTheme.fifthColor,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  );
}
