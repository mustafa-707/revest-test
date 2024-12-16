import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:revest/utils/lang/locale.dart';
import 'package:revest/utils/theme/app_theme.dart';

part '../../generated/data/models/app_settings.freezed.dart';

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    required String locale,
    required String theme,
  }) = _AppSettings;

  static const default_ = AppSettings(
    locale: LocaleService.defaultLocale,
    theme: ThemeService.defaultTheme,
  );
}
