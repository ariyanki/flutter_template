import 'package:get/get.dart';
import '../data/repository/app_setting_repository.dart';
// import '../data/repository/auth_repository.dart';
// import '../data/repository/user_accounts_repository.dart';
// import '../data/repository/user_credentials_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppSettingRepository>(
      () => AppSettingRepositoryImpl(),
      fenix: true,
    );
    // Get.lazyPut<AuthRepository>(
    //   () => AuthRepositoryImpl(),
    //   fenix: true,
    // );
    // Get.lazyPut<UserAccountsRepository>(
    //   () => UserAccountsRepositoryImpl(),
    //   fenix: true,
    // );
    // Get.lazyPut<UserCredentialsRepository>(
    //   () => UserCredentialsRepositoryImpl(),
    //   fenix: true,
    // );
    // Get.lazyPut<UserAccountsRepository>(
    //   () => UserAccountsRepositoryImpl(),
    // );
  }
}
