import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Quicksand',
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  primaryColor: const Color(0xFF53B175),
  secondaryHeaderColor: const Color(0xFF1ED7AA),
  disabledColor: const Color(0xFFBABFC4),
  backgroundColor: Colors.white,
  errorColor: const Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  colorScheme: const ColorScheme.light(
      primary: Color(0xFF53B175), secondary: Color(0xFF53B175)),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(primary: const Color(0xFF53B175))),
);
