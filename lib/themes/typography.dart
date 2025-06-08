import 'package:flutter/material.dart';

TextTheme buildInterTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: colorScheme.onBackground,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: colorScheme.onBackground,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: colorScheme.onBackground,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: colorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w300,
      color: colorScheme.onBackground,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w200,
      color: colorScheme.onBackground,
    ),
  );
}
