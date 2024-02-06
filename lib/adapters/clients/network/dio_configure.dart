import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/material.dart';
import 'package:flutter_template/adapters/clients/network/endpoint.dart';
import 'package:flutter_template/app/app_routes.dart';
import 'package:flutter_template/flavors.dart';
import 'package:flutter_template/ports/clients/dto/auth/refresh/request_auth_refresh.dart';
import 'package:flutter_template/ports/clients/i_auth_client.dart';
import 'package:flutter_template/ports/enum/service_type.dart';
import 'package:flutter_template/ports/repository/i_user_credential_repository.dart';
import 'package:flutter_template/utils/snackbar.dart';
import 'package:flutter_template/utils/time.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfigure {
  static final IUserCredentialsRepository _userCredentialsRepository =
      Get.find();
  static final IAuthClient _authClient = Get.find();
  static final endpoints = Get.find<Endpoints>();
  static Future<void>? refreshTokenRequest;

  static DateTime? keepOtpTime;

  // contact with real API
  Dio dioIAM = createDio(ServiceType.IAM);

  // final tokenDio = Dio(BaseOptions(baseUrl: FlavorConfigs.baseURL));

  DioConfigure._internal();

  static final _singleton = DioConfigure._internal();

  factory DioConfigure() => _singleton;

  static Dio createDio(
      [ServiceType serviceType = ServiceType.IAM]) {
    var baseURL = '';
    switch (serviceType) {
      case ServiceType.IAM:
        baseURL = FlavorConfigs.baseURLIAM;
        break;
    }
    var dio = Dio(
      BaseOptions(
        baseUrl: baseURL,
        receiveTimeout: 30000,
        connectTimeout: 5000,
        followRedirects: false,
        receiveDataWhenStatusError: true,
        headers: <String, String>{
          'Authorization':
              'Bearer ${_userCredentialsRepository.getCredentials().accessToken}',
          'Content-Type': 'application/json'
        },
      ),
    );

    dio.interceptors.addAll({
      PrettyDioLogger(
        requestHeader: false,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
      ),
    });

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final credential = _userCredentialsRepository.getCredentials();
          final accessToken = credential.accessToken;
          options.headers['Authorization'] = 'Bearer $accessToken';
          handler.next(options);
        },
        onError: (error, handler) async {
          // only call refresh token when
          // - statusCode is 401
          // - response data is empty
          // - request path not contain refresh
          if (error.response?.statusCode == 401 &&
              !error.requestOptions.path.contains(endpoints.auth.refresh)) {
            try {
              // prevent duplicate call refreshToken
              refreshTokenRequest = refreshTokenRequest ?? refreshToken();
              await refreshTokenRequest;
              refreshTokenRequest = null;
              // retry call api
              final res = await _retry(error.requestOptions, serviceType);
              handler.resolve(res);
            } catch (e) {
              _userCredentialsRepository.clearCredentials();
              Get.offNamedUntil(
                Routes.LOGIN,
                ModalRoute.withName(Routes.LOGIN),
              );
            }
            refreshTokenRequest = null;
            return;
          }
          handler.next(error);
        },
      ),
    );

    return dio;
  }

  static Future<void> refreshToken() async {
    final credential = _userCredentialsRepository.getCredentials();
    if (credential.accessToken == null || credential.refreshToken == null) {
      throw Exception('empty token');
    }
    try {
      await _authClient.refreshToken(
        RequestAuthRefresh(
          accessToken: credential.accessToken!,
          refreshToken: credential.refreshToken!,
        ),
      );
    } on DioError catch (e) {
      SnackbarHelper.error(dioError: e);
      throw Exception('cant\'t get new token');
    }
  }

  static Future<dio_lib.Response> _retry(
    RequestOptions options,
    ServiceType serviceType,
  ) async {
    final dio = Get.find<DioConfigure>().dioIAM;
    // = serviceType == ServiceType.IAM
    //     ? Get.find<DioConfigure>().dioIAM
    //     : serviceType == ServiceType.VCC
    //         ? Get.find<DioConfigure>().dioVcc
    //         : Get.find<DioConfigure>().dioPrepaid;
    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      cancelToken: options.cancelToken,
      options: Options(
        method: options.method,
        headers: options.headers,
      ),
      onReceiveProgress: options.onReceiveProgress,
      onSendProgress: options.onSendProgress,
    );
  }

  void addOtp(String otp, ServiceType serviceType) {
    removeOtp(serviceType); // clear old data
    _addHeaderEntries(
      {
        'X-GG-OTP': otp,
      },
      serviceType,
    );
  }

  void removeOtp(ServiceType serviceType) {
    keepOtpTime = null; // set null for reset keep otp on feature show cvv
    _removeHeaderEntry(
      'X-GG-OTP',
      serviceType,
    );
  }

  void updateKeepOtpTime(DateTime time) {
    keepOtpTime = time;
  }

  bool isOtpExpired() {
    if (keepOtpTime != null) {
      return TimeHelper.isAfterMinutes(keepOtpTime!, 5);
    }
    return true;
  }

  void _addHeaderEntries(Map<String, String> entries, ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.IAM:
        dioIAM.options.headers.addEntries(entries.entries);
        break;
    }
  }

  void _removeHeaderEntry(String key, ServiceType serviceType) {
    switch (serviceType) {
      case ServiceType.IAM:
        dioIAM.options.headers.remove(key);
        break;
    }
  }
}
