import 'package:flutter/material.dart';
import 'package:flutter_template/themes/app_theme_data.dart';

class AppDefaultTheme {
  static ThemeData theme(AppThemeData appThemeData) => ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: appThemeData.textBlack,
            fontWeight: FontWeight.w400,
            fontSize: 15,
            height: 1.45,
          ),
        ),
      );
}
