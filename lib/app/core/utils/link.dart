import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class LinkHelper {
  static String _route = '';
static String _data = '';

  static void updateRoutingData(
      String targetRoute,
      dynamic linkData,
      ) {
    _route = targetRoute;
_data = linkData;
  }

  static void navigateToTarget() {
    Get.offNamedUntil(
      _route,
      ModalRoute.withName(_route),
    );
  }

  static void handleAppLinkRouting(String url) {
    updateRoutingData(Routes.LOGIN, '');
  }
}
