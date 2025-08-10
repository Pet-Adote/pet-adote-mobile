import 'package:flutter/material.dart';

import '../core/app_export.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.isRequired,
    this.isEnabled,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.backgroundColor,
    this.borderColor,
    this.focusBorderColor,
    this.textColor,
    this.placeholderColor,
    this.fontSize,
    this.height,
    this.borderRadius,
    this.contentPadding,
  });

  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? isRequired;
  final bool? isEnabled;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? textColor;
  final Color? placeholderColor;
  final double? fontSize;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 45.h,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.done,
        enabled: isEnabled ?? true,
        maxLength: maxLength,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        validator: validator,
        style: TextStyleHelper.instance.bodyTextSemiBold
            .copyWith(color: textColor ?? appTheme.blackCustom, height: 1.25),
        decoration: InputDecoration(
          hintText: placeholder ?? '',
          hintStyle: TextStyleHelper.instance.bodyTextSemiBold
              .copyWith(color: placeholderColor ?? appTheme.grey500, height: 1.25),
          filled: true,
          fillColor: backgroundColor ?? appTheme.whiteCustom,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 12.h,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
            borderSide: BorderSide(
              color: borderColor ?? Color(0xFFE5E7EB),
              width: 1.h,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
            borderSide: BorderSide(
              color: borderColor ?? Color(0xFFE5E7EB),
              width: 1.h,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
            borderSide: BorderSide(
              color: focusBorderColor ?? Color(0xFF9FE5AD),
              width: 2.h,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
            borderSide: BorderSide(
              color: appTheme.redCustom,
              width: 1.h,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 6.h),
            borderSide: BorderSide(
              color: appTheme.redCustom,
              width: 2.h,
            ),
          ),
          counterText: '',
        ),
      ),
    );
  }
}
