import 'package:flutter/material.dart';
import 'package:flutter_template/themes/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bool isFill;
  final bool isCollapse;
  final TextStyle? textStyle;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;
  final double borderRadiusSize;
  final double? width;
  final BoxDecoration? containerStyle;
  final EdgeInsets? pd;
  final EdgeInsets? mg;
  final Function onTap;
  final bool enabled;
  final bool isLoading;
  final Color? buttonColor;
  final Widget? tail;
  final Widget? prefix;

  const ButtonWidget({
    Key? key,
    this.text = '',
    this.isFill = true,
    this.isCollapse = false,
    this.textStyle,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w700,
    this.maxLines = 1,
    this.borderRadiusSize = 15,
    this.width,
    this.containerStyle,
    this.pd,
    this.mg,
    this.enabled = true,
    this.isLoading = false,
    this.buttonColor,
    this.tail,
    this.prefix,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCollapse) {
      return Expanded(child: button(context));
    }
    return button(context);
  }

  Widget button(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: mg ?? EdgeInsets.zero,
      decoration: enabled
          ? containerStyle ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadiusSize),
                border: isFill
                    ? null
                    : Border.all(
                        width: 1,
                        color: AppTheme.of(context).brandingGreen,
                      ),
              )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusSize),
              color: AppTheme.of(context).lightGrey1,
            ),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadiusSize),
        color: isFill
            ? (enabled
                ? buttonColor ?? AppTheme.of(context).brandingGreen
                : AppTheme.of(context).lightGrey1)
            : AppTheme.of(context).background,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          highlightColor: Colors.transparent,
          onTap: (enabled && !isLoading) ? () => onTap() : null,
          child: Container(
            padding:
                pd ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: isLoading
                ? const Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (prefix != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: prefix,
                        ),
                      Flexible(
                        child: Text(
                          text,
                          maxLines: maxLines,
                          style: textStyle ??
                              TextStyle(
                                color: isFill
                                    ? (enabled
                                        ? Colors.white
                                        : AppTheme.of(context).lightGrey2)
                                    : (enabled
                                        ? AppTheme.of(context).brandingGreen
                                        : AppTheme.of(context).lightGrey2),
                                fontSize: fontSize,
                                fontWeight: fontWeight,
                              ),
                        ),
                      ),
                      if (tail != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: tail,
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
