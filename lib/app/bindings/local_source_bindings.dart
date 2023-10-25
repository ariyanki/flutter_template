import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:flutter_template/app/data/local/app_setting_data_source.dart';
// import 'package:gg_flutter/app/data/local/user_account_local_data_source.dart';

// import '../data/local/user_credentials_data_source.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppSettingDataSource>(
      () => AppSettingDataSourceImpl(),
      fenix: true,
    );
    // Get.lazyPut<UserCredentialsDataSource>(
    //   () => UserCredentialsDataSourceImpl(),
    //   fenix: true,
    // );
    // Get.lazyPut<UserAccountLocalDataSource>(
    //   () => UserAccountLocalDataSourceImpl(),
    //   fenix: true,
    // );
    // Get.lazyPut<LocalAuthentication>(
    //   () => LocalAuthentication(),
    //   fenix: true,
    // );
  }
}
