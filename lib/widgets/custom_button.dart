import 'package:flutter/material.dart';

import '../core/app_export.dart';

/**
 * CustomButton - A reusable button component with customizable styling
 * 
 * Features:
 * - Configurable text, colors, and dimensions
 * - Built-in loading state support
 * - Responsive design using SizeUtils
 * - Shadow and rounded corner styling
 * - Optional leading and trailing icons
 * 
 * @param text - Button text content
 * @param onPressed - Callback function when button is pressed
 * @param backgroundColor - Button background color
 * @param textColor - Button text color
 * @param height - Button height
 * @param width - Button width
 * @param fontSize - Text font size
 * @param fontWeight - Text font weight
 * @param borderRadius - Button border radius
 * @param isLoading - Loading state indicator
 * @param isEnabled - Button enabled/disabled state
 * @param leadingIcon - Optional leading icon
 * @param trailingIcon - Optional trailing icon
 * @param shadowColor - Button shadow color
 * @param elevation - Button elevation
 */
class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
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
  }) : super(key: key);

  /// Button text content
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Button background color
  final Color? backgroundColor;

  /// Button text color
  final Color? textColor;

  /// Button height
  final double? height;

  /// Button width
  final double? width;

  /// Text font size
  final double? fontSize;

  /// Text font weight
  final FontWeight? fontWeight;

  /// Button border radius
  final double? borderRadius;

  /// Loading state indicator
  final bool isLoading;

  /// Button enabled/disabled state
  final bool isEnabled;

  /// Optional leading icon
  final Widget? leadingIcon;

  /// Optional trailing icon
  final Widget? trailingIcon;

  /// Button shadow color
  final Color? shadowColor;

  /// Button elevation
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
                      style: TextStyleHelper.instance.bodyTextInter,
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
