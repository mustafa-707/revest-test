import 'dart:io';

import 'package:flutter/widgets.dart';

class Language {
  final String code;
  final String name;

  const Language({
    required this.code,
    required this.name,
  });
}

class LocaleService {
  static const List<Language> supportedLocales = [
    Language(
      code: 'ar',
      name: 'عربي',
    ),
    Language(
      code: 'en',
      name: 'English',
    ),
  ];

  /// default language code
  static const String defaultLocale = 'en';

  /// System locale
  static Locale _getPlatformLocale() {
    final currentLocale = Platform.localeName;

    if (currentLocale.length == 2) {
      return Locale.fromSubtags(languageCode: currentLocale);
    } else {
      final parts = currentLocale.split('_');
      if (parts.isNotEmpty) {
        return Locale.fromSubtags(languageCode: parts[0]);
      } else {
        return const Locale('en');
      }
    }
  }

  static Language getInfo(String code) {
    return supportedLocales.firstWhere((element) => element.code == code);
  }

  static bool isSupportedLocale(String locale) {
    return supportedLocales.map((l) => l.code).contains(locale);
  }

  /// Returns system locale if supported, otherwise default locale (english)
  static String getDefaultLocale() {
    final platformLocale = _getPlatformLocale().languageCode;
    if (isSupportedLocale(platformLocale)) {
      return platformLocale;
    } else {
      return defaultLocale;
    }
  }
}
