import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_controller.dart';
import 'app/bindings/local_source_bindings.dart';
import 'app/bindings/repository_bindings.dart';
import 'flavors/flavors.dart';

class DependencyInjection {
  static Future<void> init(Flavor flavor) async {
    await Get.putAsync(() => StorageService().init());
    await GetStorage.init();
    RepositoryBindings().dependencies();
    // RemoteSourceBindings().dependencies();
    LocalSourceBindings().dependencies();
    // await FirebaseConfig.registerNotification();
    // Get.lazyPut<DioConfigure>(() => DioConfigure(), fenix: true);
    // Get.lazyPut<Endpoints>(() => Endpoints(flavor), fenix: true);
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
