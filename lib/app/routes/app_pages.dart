import 'package:get/get.dart';
import '../pages/login/login_binding.dart';
import '../pages/login/login_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    ..._commonPages,
  ];

  static final _commonPages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
