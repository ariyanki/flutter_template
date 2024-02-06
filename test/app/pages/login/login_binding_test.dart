import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
import 'package:flutter_template/app/pages/login/login_binding.dart';
import 'package:flutter_template/app/pages/login/login_controller.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/clients/i_user_accounts_client.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../mocks/client_mock.dart';
import '../../../mocks/repository_mocks.dart';

void main() {
  setUpAll(() {
    Get.put<IAuthClient>(MockAuthClient());
    Get.put<IUserCredentialsRepository>(MockUserCredentialsRepository());
    Get.put<DioConfigure>(MockDioConfigure());
    Get.put<LocalAuthentication>(MockLocalAuthentication());
    Get.put<IUserAccountsClient>(MockUserAccountsClient());
  });
  test('Test LoginBinding', () async {
    // if bindings isn't triggered yet, expect can't find controller
    expect(() => Get.find<LoginController>(), throwsA(isA<String>()));

    // if bindings is triggered already, expect can find controller
    LoginBinding().dependencies();
    expect(
      Get.find<LoginController>(),
      isInstanceOf<LoginController>(),
    );
  });
}
