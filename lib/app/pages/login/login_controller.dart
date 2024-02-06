import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/app/app_routes.dart';
import 'package:flutter_template/app/base/base_controller.dart';
import 'package:flutter_template/app/pages/landing/landing_controller.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/request_auth_sign_in.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/response_auth_sign_in.dart';
import 'package:flutter_template/ports/clients/dto/user_accounts/details/response_user_account_details.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/clients/i_user_accounts_client.dart';
import 'package:flutter_template/ports/repository/dto/user_credentials.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:flutter_template/utils/validator.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../i18n/strings.g.dart';

class LoginController extends BaseController {
  final IUserCredentialsRepository _userCredentialsRepository = Get.find();
  final IUserAccountsClient _userAccountsClient = Get.find();
  final IAuthClient _authClient = Get.find<IAuthClient>();
  final LocalAuthentication  _auth = Get.find();

  late UserCredentials userCredentials;

  bool isEnabledLoginButton = false;
  bool isShownPassword = false;
  bool isCanUseBiometric = false;
  bool isHaveSession = false;

  String fullName = '';

  @override
  void onReady() {
    loadUser();
    biometricChecker();
    super.onReady();
  }

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    Get.focusScope?.unfocus();
    _handleLogin();
  }

  Future<void> _handleLogin() async {
    await callDataService<ResponseAuthSignIn>(
          () => _authClient.signIn(RequestAuthSignIn(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      )),
      waitOnSuccess: true,
      onSuccess: (response) async {
        await _userCredentialsRepository.updateCredentials(
          UserCredentials(
            isFirstLaunch: userCredentials.isFirstLaunch,
            isEnableBiometricLogin: userCredentials.isEnableBiometricLogin,
            accessToken: response.data.token,
            refreshToken: response.data.refreshToken,
            roleId: response.data.user.roleId,
            username: usernameController.text.trim(),
          ),
        );
        await _getUserAccountDetail();
        if (Get.isRegistered<LandingController>()) {
          Get.back(result: true);
        } else {
          Get.offAllNamed(Routes.LANDING);
        }
      },
    );
  }

  Future<void> _getUserAccountDetail() async {
    await callDataService<ResponseUserAccountDetails>(
          () => _userAccountsClient.getUserAccountDetails(),
      loading: false,
      onSuccess: (response) async {},
    );
  }

  void onNavigateForgotPassword() {
    Get.focusScope?.unfocus();
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  onChangedText(value) {
    if (ValidatorHelper.validateCommon(usernameController.text.trim()) ==
        ValidatorResult.valid &&
        ValidatorHelper.validateCommon(passwordController.text.trim()) ==
            ValidatorResult.valid) {
      isEnabledLoginButton = true;
    } else {
      isEnabledLoginButton = false;
    }
    update();
  }

  onTapShowPassword() {
    isShownPassword = !isShownPassword;
    update();
  }

  Future<void> loadUser() async {
    userCredentials = _userCredentialsRepository.getCredentials();
    if (userCredentials.accessToken != null) {
      isHaveSession = true;
      usernameController.text = userCredentials.username ?? '';
      fullName =
          _userAccountsClient.getLocalUserAccountDetails()?.fullName ?? '';
    }
  }

  Future<void> biometricChecker() async {
    if (userCredentials.refreshToken != null) {
      final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final bool isDeviceSupport =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      final List<BiometricType> availableBiometrics =
      await _auth.getAvailableBiometrics();

      if (isDeviceSupport &&
          userCredentials.isEnableBiometricLogin == true &&
          (availableBiometrics.contains(BiometricType.strong) ||
              availableBiometrics.contains(BiometricType.fingerprint))) {
        isCanUseBiometric = true;
        update();
      }
    }
  }

  Future<void> onTapButtonFinger() async {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: t.login_.authenticationDescription,
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuthenticate) {
        if (Get.isRegistered<LandingController>()) {
          Get.back(result: true);
        } else {
          Get.offAllNamed(Routes.LANDING);
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  Future<void> signOut() async {
    showLoading();
    await _authClient.signOut();
    _userCredentialsRepository.clearCredentials();
    isHaveSession = false;
    hideLoading();
    update();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
