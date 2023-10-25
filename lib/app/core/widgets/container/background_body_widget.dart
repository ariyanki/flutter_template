import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/base/base_widget_mixin.dart';
import 'package:flutter_template/gen/assets.gen.dart';

class BackgroundBodyWidget extends StatelessWidget with BaseWidgetMixin {
  final Widget child;
  const BackgroundBodyWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Assets.images.splashScreenBackground.image(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            key: const ValueKey('intro_background_image'),
          ),
          child,
        ],
      ),
    );
  }
}
