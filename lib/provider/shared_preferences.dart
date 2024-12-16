import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefsProvider = StateProvider<SharedPreferences?>((ref) => null);

class PrefKeys {
  static const appLocale = "app_locale";
  static const appTheme = "app_theme";
  static const currentPageIndex = "currentPageIndex";
}
