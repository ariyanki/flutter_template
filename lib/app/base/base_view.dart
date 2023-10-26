import 'package:flutter/material.dart';
import 'package:flutter_template/app/base/base_widget_mixin.dart';
import 'package:flutter_template/app/widgets/loading_overlay_widget.dart';
import 'package:flutter_template/ports/enum/page_state.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

abstract class BaseView<T extends BaseController> extends StatelessWidget
    with BaseWidgetMixin {
  const BaseView({Key? key}) : super(key: key);

  T get controller => Get.find<T>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return Stack(
          children: [
            buildScreen(context),
            if (_.pageState == PageState.LOADING) const LoadingOverlayWidget()
          ],
        );
      },
    );
  }

  Widget buildScreen(BuildContext context);
}

abstract class BaseViewWithoutLoading<T extends BaseController>
    extends StatelessWidget with BaseWidgetMixin {
  const BaseViewWithoutLoading({Key? key}) : super(key: key);

  T get controller => Get.find<T>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<T>(
      builder: (_) {
        return buildWidget(context);
      },
    );
  }

  Widget buildWidget(BuildContext context);
}
