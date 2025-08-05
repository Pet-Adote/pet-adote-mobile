import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

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

  // Title Styles
  // Medium text styles for titles and subtitles

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

  // Body Styles
  // Standard text styles for body content

  TextStyle get body15MediumInter => TextStyle(
        fontSize: 15.fSize,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
        color: appTheme.colorFF4F20,
      );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get bodyTextSemiBold => TextStyle(
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyTextInter => TextStyle(

        fontFamily: 'Inter',
      );
}
