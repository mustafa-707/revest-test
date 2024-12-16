import 'package:flutter/material.dart';
import 'package:revest/utils/lang/locale.export.dart';

extension MediaHelper<T> on BuildContext {
  // Dimensions
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get aspectRatio => width / height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  // Directionality
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
  // Navigator
  NavigatorState get navigator => Navigator.of(this);
  // Translations
  AppLocalizations get translate => AppLocalizations.of(this)!;
  Locale get locale => Localizations.localeOf(this);
  bool get isArabic => Localizations.localeOf(this).languageCode == 'ar';

  T get arguments => ModalRoute.of(this)!.settings.arguments as T;
  // Text Styles
  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!;
  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get bodyLarge => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get displayMedium => Theme.of(this).textTheme.displayMedium!;
  TextStyle get displaySmall => Theme.of(this).textTheme.displaySmall!;
  TextStyle get displayLarge => Theme.of(this).textTheme.displayLarge!;
  TextStyle get labelLarge => Theme.of(this).textTheme.labelLarge!;

  // Colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;
  Color get shadowColor => Theme.of(this).colorScheme.shadow;
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get onErrorColor => Theme.of(this).colorScheme.onError;
}
