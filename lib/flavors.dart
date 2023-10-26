import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/app/app.dart';
import 'package:flutter_template/dependency_injection.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:intl/intl.dart';

enum Flavor {
  DEV,
  UAT,
  PROD,
}

Future<void> buildFlavor(Flavor flavor) async {
  Intl.defaultLocale = "id";
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  LocaleSettings.setLocaleRaw("id");

  FlavorConfigs.appFlavor = flavor;

  await DependencyInjection.init(flavor);

  runApp(const App());
}

class FlavorConfigs {
  static String appName = 'GG Flutter';
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.UAT:
        return '$appName UAT';
      case Flavor.PROD:
        return appName;
      default:
        return '$appName DEV';
    }
  }

  static bool get isDEV => FlavorConfigs.appFlavor == Flavor.DEV;
  static bool get isUAT => FlavorConfigs.appFlavor == Flavor.UAT;
  static bool get isPROD => FlavorConfigs.appFlavor == Flavor.PROD;

  static String get DEV_URL_IAM {
    return 'https://dev.abcdef.id/';
  }

  static String get UAT_URL_IAM {
    return 'https://uat.abcdef.id/';
  }

  static String get PRODUCTION_URL_IAM {
    return 'https://prod.abcdef.id/';
  }

  static String get baseURLIAM {
    switch (appFlavor) {
      case Flavor.UAT:
        return UAT_URL_IAM;
      case Flavor.PROD:
        return PRODUCTION_URL_IAM;
      default:
        return DEV_URL_IAM;
    }
  }
}
