import 'package:flutter/material.dart';

import 'app_theme_data.dart';

class AppTheme extends InheritedWidget {
  final AppThemeData appTheme;
  const AppTheme({
    Key? key,
    required Widget child,
    required this.appTheme,
  }) : super(key: key, child: child);

  static AppThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!.appTheme;
  }

  @override
  bool updateShouldNotify(AppTheme oldWidget) => appTheme != oldWidget.appTheme;
}
