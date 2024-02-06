import 'package:flutter_template/app/pages/landing/landing_binding.dart';
import 'package:flutter_template/app/pages/landing/landing_screen.dart';
import 'package:get/get.dart';
import 'pages/login/login_binding.dart';
import 'pages/login/login_view.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const SIGN_UP = '/sign_up';
  static const FORGOT_PASSWORD = '/forgot_password';
  static const LANDING = '/landing';
  static const UNKNOWN = '/unknown';
}

class AppRoutes {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    ..._commonPages,
  ];

  static final _commonPages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.LANDING,
      page: () => const LandingScreen(),
      binding: LandingBinding(),
    ),
  ];
}