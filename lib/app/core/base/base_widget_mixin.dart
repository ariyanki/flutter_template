import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../values/app_theme.dart';
import '../values/app_theme_data.dart';

mixin BaseWidgetMixin {
  AppThemeData get theme => AppTheme.of(Get.context!);
  Logger get logger => Get.find<Logger>();
}
