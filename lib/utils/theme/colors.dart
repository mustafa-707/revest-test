import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static Color get primary => const Color(0xFF56CFE1); // Vibrant Blue-Green
  static Color get onPrimary => const Color(0xFFFFFFFF); // White on primary
  static Color get secondary => const Color(0xFFF16B6F); // Light Coral
  static Color get onSecondary => const Color(0xFFFFFFFF); // White on secondary
  static Color get error => const Color(0xFFF44336); // Soft Red
  static Color get onError => const Color(0xFFFFFFFF); // White on error
  static Color get surface => const Color(0xFFFFFBFA); // Light Cream
  static Color get onSurface => const Color(0xFF2B2B2B); // Dark Charcoal
  static Color get shadow => const Color(0xFFD6D6D6); // Soft Gray Shadow

  // Dark Theme Colors
  static Color get primaryDark => const Color(0xFF007A78); // Deep Teal
  static Color get onPrimaryDark => const Color(0xFFF4F4F4); // Off-White for Text
  static Color get secondaryDark => const Color(0xFFB56576); // Moody Violet
  static Color get onSecondaryDark => const Color(0xFFF4F4F4); // Off-White for Text
  static Color get errorDark => const Color(0xFFEF5350); // Softer Red
  static Color get onErrorDark => const Color(0xFF2E2E2E); // Dark Charcoal
  static Color get surfaceDark => const Color(0xFF1E1E1E); // Deep Black-Grey
  static Color get onSurfaceDark => const Color(0xFF000000); // Off-White for Text
  static Color get shadowDark => const Color(0xFF1A1A1A); // Deep Shadow for Dark Mode
}
