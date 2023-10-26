import 'package:flutter/foundation.dart';
import 'package:flutter_template/utils/check_optional.dart';
import 'package:quiver/core.dart';

@immutable
class AppSetting {
  const AppSetting({
    this.locale,
    this.themeMode,
  });

  AppLocaleMode? get appSettingLocaleEnum =>
      _appSettingLocaleEnumValues.map[locale];
  final String? locale;
  AppThemeMode? get appSettingThemeModeEnum =>
      _appSettingThemeModeEnumValues.map[themeMode];
  final String? themeMode;

  factory AppSetting.fromJson(Map<String, dynamic> json) => AppSetting(
      locale: json['locale']?.toString(),
      themeMode: json['themeMode']?.toString());

  Map<String, dynamic> toJson() => {'locale': locale, 'themeMode': themeMode};

  AppSetting clone() => AppSetting(locale: locale, themeMode: themeMode);

  AppSetting copyWith(
          {Optional<String?>? locale, Optional<String?>? themeMode}) =>
      AppSetting(
        locale: checkOptional(locale, () => this.locale),
        themeMode: checkOptional(themeMode, () => this.themeMode),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSetting &&
          locale == other.locale &&
          themeMode == other.themeMode;

  @override
  int get hashCode => locale.hashCode ^ themeMode.hashCode;
}

enum AppLocaleMode { en, id }

enum AppThemeMode { light, dark }

extension AppSettingLocaleEnumEx on AppLocaleMode {
  String? get value => _appSettingLocaleEnumValues.reverse[this];
}

final _appSettingLocaleEnumValues = _AppSettingLocaleEnumConverter({
  'en': AppLocaleMode.en,
  'id': AppLocaleMode.id,
});

class _AppSettingLocaleEnumConverter<String, O> {
  final Map<String, O> map;
  Map<O, String>? reverseMap;

  _AppSettingLocaleEnumConverter(this.map);

  Map<O, String> get reverse =>
      reverseMap ??= map.map((k, v) => MapEntry(v, k));
}

extension AppSettingThemeModeEnumEx on AppThemeMode {
  String? get value => _appSettingThemeModeEnumValues.reverse[this];
}

final _appSettingThemeModeEnumValues = _AppSettingThemeModeEnumConverter({
  'light': AppThemeMode.light,
  'dark': AppThemeMode.dark,
});

class _AppSettingThemeModeEnumConverter<String, O> {
  final Map<String, O> map;
  Map<O, String>? reverseMap;

  _AppSettingThemeModeEnumConverter(this.map);

  Map<O, String> get reverse =>
      reverseMap ??= map.map((k, v) => MapEntry(v, k));
}
