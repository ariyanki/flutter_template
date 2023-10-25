import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';

import '../app/app.dart';
import '../di.dart';
import '../i18n/strings.g.dart';
import 'flavors.dart';

Future<void> buildFlavor(Flavor flavor) async {
  Intl.defaultLocale = "id";
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  LocaleSettings.setLocaleRaw("id");

  FlavorConfigs.appFlavor = flavor;

  await DependencyInjection.init(flavor);

  runApp(const App());
}
