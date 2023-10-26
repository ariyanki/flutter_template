import 'package:flutter/material.dart';
import 'package:flutter_template/app/base/base_widget_mixin.dart';
import 'package:flutter_template/utils/size_config.dart';

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
          color: theme.brandingGreen,
        ),
      ),
    );
  }
}
