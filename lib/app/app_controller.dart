import 'package:flutter/material.dart';
import 'package:flutter_template/app/app_routes.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/repository/dto/app_setting.dart';
import 'package:flutter_template/ports/repository/i_app_setting_repository.dart';
import 'package:flutter_template/themes/app_theme_data.dart';
import 'package:get/get.dart';

abstract class AppController extends GetxController {
  AppThemeData themeData = AppThemeData.light;

  void fetchTheme();

  void fetchLocale();

  Future<void> changeTheme([AppThemeMode? themeMode]);

  Future<void> changeLocale([AppLocaleMode? localeMode]);
}

class AppControllerImpl extends AppController with WidgetsBindingObserver {
  final _appSettingRepository = Get.find<IAppSettingRepository>();
  final _authClient = Get.find<IAuthClient>();
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
    themeData = AppThemeData.light;
    update();
  }

  @override
  void fetchLocale() {
    const locale = Locale('id', 'ID');
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
        if (shouldLogout()) {
          _authClient.signOut();
          Get.offAllNamed(Routes.LOGIN);
        }
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
