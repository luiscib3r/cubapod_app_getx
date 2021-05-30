import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.grey[300],
  backgroundColor: Colors.grey[300],
  primaryColor: Colors.white,
  accentColor: const Color(0xFF2C4BFF),
  iconTheme: const IconThemeData().copyWith(color: Colors.black),
  fontFamily: 'Montserrat',
  textTheme: TextTheme(
    headline2: const TextStyle(
      color: Colors.black,
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
    ),
    headline4: TextStyle(
      fontSize: 12.0,
      color: const Color(0xFF121212),
      fontWeight: FontWeight.w500,
      letterSpacing: 2.0,
    ),
    bodyText1: TextStyle(
      color: const Color(0xFF121212),
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
    bodyText2: TextStyle(
      color: const Color(0xFF121212),
      letterSpacing: 1.0,
    ),
  ),
);
