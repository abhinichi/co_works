import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF003CA6);
  static const Color primaryDark = Color(0xFF002B7D);
  static const Color background = Color(0xFFF8F9FD);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.background,
    );
  }
}
