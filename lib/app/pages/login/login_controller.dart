import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:local_auth/local_auth.dart';
import 'package:flutter_template/app/core/base/base_controller.dart';
// import 'package:flutter_template/app/core/model/user_credentials.dart';
// import 'package:flutter_template/app/data/repository/user_accounts_repository.dart';
// import 'package:gg_flutter/app/modules/landing/landing_controller.dart';

import '../../../i18n/strings.g.dart';
import '../../core/utils/validator.dart';
// import '../../data/model/index.dart';
// import '../../data/repository/auth_repository.dart';
// import '../../data/repository/user_credentials_repository.dart';
import '../../routes/app_pages.dart';

class LoginController extends BaseController {
  // final UserCredentialsRepository _userCredentialsRepository = Get.find();
  // final UserAccountsRepository _userAccountsRepository = Get.find();
  // final AuthRepository _authRepository = Get.find<AuthRepository>();
  // final LocalAuthentication _auth = Get.find();

  // late UserCredentials userCredentials;

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
    // await callDataService<ResponseAuthSignIn>(
    //   () => _authRepository.signIn(RequestAuthSignIn(
    //     username: usernameController.text.trim(),
    //     password: passwordController.text.trim(),
    //     rememberMe: true,
    //   )),
    //   waitOnSuccess: true,
    //   onSuccess: (response) async {
    //     await _userCredentialsRepository.updateCredentials(
    //       UserCredentials(
    //         isFirstLaunch: userCredentials.isFirstLaunch,
    //         isEnableBiometricLogin: userCredentials.isEnableBiometricLogin,
    //         accessToken: response.data.token,
    //         refreshToken: response.data.refreshToken,
    //         roleId: response.data.user.roleId,
    //         username: usernameController.text.trim(),
    //       ),
    //     );
    //     await _getUserAccountDetail();
    //     // if (Get.isRegistered<LandingController>()) {
    //     //   Get.back(result: true);
    //     // } else {
    //     //   Get.offAllNamed(Routes.LANDING);
    //     // }
    //   },
    // );
  }

  Future<void> _getUserAccountDetail() async {
    // await callDataService<ResponseUserAccountDetails>(
    //   () => _userAccountsRepository.getUserAccountDetails(),
    //   loading: false,
    //   onSuccess: (response) async {},
    // );
  }

  // void onNavigateForgotPassword() {
  //   Get.focusScope?.unfocus();
  //   Get.toNamed(Routes.FORGOT_PASSWORD);
  // }

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
    // userCredentials = _userCredentialsRepository.getCredentials();
    // if (userCredentials.accessToken != null) {
    //   isHaveSession = true;
    //   usernameController.text = userCredentials.username ?? '';
    //   fullName =
    //       _userAccountsRepository.getLocalUserAccountDetails()?.fullName ?? '';
    // }
  }

  Future<void> biometricChecker() async {
    // if (userCredentials.refreshToken != null) {
    //   final bool canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    //   final bool isDeviceSupport =
    //       canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    //   final List<BiometricType> availableBiometrics =
    //       await _auth.getAvailableBiometrics();
    //
    //   if (isDeviceSupport &&
    //       userCredentials.isEnableBiometricLogin == true &&
    //       (availableBiometrics.contains(BiometricType.strong) ||
    //           availableBiometrics.contains(BiometricType.fingerprint))) {
    //     isCanUseBiometric = true;
    //     update();
    //   }
    // }
  }

  Future<void> onTapButtonFinger() async {
    // try {
    //   final bool didAuthenticate = await _auth.authenticate(
    //     localizedReason: t.login_.authenticationDescription,
    //     options: const AuthenticationOptions(biometricOnly: true),
    //   );
    //   if (didAuthenticate) {
    //     // if (Get.isRegistered<LandingController>()) {
    //     //   Get.back(result: true);
    //     // } else {
    //     //   Get.offAllNamed(Routes.LANDING);
    //     // }
    //   }
    // } catch (error) {
    //   if (kDebugMode) {
    //     print(error);
    //   }
    // }
  }

  Future<void> signOut() async {
    // showLoading();
    // await _authRepository.signOut();
    // _userCredentialsRepository.clearCredentials();
    // isHaveSession = false;
    // hideLoading();
    // update();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
