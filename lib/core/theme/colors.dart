import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class theme1 {
  static Color mainColor = const Color(0xffD8E2DC);
  static Color secondColor = const Color(0xffFFE5D9);
  static Color thirdColor = const Color(0xffFFCAD4);
  static Color forthColor = const Color(0xffF4ACB7);
  static Color fifthColor = const Color(0xff9D8189);
  static Color sixthColor = const Color(0xffb4919b);
}

ThemeData lightMode = ThemeData(
  timePickerTheme: TimePickerThemeData(
    backgroundColor: const Color(0xffffffff),
    dialHandColor: const Color(0xff9D8189),
    hourMinuteColor: const Color(0xff9D8189),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return Colors.black;
        },
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return Colors.black;
        },
      ),
    ),
  ),
  brightness: Brightness.light,
  textTheme: GoogleFonts.notoKufiArabicTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: theme1.fifthColor,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    surface: Colors.white,
    primary: Color(0xffD8E2DC),
    secondary: Color(0xff9D8189),
    tertiary: Color(0xffb4919b),
  ),
);

ThemeData darkMode = ThemeData(
  timePickerTheme: TimePickerThemeData(
    dayPeriodTextColor: Colors.black,
    dayPeriodBorderSide: const BorderSide(color: Colors.black),
    dialTextColor: Colors.black,
    dayPeriodColor: const Color(0xff9D8189),
    dialBackgroundColor: Colors.grey[200],
    entryModeIconColor: Colors.black,
    backgroundColor: Colors.grey[200],
    dialHandColor: const Color(0xff9D8189),
    hourMinuteColor: const Color(0xff9D8189),
    timeSelectorSeparatorColor: WidgetStateProperty.resolveWith<Color?>(
      (Set<WidgetState> states) {
        return Colors.black;
      },
    ),
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return Colors.black;
        },
      ),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return Colors.black;
        },
      ),
    ),
  ),
  brightness: Brightness.dark,
  textTheme: GoogleFonts.notoKufiArabicTextTheme(),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff3F2B30),
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  colorScheme: const ColorScheme.dark(
    surface: Colors.grey,
    primary: Color(0xFF384742),
    secondary: Color(0xff3F2B30),
    tertiary: Color(0xff4B3842),
  ),
);
