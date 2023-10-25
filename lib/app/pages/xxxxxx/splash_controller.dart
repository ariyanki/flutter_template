import 'package:get/get.dart';
import 'package:flutter_template/app/routes/app_pages.dart';

import '../../core/base/base_controller.dart';

class SplashController extends BaseController {

  @override
  void onReady() {
    startAppHandler();
    super.onReady();
  }

  Future<void> startAppHandler() async {
    Get.offAllNamed(Routes.LOGIN);
  }
}
