import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.card,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14),
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    surface: AppColors.surface, // or AppColors.card или #212121

  ),  
);
