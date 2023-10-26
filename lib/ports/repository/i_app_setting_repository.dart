import 'dart:ui';

import 'package:flutter_template/values/app_theme_data.dart';

import 'dto/app_setting.dart';

abstract class IAppSettingRepository {
  AppSetting getAppSetting();

  Future<bool> updateAppSetting(AppSetting appSetting);

  AppThemeData? getAppThemeData();
  Future<void> changeThemeMode(AppThemeMode themeMode);
  Future switchThemeMode();
  bool isDarkMode();

  Locale? getLocale();
  Future<void> changeLocaleMode(AppLocaleMode themeMode);
  Future switchLocaleMode();
}