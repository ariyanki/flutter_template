import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_template/adapters/clients/network/dio_configure.dart';
import 'package:flutter_template/adapters/clients/network/endpoint.dart';
import 'package:flutter_template/ports/clients/dto/auth/refresh/request_auth_refresh.dart';
import 'package:flutter_template/ports/clients/dto/auth/refresh/response_auth_refresh.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/request_auth_sign_in.dart';
import 'package:flutter_template/ports/clients/dto/auth/sign_in/response_auth_sign_in.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:get/get.dart';

class AuthClientImpl implements IAuthClient {
  final dioConfigure = Get.find<DioConfigure>();
  final endpoints = Get.find<Endpoints>();

  final _userCredentialsDataSource = Get.find<IUserCredentialsRepository>();

  @override
  Future<ResponseAuthSignIn> signIn(RequestAuthSignIn data) async {
    var response = await dioConfigure.dioIAM.post(
      endpoints.auth.signin,
      data: jsonEncode(data.toJson()),
    );
    final res = ResponseAuthSignIn.fromJson(response.data);
    await _userCredentialsDataSource.saveToken(
      refreshToken: res.data.refreshToken,
      accessToken: res.data.token,
    );
    return res;
  }

  @override
  Future<void> signOut() async {
    try {
      await dioConfigure.dioIAM.get(
        endpoints.auth.signOut,
      );
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
    await _userCredentialsDataSource.clearCredentials();
  }

  @override
  Future<void> requestOTP() async {
    await dioConfigure.dioIAM.post(
      endpoints.auth.requestOTP,
    );
  }

  @override
  Future<ResponseAuthRefresh> refreshToken(RequestAuthRefresh data) async {
    var response = await dioConfigure.dioIAM.post(
      endpoints.auth.refresh,
      data: jsonEncode(data.toJson()),
    );
    final res =  ResponseAuthRefresh.fromJson(response.data);
    await _userCredentialsDataSource.saveToken(
      refreshToken: res.data.refresh,
      accessToken: res.data.token,
    );
    return res;
  }
}
