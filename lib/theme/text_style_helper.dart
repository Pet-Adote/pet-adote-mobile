import 'package:flutter/material.dart';
import '../core/app_export.dart';

class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  TextStyle get display55LeckerliOne => TextStyle(
        fontSize: 55.fSize,
        fontFamily: 'Leckerli One',
        color: appTheme.whiteCustom,
      );

  TextStyle get display50RegularLeckerliOne => TextStyle(
        fontSize: 50.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Leckerli One',
        color: appTheme.colorFF4F20,
      );

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title20SemiBoldInter => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        color: appTheme.blackCustom,
      );

  TextStyle get body15MediumInter => TextStyle(
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
        color: appTheme.colorFF4F20,
      );

  TextStyle get bodyTextSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyTextInter => TextStyle(
        fontFamily: 'Inter',
      );
}
