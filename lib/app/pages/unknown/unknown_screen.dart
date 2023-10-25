import 'package:flutter/material.dart';
import 'package:flutter_template/app/core/utils/link.dart';
import 'package:flutter_template/gen/assets.gen.dart';

import '../../core/utils/size_config.dart';

class UnknownScreen extends StatefulWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  State<UnknownScreen> createState() => _UnknownScreenState();
}

class _UnknownScreenState extends State<UnknownScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => LinkHelper.navigateToTarget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Assets.images.splashScreenBackground.image(fit: BoxFit.cover),
    );
  }
}
