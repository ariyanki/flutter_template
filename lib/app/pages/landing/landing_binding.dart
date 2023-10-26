import 'package:flutter_template/app/pages/landing/landing_controller.dart';
import 'package:get/get.dart';

class LandingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(
      () => LandingController(),
      fenix: true,
    );
  }
}
