import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:flutter_template/ports/repository/dto/app_setting.dart';
import 'package:flutter_template/ports/repository/i_app_setting_repository.dart';
import 'package:flutter_template/values/app_theme_data.dart';
import 'package:get/get.dart';
import 'package:quiver/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingRepositoryImpl implements IAppSettingRepository {

  final _sharedPreferences = Get.find<SharedPreferences>();

  static const key = 'app_setting';

  @override
  AppSetting getAppSetting() {
    final systemThemeMode =
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark
        ? AppThemeMode.dark.value!
        : AppThemeMode.light.value!;
    final rawAppSetting = _sharedPreferences.getString(key);
    late AppSetting appSetting;
    if (rawAppSetting != null) {
      appSetting = AppSetting.fromJson(
        jsonDecode(rawAppSetting),
      );
    } else {
      appSetting = const AppSetting();
    }
    return appSetting.copyWith(
      themeMode: Optional.of(
        appSetting.themeMode ?? systemThemeMode,
      ),
    );
  }

  @override
  Future<bool> updateAppSetting(AppSetting appSetting) {
    return _sharedPreferences.setString(
      key,
      jsonEncode(appSetting.toJson()),
    );
  }

  @override
  AppThemeData? getAppThemeData() {
    final themeMode =
        getAppSetting().appSettingThemeModeEnum;
    switch (themeMode) {
      case AppThemeMode.light:
        return AppThemeData.light;
      case AppThemeMode.dark:
        return AppThemeData.dark;
      default:
        return null;
    }
  }

  @override
  Future<void> changeThemeMode(AppThemeMode themMode) async {
    final appSetting = getAppSetting();
    await updateAppSetting(appSetting.copyWith(
      themeMode: Optional.of(themMode.value),
    ));
  }

  @override
  Future switchThemeMode() async {
    final themeMode =
        getAppSetting().appSettingThemeModeEnum;
    switch (themeMode) {
      case AppThemeMode.dark:
        await changeThemeMode(AppThemeMode.light);
        break;
      case AppThemeMode.light:
        await changeThemeMode(AppThemeMode.dark);
        break;
      default:
    }
  }

  @override
  Locale? getLocale() {
    final localeMode =
        getAppSetting().appSettingLocaleEnum;
    switch (localeMode) {
      case AppLocaleMode.en:
        return const Locale('en_US');
      case AppLocaleMode.id:
        return const Locale('id_ID');
      default:
        final codes = Platform.localeName;
        return Locale(codes.split('_')[0]);
    }
  }

  @override
  Future<void> changeLocaleMode(AppLocaleMode localeMode) async {
    final appSetting = getAppSetting();
    await updateAppSetting(appSetting.copyWith(
      locale: Optional.of(localeMode.value),
    ));
  }

  @override
  Future switchLocaleMode() async {
    final localeMode =
        getAppSetting().appSettingLocaleEnum;
    switch (localeMode) {
      case AppLocaleMode.id:
        changeLocaleMode(AppLocaleMode.en);
        break;
      case AppLocaleMode.en:
        changeLocaleMode(AppLocaleMode.id);
        break;
      default:
        changeLocaleMode(AppLocaleMode.en);
        break;
    }
  }

  @override
  bool isDarkMode() {
    return getAppSetting().appSettingThemeModeEnum ==
        AppThemeMode.dark;
  }
}
