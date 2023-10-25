import 'dart:convert';
import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:quiver/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/model/app_setting.dart';

abstract class AppSettingDataSource {
  AppSetting getAppSetting();

  Future<bool> updateAppSetting(AppSetting appSetting);
}

class AppSettingDataSourceImpl implements AppSettingDataSource {
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
}
