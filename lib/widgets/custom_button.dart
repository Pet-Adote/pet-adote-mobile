import 'package:flutter/material.dart';

import '../core/app_export.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.borderRadius,
    this.isLoading = false,
    this.isEnabled = true,
    this.leadingIcon,
    this.trailingIcon,
    this.shadowColor,
    this.elevation,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final bool isLoading;
  final bool isEnabled;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Color? shadowColor;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? appTheme.colorFF9FE5;
    final effectiveTextColor = textColor ?? appTheme.colorFF1210;
    final effectiveHeight = height ?? 50.h;
    final effectiveWidth = width ?? double.infinity;
    final effectiveFontSize = fontSize ?? 20.fSize;
    final effectiveFontWeight = fontWeight ?? FontWeight.w600;
    final effectiveBorderRadius = borderRadius ?? 8.h;
    final effectiveShadowColor =
        shadowColor ?? appTheme.blackCustom.withAlpha(64);
    final effectiveElevation = elevation ?? 4.h;

    return SizedBox(
      height: effectiveHeight,
      width: effectiveWidth,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveTextColor,
          elevation: effectiveElevation,
          shadowColor: effectiveShadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.h),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.h,
                  valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    SizedBox(width: 8.h),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyleHelper.instance.bodyTextInter.copyWith(
                        fontSize: effectiveFontSize,
                        fontWeight: effectiveFontWeight,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(width: 8.h),
                    trailingIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
