import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/app/base/base_widget_mixin.dart';

import 'custom_outline_input_border.dart';

class TextFieldWithIconWidget extends StatelessWidget with BaseWidgetMixin {
  final String? label;
  final TextStyle? labelStyle;
  final String? hint;
  final Color? hintColor;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? rightIcon;
  final Widget leftIcon;
  final Function? onTapRightIcon;
  final EdgeInsets? contentPadding;
  final int? maxLength;
  final int minLines;
  final int? maxLines;
  final bool enabled;
  final bool obsecure;
  final bool readOnly;
  final Function? validator;
  final Function? onChangedText;
  final TextInputAction? textInputAction;
  final Key? rightIconKey;
  final Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatter;
  final AutovalidateMode? autovalidateMode;
  final Function? onFieldSubmitted;
  const TextFieldWithIconWidget({
    super.key,
    this.label,
    this.labelStyle,
    this.hint,
    this.hintColor,
    this.initialValue,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.rightIcon,
    required this.leftIcon,
    this.onTapRightIcon,
    this.contentPadding,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 1,
    this.enabled = true,
    this.obsecure = false,
    this.readOnly = false,
    this.validator,
    this.onChangedText,
    this.textInputAction,
    this.rightIconKey,
    this.backgroundColor,
    this.inputFormatter,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
      ),
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      obscureText: obsecure,
      readOnly: readOnly,
      validator: (value) => validator?.call(value),
      onChanged: (value) => onChangedText?.call(value),
      onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
      textInputAction: textInputAction,
      inputFormatters: inputFormatter,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor ?? theme.brandingGrey),
        labelText: label ?? '',
        labelStyle: labelStyle ??
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: theme.textGrey2,
            ),
        isDense: true,
        filled: true,
        fillColor: backgroundColor ?? theme.textWhite,
        contentPadding: contentPadding,
        suffixIcon: _rightIcon(),
        prefixIcon: _leftIcon(),
        enabledBorder:
            label == null ? _borderWithoutLabel() : _borderWithLabel(),
        focusedBorder:
            label == null ? _borderWithoutLabel() : _borderWithLabel(),
        errorBorder: label == null ? _borderWithoutLabel() : _borderWithLabel(),
        focusedErrorBorder:
            label == null ? _borderWithoutLabel() : _borderWithLabel(),
        border: label == null ? _borderWithoutLabel() : _borderWithLabel(),
        errorMaxLines: 10,
      ),
    );
  }

  OutlineInputBorder _borderWithoutLabel() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6.0),
      borderSide: BorderSide(
        color: theme.brandingOrange,
        width: 1,
      ),
    );
  }

  CustomOutlineInputBorder _borderWithLabel() {
    return CustomOutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: theme.brandingOrange,
        width: 1,
      ),
    );
  }

  Container _leftIcon() {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomLeft: Radius.circular(6),
        ),
        border: Border.all(
          color: theme.brandingOrange,
        ),
        gradient: LinearGradient(
          colors: [
            theme.gradientOrange2,
            theme.gradientOrange1,
            theme.brandingOrange,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.8, 1],
        ),
      ),
      child: SizedBox(
        width: 18.w,
        height: 12.h,
        child: leftIcon,
      ),
    );
  }

  Widget? _rightIcon() {
    if (rightIcon != null) {
      return InkWell(
        key: rightIconKey,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: rightIcon!,
        ),
        onTap: () => onTapRightIcon?.call(),
      );
    }
    return null;
  }
}
