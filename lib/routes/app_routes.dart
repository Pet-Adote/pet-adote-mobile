import 'package:flutter/material.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/categories_screen/categories_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';

class AppRoutes {
  static const String registrationScreen = '/registration_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String homeScreen = '/home_screen';
  static const String dogsScreen = '/dogs_screen';
  static const String catsScreen = '/cats_screen';
  static const String profileScreen = '/profile_screen';

  static const String appNavigationScreen = '/app_navigation_screen';
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
        registrationScreen: (context) => RegistrationScreen(),
        loginScreen: (context) => LoginScreen(),
        forgotPasswordScreen: (context) => ForgotPasswordScreen(),
        homeScreen: (context) => HomeScreen(),
        dogsScreen: (context) => CategoriesScreen(categoryTitle: 'Cachorros', categoryType: 'dogs'),
        catsScreen: (context) => CategoriesScreen(categoryTitle: 'Gatos', categoryType: 'cats'),
        profileScreen: (context) => ProfileScreen(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => LoginScreen()
      };
}