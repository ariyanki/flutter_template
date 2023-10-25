import 'dart:async';
import 'dart:io' show Platform;

// import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../i18n/strings.g.dart';
import '../enum/page_state.dart';
import '../utils/snackbar.dart';
import '../values/app_theme.dart';
import '../values/app_theme_data.dart';

abstract class BaseController extends GetxController {
  AppThemeData get theme => AppTheme.of(Get.context!);

  Logger get logger => Get.find<Logger>();

  //Controls module state
  PageState _state = PageState.DEFAULT;

  PageState get pageState => _state;

  updatePageState(PageState state) {
    _state = state;
    update();
  }

  resetPageState() => updatePageState(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  Future<T?> callDataService<T>(
    Future<T> Function() future, {
    bool loading = true,
    bool showDioErrorSnackbar = true,
    bool showOtherErrorSnackbar = true,
    bool waitOnSuccess = false,
    Function(T response)? onSuccess,
    // Function(DioError e)? onDioError,
    Function(dynamic e)? onError,
    Function(dynamic e)? onAnyError,
    Function()? onDone,
  }) async {
    Object? err;
    try {
      if (loading) showLoading();

      final T response = await future();

      if (waitOnSuccess) {
        await onSuccess?.call(response);
      } else {
        onSuccess?.call(response);
      }

      return response;
    // } on DioError catch (e) {
    //   err = e;
    //   if (onDioError != null) {
    //     onDioError(e);
    //   } else if (showDioErrorSnackbar) {
    //     switch (e.type) {
    //       case DioErrorType.other:
    //         if (e.message.contains('SocketException')) {
    //           SnackbarHelper.error(
    //             key: const ValueKey('data_service_dio_error_snack_bar'),
    //             desc: t.common_.errorSnackbar.noInternetConnection,
    //           );
    //         } else {
    //           SnackbarHelper.error(
    //             key: const ValueKey('data_service_dio_error_snack_bar'),
    //             dioError: e,
    //           );
    //         }
    //         break;
    //       default:
    //         SnackbarHelper.error(
    //           key: const ValueKey('data_service_dio_error_snack_bar'),
    //           dioError: e,
    //         );
    //         break;
    //     }
    //   }
    } catch (e) {
      err = e;
      if (onError != null) {
        onError(e);
      } else if (showOtherErrorSnackbar) {
        SnackbarHelper.error(
          key: const ValueKey('data_service_error_snack_bar'),
        );
      }
    } finally {
      if (err != null) onAnyError?.call(err);
      if (loading) hideLoading();
      onDone?.call();
    }
    return null;
  }
}
