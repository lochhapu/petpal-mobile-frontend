import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor, // Add this
        background: AppColors.backgroundColor, // Add this
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundColor, // Set scaffold bg
    );
  }
}
