import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  // App Colors
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray200 => Color(0xFFE5E7EB);
  Color get gray400 => Color(0xFF9CA3AF);
  Color get gray600 => Color(0xFF4B5563);

  // Additional Colors
  Color get whiteCustom => Colors.white;
  Color get transparentCustom => Colors.transparent;
  Color get greyCustom => Colors.grey;
  Color get blackCustom => Colors.black;
  Color get redCustom => Colors.red;
  Color get greenCustom => Colors.green;
  Color get colorFF9FE5 => Color(0xFF9FE5AD);
  Color get colorFFF1F1 => Color(0xFFF1F1F1);
  Color get colorFF120F => Color(0xFF120F0F);
  Color get colorFF4F20 => Color(0xFF4F200D);
  Color get colorFFE5E7 => Color(0xFFE5E7EB);
  Color get colorFF1210 => Color(0xFF121010);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey600 => Colors.grey.shade600;
  Color get grey500 => Colors.grey.shade500;
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;

}
