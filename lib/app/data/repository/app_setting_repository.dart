import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:quiver/core.dart';

import '../../core/model/app_setting.dart';
import '../../core/values/app_theme_data.dart';
import '../local/app_setting_data_source.dart';

abstract class AppSettingRepository {
  AppThemeData? getAppThemeData();
  Future<void> changeThemeMode(AppThemeMode themeMode);
  Future switchThemeMode();
  bool isDarkMode();

  Locale? getLocale();
  Future<void> changeLocaleMode(AppLocaleMode themeMode);
  Future switchLocaleMode();
}

class AppSettingRepositoryImpl implements AppSettingRepository {
  final AppSettingDataSource _appSettingDataSource =
      Get.find<AppSettingDataSource>();

  @override
  AppThemeData? getAppThemeData() {
    final themeMode =
        _appSettingDataSource.getAppSetting().appSettingThemeModeEnum;
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
    final appSetting = _appSettingDataSource.getAppSetting();
    await _appSettingDataSource.updateAppSetting(appSetting.copyWith(
      themeMode: Optional.of(themMode.value),
    ));
  }

  @override
  Future switchThemeMode() async {
    final themeMode =
        _appSettingDataSource.getAppSetting().appSettingThemeModeEnum;
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
        _appSettingDataSource.getAppSetting().appSettingLocaleEnum;
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
    final appSetting = _appSettingDataSource.getAppSetting();
    await _appSettingDataSource.updateAppSetting(appSetting.copyWith(
      locale: Optional.of(localeMode.value),
    ));
  }

  @override
  Future switchLocaleMode() async {
    final localeMode =
        _appSettingDataSource.getAppSetting().appSettingLocaleEnum;
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
    return _appSettingDataSource.getAppSetting().appSettingThemeModeEnum ==
        AppThemeMode.dark;
  }
}
