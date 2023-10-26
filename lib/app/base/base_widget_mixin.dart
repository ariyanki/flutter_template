import 'package:flutter_template/themes/app_theme.dart';
import 'package:flutter_template/themes/app_theme_data.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

mixin BaseWidgetMixin {
  AppThemeData get theme => AppTheme.of(Get.context!);
  Logger get logger => Get.find<Logger>();
}
