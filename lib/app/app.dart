import 'package:flutter/material.dart';
import 'package:revest/app/app.router.dart';
import 'package:revest/presentation/components/behaviors/scroll_behavior.dart';
import 'package:revest/presentation/screens/splash/splash_screen.dart';
import 'package:revest/provider/app_settings.dart';
import 'package:revest/utils/global_navigator.dart';
import 'package:revest/utils/lang/locale.dart';
import 'package:revest/utils/lang/locale.export.dart';
import 'package:revest/utils/theme/app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(currentLocaleProvider);
    final theme = ref.watch(currentThemeProvider);

    return MaterialApp(
      title: 'Revest',
      navigatorKey: rootNavigator,
      themeMode: ThemeMode.values.firstWhere(
        (element) => element.name == theme,
      ),
      theme: theme == ThemeMode.dark.name ? AppThemes(locale).darkTheme() : AppThemes(locale).lightTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [for (var supportedLocale in LocaleService.supportedLocales) Locale(supportedLocale.code)],
      locale: Locale(locale),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: onGenerateRoute,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: MediaQuery(
            data: data.copyWith(
              textScaler: const TextScaler.linear(1.0),
            ),
            child: child ?? const SizedBox(),
          ),
        );
      },
    );
  }
}
