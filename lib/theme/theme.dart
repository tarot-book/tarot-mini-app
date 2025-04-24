import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  cardColor: AppColors.card,
  appBarTheme: AppBarTheme(backgroundColor: AppColors.background, elevation: 0),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 14),
  ),
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    // secondary: Color.alphaBlend(AppColors.primaryHover, AppColors.card),
    surface: AppColors.surface, // or AppColors.card или #212121
  ),
  hoverColor: Color.alphaBlend(AppColors.primaryHover, AppColors.card),
  splashColor: Color.alphaBlend(AppColors.primarySplash, AppColors.card),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return Color.alphaBlend(AppColors.primaryHover, AppColors.card);
        }
        if (states.contains(WidgetState.pressed)) {
          return Color.alphaBlend(AppColors.primarySplash, AppColors.card);
        }
        return null;
      }),
    ),
  ),
  listTileTheme: ListTileThemeData(
    selectedColor: AppColors.card, // text and icon color when selected
    selectedTileColor: AppColors.card, // background color when selected
    tileColor: AppColors.card, // background color for unselected
  ),
  bottomSheetTheme: BottomSheetThemeData(
    // Полупрозрачный фон: берем surface из colorScheme и ставим альфу 0xCC (~80%)
    backgroundColor: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ).surface.withAlpha(0x14),
    // Скругление верхних углов
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    // Можно задать elevation, modalElevation и другие свойства:
    modalElevation: 4,
  ),
);
