import 'package:flutter/material.dart';
import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
import 'package:flutter_template/app/app_routes.dart';
import 'package:flutter_template/app/pages/login/login_binding.dart';
import 'package:flutter_template/app/pages/login/login_controller.dart';
import 'package:flutter_template/app/pages/login/login_screen.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/clients/i_user_accounts_client.dart';
import 'package:flutter_template/ports/enum/user_role_acl.dart';
import 'package:flutter_template/ports/repository/dto/user_credentials.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/client_mock.dart';
import '../../../mocks/data/user_account_details_fake_data.dart';
import '../../../mocks/repository_mocks.dart';

void main() {
  final mockAuthClient = MockAuthClient();
  final mockUserCredentialsRepository = MockUserCredentialsRepository();
  final mockLocalAuthentication = MockLocalAuthentication();
  final mockUserAccountsClient = MockUserAccountsClient();

  final scrollPage = find.byKey(const ValueKey('scrollview_login_page'));
  final usernameTextField = find.byKey(
    const ValueKey('login_username_text_field'),
  );
  final passWordTextField = find.byKey(
    const ValueKey('login_password_text_field'),
  );
  final showPasswordIcon = find.byKey(
    const ValueKey('password_visibility_on_icon'),
  );
  final hidePasswordIcon = find.byKey(
    const ValueKey('password_visibility_off_icon'),
  );
  final passwordObscureButton = find.byKey(
    const ValueKey('toggle_obscure_password_button'),
  );
  final loginButton = find.byKey(
    const ValueKey('login_button'),
  );
  final forgotPasswordButton = find.byKey(
    const ValueKey('forgot_password_button'),
  );
  final signUpButton = find.byKey(
    const ValueKey('signup_button'),
  );
  final errorSnackBar = find.byKey(
    const ValueKey('data_service_error_snack_bar'),
  );
  final fingerprintButton = find.byKey(
    const ValueKey('login_by_fingerprint'),
  );
  final buttonLoginOtherAccount = find.byKey(
    const ValueKey('login_other_account_button'),
  );

  setUpAll(() {
    registerFallbackValue(FakeRequestAuthSignIn());
    registerFallbackValue(FakeUserCredentials());
    registerFallbackValue(FakeAuthenticationOptions());
    Get.put(Logger());
    Get.put<IAuthClient>(mockAuthClient);
    Get.put<DioConfigure>(MockDioConfigure());
    Get.put<IUserCredentialsRepository>(mockUserCredentialsRepository);
    Get.put<IUserAccountsClient>(mockUserAccountsClient);
    Get.put<DioConfigure>(MockDioConfigure());
    Get.put<LocalAuthentication>(mockLocalAuthentication);

    when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
      const UserCredentials(isFirstLaunch: false),
    );
    when(() => mockUserCredentialsRepository.updateCredentials(any()))
        .thenAnswer((_) async {
      return true;
    });
    when(() => mockUserAccountsClient.getLocalUserAccountDetails())
        .thenReturn(
      UserAccountDetailFakeData.successResponseWithRole(
              UserRoleACL.admin)
          .data,
    );
  });

  tearDown(() {
    Get.delete<LoginController>();
  });

  Future<void> _buildWidget(WidgetTester tester) async {
    LoginBinding().dependencies();
    await tester.pumpWidget(
      testableWidgetCustomRoutesWithoutBuilder<LoginController>(
        child: const LoginScreen(),
        controller: LoginController(),
        routes: {
          Routes.SIGN_UP: (_) => const SizedBox(),
          Routes.DASHBOARD: (_) => const SizedBox(),
          Routes.CONNECT_ACCOUNT_OPTIONS: (_) => const SizedBox(),
        },
      ),
    );
  }

  Future<void> _enterValidData(WidgetTester tester) async {
    await tester.enterText(usernameTextField, 'duc123');
    await tester.enterText(passWordTextField, 'G@uyeusoc123');
    await tester.pump();
  }

  group('password text field', () {
    testWidgets(
      'should hide password when initialize',
      (tester) async {
        await _buildWidget(tester);
        final controller = Get.find<LoginController>();
        expect(controller.isShownPassword, false);
        expect(showPasswordIcon, findsOneWidget);
      },
    );
    testWidgets(
      'should show password when click show password',
      (tester) async {
        await _buildWidget(tester);
        final controller = Get.find<LoginController>();
        await tester.tap(passwordObscureButton);
        await tester.pumpAndSettle();
        expect(controller.isShownPassword, true);
        expect(hidePasswordIcon, findsOneWidget);
      },
    );
  });

  group('fullname text', () {
    testWidgets(
      'should show fullname when userCredential has data',
      (tester) async {
        const userCredentials = UserCredentials(
          isFirstLaunch: false,
          username: 'Duc123',
          accessToken: 'abc',
        );
        when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
          userCredentials,
        );

        await _buildWidget(tester);
        expect(
          Get.find<LoginController>().fullName,
          UserAccountDetailFakeData.successResponseWithRole(
                  UserRoleACL.systemAdmin1)
              .data!
              .fullName,
        );
      },
    );
    testWidgets(
      'should not show username when userCredential has no username',
      (tester) async {
        when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
          const UserCredentials(isFirstLaunch: false),
        );
        await _buildWidget(tester);
        expect(Get.find<LoginController>().usernameController.text, '');
      },
    );
  });

  group('form login', () {
    testWidgets(
      'should disable login button when form login not validate',
      (tester) async {
        await _buildWidget(tester);
        final controller = Get.find<LoginController>();
        // password is not validate
        await tester.enterText(usernameTextField, 'duc123');
        await tester.enterText(passWordTextField, 'password');
        await tester.pump();
        expect(controller.isEnabledLoginButton, true);
        // password is empty
        await tester.enterText(usernameTextField, 'duc123');
        await tester.enterText(passWordTextField, '');
        await tester.pump();
        expect(controller.isEnabledLoginButton, false);
        // username is empty
        await tester.enterText(usernameTextField, '');
        await tester.enterText(passWordTextField, 'password');
        await tester.pump();
        expect(controller.isEnabledLoginButton, false);
        await tester.pumpAndSettle();
      },
    );
    testWidgets(
      'should enable login button when form login is validate',
      (tester) async {
        await _buildWidget(tester);
        final controller = Get.find<LoginController>();
        await _enterValidData(tester);
        expect(controller.isEnabledLoginButton, true);
        await tester.pumpAndSettle();
      },
    );
  });

  group('login', () {
    testWidgets(
      'should show error snack bar when sign in failure',
      (tester) async {
        when(() => mockAuthClient.signIn(any())).thenThrow(Exception());
        await _buildWidget(tester);
        await _enterValidData(tester);
        await tester.dragUntilVisible(
            loginButton, scrollPage, const Offset(0, 50));
        expect(Get.find<LoginController>().isEnabledLoginButton, true);
        await tester.tap(loginButton);
        await tester.pump(const Duration(seconds: 1));
        expect(errorSnackBar, findsOneWidget);
        await tester.pump(const Duration(seconds: 2));
      },
    );
    testWidgets(
      'should navigate to Home Product when business status is active',
      (tester) async {
        when(() => mockAuthClient.signIn(any())).thenAnswer(
          (_) async => AuthSignInFakeData.successResponseWith(
              accountStatus: UserStatus.New, roleId: 'id_maker'),
        );
        when(() => mockUserAccountsRepository.getUserAccountDetails())
            .thenAnswer(
          (_) async => UserAccountDetailFakeData.successResponseWithRole(
              UserRoleACL.systemAdmin1),
        );
        await _buildWidget(tester);
        await _enterValidData(tester);
        await tester.dragUntilVisible(
            loginButton, scrollPage, const Offset(0, 50));
        expect(Get.find<LoginController>().isEnabledLoginButton, true);
        await tester.tap(loginButton);
        await tester.pumpAndSettle();
        expect(Get.currentRoute, Routes.LANDING);
      },
    );

    testWidgets(
      'button login via fingerprint not showing when biometric not available',
      (tester) async {
        when(() => mockLocalAuthentication.canCheckBiometrics)
            .thenAnswer((_) async => false);
        when(() => mockLocalAuthentication.isDeviceSupported())
            .thenAnswer((_) async => false);
        when(() => mockLocalAuthentication.getAvailableBiometrics())
            .thenAnswer((_) async => [BiometricType.fingerprint]);
        when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
          const UserCredentials(
            isFirstLaunch: false,
            accessToken: '123',
            refreshToken: '123',
            isEnableBiometricLogin: true,
          ),
        );
        await _buildWidget(tester);
        Get.routing.args = true;
        final controller = Get.find<LoginController>();
        controller.onReady();
        await tester.pump();
        expect(fingerprintButton, findsNothing);
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'page not change when failed authenticate fingerprint',
      (tester) async {
        when(() => mockLocalAuthentication.canCheckBiometrics)
            .thenAnswer((_) async => true);
        when(() => mockLocalAuthentication.isDeviceSupported())
            .thenAnswer((_) async => true);
        when(() => mockLocalAuthentication.getAvailableBiometrics())
            .thenAnswer((_) async => [BiometricType.fingerprint]);
        when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
          const UserCredentials(
            isFirstLaunch: false,
            accessToken: '123',
            refreshToken: '123',
            isEnableBiometricLogin: true,
          ),
        );
        await _buildWidget(tester);
        Get.routing.args = true;
        final controller = Get.find<LoginController>();
        when(() => mockLocalAuthentication.authenticate(
            localizedReason: t.login_.authenticationDescription,
            options: any(named: 'options'))).thenAnswer(
          (_) async => false,
        );
        controller.onReady();
        await tester.pump();
        await tester.dragUntilVisible(
            fingerprintButton, scrollPage, const Offset(0, 50));
        await tester.pump();
        expect(fingerprintButton, findsOneWidget);
        await tester.tap(fingerprintButton);
        await tester.pumpAndSettle();
        expect(Get.currentRoute, '/');
      },
    );
  });

  group('navigate button', () {
    testWidgets(
      'should navigate to FORGOT_PASSWORD screen when pressed forgot password button',
      (tester) async {
        await _buildWidget(tester);
        await tester.tap(forgotPasswordButton);
        expect(Get.currentRoute, Routes.FORGOT_PASSWORD);
      },
    );
    testWidgets(
      'should navigate to SIGN_UP screen when pressed signup button',
      (tester) async {
        await _buildWidget(tester);
        await tester.dragUntilVisible(
            signUpButton, scrollPage, const Offset(0, 50));
        await tester.tap(signUpButton);
        expect(Get.currentRoute, Routes.SIGN_UP);
      },
    );
  });

  testWidgets(
    'on click login other account',
    (tester) async {
      const userCredentials = UserCredentials(
        isFirstLaunch: false,
        username: 'Duc123',
        accessToken: 'abc',
      );
      when(() => mockUserCredentialsRepository.getCredentials()).thenReturn(
        userCredentials,
      );
      when(() => mockAuthClient.signOut()).thenAnswer((_) async => true);
      when(() => mockUserCredentialsRepository.clearCredentials())
          .thenAnswer((_) async => true);
      await _buildWidget(tester);
      var controller = Get.find<LoginController>();
      await tester.dragUntilVisible(
          buttonLoginOtherAccount, scrollPage, const Offset(0, 50));
      await tester.tap(buttonLoginOtherAccount);
      await tester.pumpAndSettle();
      expect(controller.isHaveSession, false);
    },
  );
}
