import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
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
    Get.put<DioConfigure>(MockDioConfigure());
    Get.put<IUserCredentialsRepository>(MockUserCredentialsRepository());
    Get.put<LocalAuthentication>(MockLocalAuthentication());
    Get.put<IUserAccountsClient>(MockUserAccountsClient());
  });
  test('init controller', () async {
    expect(() => Get.find<LoginController>(), throwsA(isA()));
    Get.put(LoginController());
    // expect controller in memory
    expect(Get.find<LoginController>(), isInstanceOf<LoginController>());
    // expect delete controller success
    Get.delete<LoginController>();
    expect(() => Get.find<LoginController>(), throwsA(isA()));
  });
}
