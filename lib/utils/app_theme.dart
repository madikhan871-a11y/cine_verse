import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: false,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.text,
      ),
    ),

    inputDecorationTheme:
    InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,

      hintStyle: const TextStyle(
        color: AppColors.textGrey,
        fontSize: 13,
      ),

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(17),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.2,
        ),
      ),
    ),

    elevatedButtonTheme:
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    ),

    navigationBarTheme:
    NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor:
      AppColors.primary.withOpacity(.25),

      height: 72,

      labelTextStyle:
      WidgetStateProperty.all(
        const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),

      iconTheme:
      WidgetStateProperty.all(
        const IconThemeData(
          size: 22,
        ),
      ),
    ),
  );
}