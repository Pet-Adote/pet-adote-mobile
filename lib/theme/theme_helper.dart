import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();




class ThemeHelper {

  final Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };


  final Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };


  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
    );
  }

  
  LightCodeColors themeColor() => _getThemeColors();

  
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.light();
}

class LightCodeColors {
  
  Color get black => Color(0xFF1E1E1E);
  Color get white => Color(0xFFFFFFFF);
  Color get gray200 => Color(0xFFE5E7EB);
  Color get gray400 => Color(0xFF9CA3AF);
  Color get gray600 => Color(0xFF4B5563);

  
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

  
  Color get grey600 => Colors.grey.shade600;
  Color get grey500 => Colors.grey.shade500;
  Color get grey200 => Colors.grey.shade200;
  Color get grey100 => Colors.grey.shade100;

}
