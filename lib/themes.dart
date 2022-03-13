import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyThemes {
  static final primary = Colors.red;
  static final primaryColor = Colors.red.shade300;

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColorDark: primaryColor, 
    colorScheme: ColorScheme.dark(primary: primary),
    dividerColor: Colors.white,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    // primaryColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      ),
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
  );
}