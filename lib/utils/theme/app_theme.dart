import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:revest/utils/global_navigator.dart';
import 'package:revest/utils/theme/colors.dart';

class AppThemes {
  final String locale;

  AppThemes(this.locale);
  ThemeData lightTheme() => ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primary,
          onPrimary: AppColors.onPrimary,
          secondary: AppColors.secondary,
          onSecondary: AppColors.onSecondary,
          error: AppColors.error,
          onError: AppColors.onError,
          surface: AppColors.surface,
          onSurface: AppColors.onSurface,
          shadow: AppColors.shadow,
        ),
        textTheme: TextTheme(
          labelMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            height: 1.4,
            fontSize: 14,
            color: AppColors.onSurface,
          ),
          labelLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onSurface,
          ),
          titleSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onSurface,
          ),
          titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 18,
            color: AppColors.onSurface,
          ),
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            height: 1.4,
            fontSize: 20,
            color: AppColors.onSurface,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 14,
            color: AppColors.onSurface,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onSurface,
          ),
          displaySmall: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onSurface,
          ),
          displayLarge: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 18,
            color: AppColors.onSurface,
          ),
          bodySmall: GoogleFonts.roboto(
            fontWeight: FontWeight.normal,
            height: 1.4,
            fontSize: 12,
            color: AppColors.onSurface,
          ),
          displayMedium: GoogleFonts.roboto(
            fontWeight: FontWeight.w300,
            height: 1.4,
            fontSize: 16,
            color: AppColors.onSurface,
          ),
        ),
      );

  ThemeData darkTheme() => lightTheme().copyWith(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: AppColors.primaryDark,
          onPrimary: AppColors.onPrimaryDark,
          secondary: AppColors.secondaryDark,
          onSecondary: AppColors.onSecondaryDark,
          error: AppColors.errorDark,
          onError: AppColors.onErrorDark,
          surface: AppColors.surfaceDark,
          onSurface: AppColors.onSurfaceDark,
          shadow: AppColors.shadowDark,
        ),
        textTheme: lightTheme().textTheme.merge(
              TextTheme(
                labelMedium: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  fontSize: 14,
                  color: AppColors.onSurfaceDark,
                ),
                labelLarge: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onSurfaceDark,
                ),
                titleSmall: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onSurfaceDark,
                ),
                titleMedium: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 18,
                  color: AppColors.onSurfaceDark,
                ),
                titleLarge: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                  fontSize: 20,
                  color: AppColors.onSurfaceDark,
                ),
                bodyMedium: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 14,
                  color: AppColors.onSurfaceDark,
                ),
                bodyLarge: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onSurfaceDark,
                ),
                displaySmall: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onSurfaceDark,
                ),
                displayLarge: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 18,
                  color: AppColors.onSurfaceDark,
                ),
                bodySmall: GoogleFonts.roboto(
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                  fontSize: 12,
                  color: AppColors.onSurfaceDark,
                ),
                displayMedium: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  height: 1.4,
                  fontSize: 16,
                  color: AppColors.onSurfaceDark,
                ),
              ),
            ),
      );
}

class ThemeService {
  static const defaultTheme = 'light';

  static String getDefaultTheme() {
    final context = rootNavigator.currentContext;
    if (context != null) {
      bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
      return isDarkMode ? 'dark' : 'light';
    } else {
      return ThemeMode.system.name;
    }
  }
}
