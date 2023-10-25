import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/model/app_setting.dart';
import 'core/values/app_theme_data.dart';
import 'data/repository/app_setting_repository.dart';

abstract class AppController extends GetxController {
  AppThemeData themeData = AppThemeData.light;

  void fetchTheme();

  void fetchLocale();

  Future<void> changeTheme([AppThemeMode? themeMode]);

  Future<void> changeLocale([AppLocaleMode? localeMode]);
}

class AppControllerImpl extends AppController with WidgetsBindingObserver {
  final _appSettingRepository = Get.find<AppSettingRepository>();
  // final _authRepository = Get.find<AuthRepository>();
  final _maxInactiveTime = const Duration(minutes: 15);
  int? _timeStartPauseApp;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    fetchTheme();
    fetchLocale();
  }

  @override
  void fetchTheme() {
    themeData = _appSettingRepository.getAppThemeData()!;
    themeData = AppThemeData.light;
    update();
  }

  @override
  void fetchLocale() {
    // final locale = _appSettingRepository.getLocale()!;
    const locale = Locale('id', 'ID');
    // I18n.locale = locale;
    Get.updateLocale(locale);
  }

  @override
  Future<void> changeTheme([AppThemeMode? themeMode]) async {
    if (themeMode == null) {
      await _appSettingRepository.switchThemeMode();
    } else {
      await _appSettingRepository.changeThemeMode(themeMode);
    }
    fetchTheme();
  }

  @override
  Future<void> changeLocale([AppLocaleMode? localeMode]) async {
    if (localeMode == null) {
      await _appSettingRepository.switchLocaleMode();
    } else {
      await _appSettingRepository.changeLocaleMode(localeMode);
    }
    fetchLocale();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        // if (shouldLogout()) {
        //   _authRepository.signOut();
        //   Get.offAllNamed(Routes.LOGIN);
        // }
        fetchTheme();
        fetchLocale();
        break;
      case AppLifecycleState.paused:
        _timeStartPauseApp = DateTime.now().millisecondsSinceEpoch;
        break;
      default:
    }
  }

  bool shouldLogout() {
    if (_timeStartPauseApp == null) return false;
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - _timeStartPauseApp! > _maxInactiveTime.inMilliseconds) {
      _timeStartPauseApp = null;
      return true;
    }
    return false;
  }
}
