
enum Flavor {
  DEV,
  UAT,
  PROD,
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

  static String get DEV_URL {
    return 'https://dev.abcdef.id/';
  }

  static String get UAT_URL {
    return 'https://uat.abcdef.id/';
  }

  static String get PRODUCTION_URL {
    return 'https://prod.abcdef.id/';
  }

  static String get baseURL {
    switch (appFlavor) {
      case Flavor.UAT:
        return UAT_URL;
      case Flavor.PROD:
        return PRODUCTION_URL;
      default:
        return DEV_URL;
    }
  }
}
