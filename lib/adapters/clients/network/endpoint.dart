import 'package:flutter_template/flavors.dart';

class Endpoints {
  late UserAccountsEndpoint userAccounts;
  late AuthEndpoint auth;

  Endpoints([Flavor appFlavor = Flavor.DEV]) {
    userAccounts = UserAccountsEndpoint();
    auth = AuthEndpoint();
    switch (appFlavor) {
      // ? Using Endpoint() with no params for default API or Endpoint([with specific params]) for specific API in each of flavor environments.
      case Flavor.PROD:
        break;
      case Flavor.DEV:
        break;
      case Flavor.UAT:
        break;
    }
  }
}

class UserAccountsEndpoint {
  final String activation;
  final String forgotPassword;
  final String resendActivation;
  final String signUp;
  final String details;
  final String resetPassword;
  final String balance;
  final String checkTokenActivation;
  final String resendEmailActivation;
  final String whitelist;

  String changePassword(String userId) =>
      'user-accounts/$userId/change-password';

  UserAccountsEndpoint({
    this.activation = 'user-accounts/activation',
    this.forgotPassword = 'user-accounts/forgot-password',
    this.resendActivation = 'user-accounts/resend-activation',
    this.signUp = 'user-accounts/signup',
    this.details = 'user-accounts/details',
    this.resetPassword = 'user-accounts/reset-password',
    this.balance = 'user-accounts/balance',
    this.checkTokenActivation = 'user-accounts/verify-activation-token',
    this.resendEmailActivation = 'user-accounts/resend-activation-email',
    this.whitelist = 'user-accounts/whitelist',
  });
}

class AuthEndpoint {
  final String signin;
  final String requestOTP;
  final String refresh;
  final String signOut;

  AuthEndpoint({
    this.signin = 'auth/signin',
    this.requestOTP = 'auth/request-identity-otp',
    this.refresh = 'auth/refresh',
    this.signOut = 'auth/signout',
  });
}

