import 'package:flutter/material.dart';

import '../base/base_widget_mixin.dart';
import '../utils/size_config.dart';

class LoadingOverlayWidget extends StatelessWidget with BaseWidgetMixin {
  const LoadingOverlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      width: SizeConfig().screenWidth,
      height: SizeConfig().screenHeight,
      child: Center(
        child: CircularProgressIndicator(
          color: theme.brandingBlue,
        ),
      ),
    );
  }
}
