import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primaryColor = Color(0xFF4b377f);
  static const Color secondaryColor = Color(0xFFcac3e0);
  static const Color backgroundColor = Color(0xFF9e90bf);
  static const Color greyColor = Color(0xFFF5F6F7);

  /*bleu ciel : #467CBC
  bleu foncé : #001749*/
  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        backgroundColor: primaryColor),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        0xFF050249,
        <int, Color>{
          50: Color(0xFFE1E1E9),
          100: Color(0xFFB4B3C8),
          200: Color(0xFF8281A4),
          300: Color(0xFF504E80),
          400: Color(0xFF2B2864),
          500: Color(0xFF050249),
          600: Color(0xFF040242),
          700: Color(0xFF040139),
          800: Color(0xFF030131),
          900: Color(0xFF010121),
        },
      ),
    ),
  );
  static const defaultPadding = 20.0;
  static const spacer = 20.0;
  static const extraSpacer = 40.0;
  static TextStyle mainBtnTextStyle = TextStyle(
    color: const ColorScheme.light().onSecondary,
    fontWeight: FontWeight.bold,
    fontSize: subtitle2,
  );

  static const defaultBorderRadius = 10.0;

  ///size 24
  static double headline = 24;

  ///size 18
  static double headline1 = 18;

  ///size 17
  static double headline2 = 17;

  ///size 16
  static double headline3 = 16;

  ///size 15
  static double headline4 = 15;

  ///size 14
  static double subtitle1 = 14;

  ///size 12
  static double subtitle2 = 13;

  ///size 12
  static double bodyText1 = 12;

  ///size 10
  static double bodyText2 = 10;

  ///size 12
  static double caption = 12;

  ///size 12
  static double button = 12;

  ///size 10
  static double overline = 10;
}
