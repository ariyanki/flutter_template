import 'package:flutter_template/adapters/clients/auth_client.dart';
import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
import 'package:flutter_template/adapters/clients/network/endpoint.dart';
import 'package:flutter_template/adapters/clients/user_accounts_client.dart';
import 'package:flutter_template/adapters/repository/app_setting_repository.dart';
import 'package:flutter_template/adapters/repository/user_accounts_repository.dart';
import 'package:flutter_template/adapters/repository/user_credentials_repository.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/clients/i_user_accounts_client.dart';
import 'package:flutter_template/ports/repository/i_app_setting_repository.dart';
import 'package:flutter_template/ports/repository/i_user_accounts_repository.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_controller.dart';
import 'flavors.dart';

class DependencyInjection {
  static Future<void> init(Flavor flavor) async {
    await Get.putAsync(() => StorageService().init());
    await GetStorage.init();
    LocalResourceBindings().dependencies();
    LocalRepositoryBindings().dependencies();
    ClientBindings().dependencies();
    // await FirebaseConfig.registerNotification();
    Get.lazyPut<DioConfigure>(() => DioConfigure(), fenix: true);
    Get.lazyPut<Endpoints>(() => Endpoints(flavor), fenix: true);
    Get.lazyPut<AppController>(() => AppControllerImpl(), fenix: true);
    Get.lazyPut<Logger>(
          () => Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 100,
          colors: false,
          printEmojis: true,
          printTime: true,
        ),
      ),
      fenix: true,
    );
  }
}

class StorageService extends GetxService {
  Future<SharedPreferences> init() async {
    return await SharedPreferences.getInstance();
  }
}

class LocalResourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalAuthentication>(
          () => LocalAuthentication(),
      fenix: true,
    );
  }
}

class LocalRepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAppSettingRepository>(
          () => AppSettingRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<IUserCredentialsRepository>(
          () => UserCredentialsRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<IUserAccountsRepository>(
          () => UserAccountsRepositoryImpl(),
      fenix: true,
    );
  }
}

class ClientBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAuthClient>(
          () => AuthClientImpl(),
      fenix: true,
    );
    Get.lazyPut<IUserAccountsClient>(
          () => UserAccountsClientImpl(),
      fenix: true,
    );
  }
}
