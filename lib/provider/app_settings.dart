import 'package:revest/data/models/app_settings.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revest/provider/shared_preferences.dart';
import 'package:revest/utils/lang/locale.dart';
import 'package:revest/utils/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appSettingsProvider = StateNotifierProvider<AppSettingsController, AppSettings>((ref) {
  final sharedPrefs = ref.watch(sharedPrefsProvider);

  return AppSettingsController(sharedPrefs, ref);
});

class AppSettingsController extends StateNotifier<AppSettings> {
  final SharedPreferences? sharedPreferences;
  final Ref ref;
  AppSettingsController(
    this.sharedPreferences,
    this.ref,
  ) : super(_settingsFromPrefs(sharedPreferences, ref));

  static AppSettings _settingsFromPrefs(SharedPreferences? prefs, Ref ref) {
    final locale = prefs?.getString(PrefKeys.appLocale);
    final theme = prefs?.getString(PrefKeys.appTheme);

    return AppSettings(
      locale: locale ?? LocaleService.getDefaultLocale(),
      theme: theme ?? ThemeService.getDefaultTheme(),
    );
  }

  Future<void> updateLocale(String locale) async {
    if (LocaleService.isSupportedLocale(locale)) {
      await sharedPreferences!.setString(PrefKeys.appLocale, locale);
      state = _settingsFromPrefs(sharedPreferences, ref);
    } else {
      throw Exception("Unsupported locale '$locale'");
    }
  }

  Future<void> updateTheme(String theme) async {
    await sharedPreferences!.setString(PrefKeys.appTheme, theme);
    state = _settingsFromPrefs(sharedPreferences, ref);
  }
}

final currentLocaleProvider = Provider<String>(
  (ref) => ref.watch(appSettingsProvider.select((settings) => settings.locale)),
);

final currentThemeProvider = Provider<String>(
  (ref) => ref.watch(appSettingsProvider.select((settings) => settings.theme)),
);
