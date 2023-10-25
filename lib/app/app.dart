import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:flutter_template/app/core/utils/link.dart';
import 'package:flutter_template/app/core/values/app_default_theme.dart';
import 'package:flutter_template/app/pages/unknown/unknown_screen.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:uni_links/uni_links.dart';

import '/app/routes/app_pages.dart';
import '../flavors/flavors.dart';
import '../i18n/strings.g.dart';
import 'app_controller.dart';
import 'core/values/app_theme.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialLink();
  }

  Future<void> _handleInitialLink() async {
    await Future.delayed(const Duration(milliseconds: 700));
    FlutterNativeSplash.remove();
    try {
      final link = await getInitialLink();

      if (link == null) return;
      LinkHelper.handleAppLinkRouting(link);
    } catch (_) {
      LinkHelper.updateRoutingData(Routes.LOGIN, false);
    }
    if (Platform.isIOS) LinkHelper.navigateToTarget();
  }

  Future<void> _handleIncomingLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) async {
      LinkHelper.handleAppLinkRouting(uri.toString());
      if (Platform.isIOS) LinkHelper.navigateToTarget();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return GetBuilder<AppController>(
          builder: (controller) => AppTheme(
            appTheme: controller.themeData,
            child: GetMaterialApp(
              title: FlavorConfigs.name,
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              unknownRoute: GetPage(
                name: Routes.UNKNOWN,
                page: () => const UnknownScreen(),
              ),
              localizationsDelegates: const [
                MonthYearPickerLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: AppDefaultTheme.theme(controller.themeData),
              supportedLocales: AppLocaleUtils.supportedLocales,
              debugShowCheckedModeBanner: FlavorConfigs.isDEV,
              // localeResolutionCallback: i18n.resolution(
              //   fallback: const Locale("en", "US"),
              // ),
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child ?? const SizedBox(),
              ),
            ),
          ),
        );
      },
    );
  }
}
