import 'package:flutter/material.dart';

import '../../core/base/base_view.dart';
import '../../core/utils/size_config.dart';
import 'splash_controller.dart';

class SplashScreen extends BaseView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    SizeConfig().init(context);
    return const SizedBox();
  }
}
