import 'package:flutter/material.dart';

/// Raw color palette. Reference these from [AppTheme] only — widgets should
/// read colors from `Theme.of(context).colorScheme` so light/dark and theming
/// stay consistent.
class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF2563EB);
  static const Color secondary = Color(0xFF7C3AED);
  static const Color error = Color(0xFFDC2626);

  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);

  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
}
