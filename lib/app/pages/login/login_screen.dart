import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/app/app_routes.dart';
import 'package:flutter_template/app/base/base_view.dart';
import 'package:flutter_template/app/widgets/button/button_widget.dart';
import 'package:flutter_template/app/widgets/container/background_body_widget.dart';
import 'package:flutter_template/app/widgets/text/text_field_with_icon_widget.dart';
import 'package:flutter_template/themes/app_theme.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/validator.dart';
import 'package:get/get.dart';
import 'package:flutter_template/ports/enum/page_state.dart';
import 'package:flutter_template/gen/assets.gen.dart';
import 'package:flutter_template/i18n/strings.g.dart';

import 'login_controller.dart';

class LoginScreen extends BaseView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    SizeConfig().init(context);
    return BackgroundBodyWidget(
      child: SingleChildScrollView(
        key: const ValueKey("scrollview_login_page"),
        padding: const EdgeInsets.all(30),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: FocusScope.of(context).unfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 56),
              Center(
                child: Assets.images.logo.image(),
              ),
              const SizedBox(height: 56),
              controller.isHaveSession
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    controller.fullName,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              )
                  : TextFieldWithIconWidget(
                key: const ValueKey('login_username_text_field'),
                leftIcon: Assets.icons.person.svg(
                  colorFilter: ColorFilter.mode(
                    theme.textWhite,
                    BlendMode.srcIn,
                  ),
                ),
                label: t.login_.username,
                controller: controller.usernameController,
                keyboardType: TextInputType.text,
                onChangedText: controller.onChangedText,
                validator: validateUsername,
              ),
              const SizedBox(height: 30),
              TextFieldWithIconWidget(
                key: const ValueKey('login_password_text_field'),
                leftIcon: Assets.icons.padlock.svg(
                  colorFilter: ColorFilter.mode(
                    theme.textWhite,
                    BlendMode.srcIn,
                  ),
                ),
                rightIcon: controller.isShownPassword
                    ? Assets.icons.passwordShow.svg(
                  colorFilter: ColorFilter.mode(
                    theme.grey,
                    BlendMode.srcIn,
                  ),
                  key: const ValueKey('password_visibility_off_icon'),
                )
                    : Assets.icons.passwordHide.svg(
                  colorFilter: ColorFilter.mode(
                    theme.grey,
                    BlendMode.srcIn,
                  ),
                  key: const ValueKey('password_visibility_on_icon'),
                ),
                rightIconKey: const ValueKey(
                  'toggle_obscure_password_button',
                ),
                onTapRightIcon: controller.onTapShowPassword,
                label: t.login_.password,
                controller: controller.passwordController,
                keyboardType: TextInputType.text,
                obsecure: !controller.isShownPassword,
                onChangedText: controller.onChangedText,
                validator: validatePassword,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    key: const ValueKey('forgot_password_button'),
                    style: TextButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                    onPressed: controller.onNavigateForgotPassword,
                    child: Text(
                      t.login_.forgotPassword,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: theme.brandingGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 108),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 4,
                    child: ButtonWidget(
                      key: const ValueKey('login_button'),
                      text: t.login_.login,
                      enabled: controller.isEnabledLoginButton,
                      onTap: controller.login,
                    ),
                  ),
                  if (controller.isCanUseBiometric && controller.isHaveSession)
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        key: const ValueKey('login_by_fingerprint'),
                        onTap: controller.onTapButtonFinger,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: AppTheme.of(context).brandingYellow,
                          ),
                          height: 44,
                          width: 44,
                          padding: const EdgeInsets.all(8),
                          child: Assets.icons.fingerprint.svg(
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: theme.textGrey2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Text(
                      'atau',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.textGrey2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: theme.textGrey2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  if (controller.isHaveSession)
                    Expanded(
                      child: ButtonWidget(
                        key: const ValueKey('login_other_account_button'),
                        text: 'Login Akun Lain',
                        isFill: false,
                        fontSize: 14.sp,
                        pd: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 12),
                        onTap: () {
                          controller.signOut();
                        },
                      ),
                    ),
                  if (controller.isHaveSession)
                    const SizedBox(
                      width: 20,
                    ),
                  Expanded(
                    child: ButtonWidget(
                      key: const ValueKey('signup_button'),
                      text: t.login_.register,
                      isFill: false,
                      fontSize: 14.sp,
                      pd: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 12),
                      onTap: () {
                        if (controller.pageState != PageState.LOADING) {
                          Get.toNamed(Routes.SIGN_UP);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateUsername(value) {
    final validatorResult = ValidatorHelper.validateCommon(value);
    if (validatorResult == ValidatorResult.empty) {
      return t.login_.usernameIsRequired;
    }
    return null;
  }

  validatePassword(value) {
    final validatorResult = ValidatorHelper.validateCommon(value);
    if (validatorResult == ValidatorResult.empty) {
      return t.login_.passwordIsRequired;
    }
    return null;
  }
}
