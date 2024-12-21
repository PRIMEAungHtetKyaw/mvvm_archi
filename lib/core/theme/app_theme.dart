import 'package:flutter/material.dart';
import 'colors.dart'; 

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight, 
      secondary: AppColors.secondaryLight,
      surface: AppColors.surfaceLight,
      error: AppColors.errorLight,
    ),
    scaffoldBackgroundColor: AppColors.surfaceLight,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight), // Primary text
      bodyMedium: TextStyle(color: AppColors.lightGrey), // Secondary text
    
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.lightGrey.withOpacity(0.5)), // Hint text color
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryLight, width: 2.0),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.errorLight),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight, // Blue button
        foregroundColor: Colors.white, // White text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      error: AppColors.errorDark,
    ),
    scaffoldBackgroundColor: AppColors.surfaceDark,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark), // Primary text
      bodyMedium: TextStyle(color: AppColors.textDark), // Secondary text
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.textDark.withOpacity(0.6)), // Hint text color
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryDark),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryDark, width: 2.0),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.errorDark),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark, // Light Blue button
        foregroundColor: Colors.white, // White text
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}
