import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:gg_flutter/app/core/utils/response_message.dart';

import '../../../i18n/strings.g.dart';
import '../values/app_theme.dart';

class SnackbarHelper {
  static error({
    Key? key,
    String? title,
    String? desc,
    Widget? titleWidget,
    Widget? descWidget,
    // DioError? dioError,
    BuildContext? context,
    SnackPosition? snackPosition,
  }) {
    var ctx = context ?? Get.context!;
    String? snackbarTitle;
    String? snackbarDesc;
    // if (dioError != null) {
    //   try {
    //     dynamic errorData;
    //     try {
    //       errorData = jsonDecode(dioError.response!.data);
    //     } catch (_) {
    //       errorData = dioError.response!.data;
    //     }
    //
    //     snackbarTitle = errorData != null
    //         ? (errorData['message'] != null
    //             ? ResponseMessage.getResponseMessageTitleFromResCode(
    //                 errorData['message']['code'],
    //               )
    //             : t.common_.errorSnackbar.title)
    //         : t.common_.errorSnackbar.title;
    //
    //     snackbarDesc = errorData != null
    //         ? (errorData['message'] != null
    //             ? ResponseMessage.getResponseMessageDescFromResCode(
    //                 errorData['message']['code'],
    //               )
    //             : t.common_.errorSnackbar.connectionProblem)
    //         : t.common_.errorSnackbar.connectionProblem;
    //   } catch (e) {
    //     snackbarDesc = t.common_.errorSnackbar.connectionProblem;
    //   }
    // }
    if (snackbarDesc == null || snackbarDesc.isEmpty) {
      snackbarDesc = desc ?? t.common_.errorSnackbar.content;
    }
    Get.snackbar(
      title ?? snackbarTitle ?? t.common_.errorSnackbar.title,
      snackbarDesc,
      borderWidth: 1,
      borderColor: AppTheme.of(ctx).errorRed,
      icon: Icon(
        Icons.warning_amber_outlined,
        color: AppTheme.of(ctx).errorRed,
        key: key,
      ),
      colorText: AppTheme.of(ctx).errorRed,
      backgroundColor: AppTheme.of(ctx).errorBgRed,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 5,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
      snackPosition: snackPosition ?? SnackPosition.TOP,
      titleText: titleWidget,
      messageText: descWidget,
      margin: const EdgeInsets.all(10),
    );
  }

  static warning({
    Key? key,
    required String title,
    required String desc,
    Widget? titleWidget,
    Widget? descWidget,
    BuildContext? context,
    SnackPosition? snackPosition,
  }) {
    var ctx = context ?? Get.context!;
    Get.snackbar(
      title,
      desc,
      icon: Icon(
        Icons.warning,
        color: Colors.amber,
        key: key,
      ),
      colorText: AppTheme.of(ctx).textBlack,
      backgroundColor: AppTheme.of(ctx).background,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 5,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
      snackPosition: snackPosition ?? SnackPosition.TOP,
      titleText: titleWidget,
      messageText: descWidget,
      margin: const EdgeInsets.all(10),
    );
  }

  static success({
    Key? key,
    required String title,
    required String desc,
    Widget? titleWidget,
    Widget? descWidget,
    BuildContext? context,
    SnackPosition? snackPosition,
  }) {
    var ctx = context ?? Get.context!;
    Get.snackbar(
      title,
      desc,
      icon: Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        key: key,
      ),
      colorText: AppTheme.of(ctx).textBlack,
      backgroundColor: AppTheme.of(ctx).background,
      boxShadows: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 5,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
      snackPosition: snackPosition ?? SnackPosition.TOP,
      titleText: titleWidget,
      messageText: descWidget,
      margin: const EdgeInsets.all(10),
    );
  }

  static common({
    Key? key,
    required String title,
    required String desc,
    Widget? icon,
    Duration? duration,
    SnackPosition? snackPosition,
    Color? colorText,
    Color? backgroundColor,
    List<BoxShadow>? boxShadows,
    Widget? titleWidget,
    Widget? descWidget,
    BuildContext? context,
  }) {
    var ctx = Get.context!;
    Get.snackbar(
      title,
      desc,
      icon: icon ??
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            key: key,
          ),
      colorText: colorText ?? AppTheme.of(ctx).textBlack,
      backgroundColor: backgroundColor ?? AppTheme.of(ctx).background,
      boxShadows: boxShadows ??
          [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
      snackPosition: snackPosition ?? SnackPosition.TOP,
      duration: duration,
      titleText: titleWidget,
      messageText: descWidget,
      margin: const EdgeInsets.all(10),
    );
  }
}
