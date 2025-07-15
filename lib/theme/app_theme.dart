import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.teal;
  static const Color secondaryColor = Colors.purpleAccent;
  static const Color primaryWhite = Colors.white;
  static const Color primaryBlack = Colors.black;
  static const Color primaryRed = Colors.red;
  static const Color primaryOrange = Colors.orange;
  static const Color primaryGreen = Colors.green;
  static const Color primaryBlue = Colors.blue;

  static const ProgressIndicatorThemeData progressIndicatorTheme =
      ProgressIndicatorThemeData(color: primaryColor);

  static const AppBarTheme appBarTheme = AppBarTheme(
    color: primaryColor,
    titleTextStyle: TextStyle(color: primaryWhite, fontSize: 20),
    iconTheme: IconThemeData(color: primaryWhite),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: progressIndicatorTheme,
      appBarTheme: appBarTheme,
      fontFamily: 'SFPro',
    );
  }
}
