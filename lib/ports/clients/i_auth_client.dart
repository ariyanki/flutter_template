import 'package:flutter_template/ports/clients/dto/auth/refresh/request_auth_refresh.dart';
import 'package:flutter_template/ports/clients/dto/auth/refresh/response_auth_refresh.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/request_auth_sign_in.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/response_auth_sign_in.dart';

abstract class IAuthClient {
  Future<ResponseAuthSignIn> signIn(RequestAuthSignIn data);

  Future<void> signOut();

  Future<void> requestOTP();

  Future<ResponseAuthRefresh> refreshToken(RequestAuthRefresh data);
}

