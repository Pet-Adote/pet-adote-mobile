import 'package:flutter/material.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_screen/home_screen.dart';

class AppRoutes {
  static const String registrationScreen = '/registration_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String homeScreen = '/home_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        registrationScreen: (context) => RegistrationScreen(),
        loginScreen: (context) => LoginScreen(),
        forgotPasswordScreen: (context) => ForgotPasswordScreen(),
        homeScreen: (context) => HomeScreen(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => LoginScreen()
      };
}