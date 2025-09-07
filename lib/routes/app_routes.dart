import 'package:flutter/material.dart';
import '../presentation/registration_screen/registration_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/forgot_password_screen/forgot_password_screen.dart';

import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/home_screen/home_screen.dart';
import '../presentation/categories_screen/categories_screen.dart';
import '../presentation/profile_screen/profile_screen.dart';
import '../presentation/favorites_screen/favorites_screen.dart';
import '../presentation/about_us_screen/about_us_screen.dart';
import '../presentation/faq_screen/faq_screen.dart';
import '../presentation/care_screen/care_screen.dart';
import '../presentation/add_pet_screen/add_pet_screen.dart';
import '../presentation/edit_pet_screen/edit_pet_screen.dart';
import '../presentation/pet_profile_screen/pet_profile_screen.dart';
import '../presentation/help_screen/help_screen.dart';
import '../presentation/denounce_screen/denounce_screen.dart';

class AppRoutes {
  static const String registrationScreen = '/registration_screen';
  static const String loginScreen = '/login_screen';
  static const String forgotPasswordScreen = '/forgot_password_screen';

  static const String homeScreen = '/home_screen';
  static const String dogsScreen = '/dogs_screen';
  static const String catsScreen = '/cats_screen';
  static const String profileScreen = '/profile_screen';
  static const String favoritesScreen = '/favorites_screen';
  static const String aboutUsScreen = '/about_us_screen';
  static const String faqScreen = '/faq_screen';
  static const String careScreen = '/care_screen';
  static const String addPetScreen = '/add_pet_screen';
  static const String editPetScreen = '/edit_pet_screen';
  static const String petProfileScreen = '/pet_profile_screen';
  static const String helpScreen = '/help_screen';
  static const String denounceScreen = '/denounce_screen';

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
        favoritesScreen: (context) => FavoritesScreen(),
        aboutUsScreen: (context) => AboutUsScreen(),
        faqScreen: (context) => FaqScreen(),
        careScreen: (context) => CareScreen(),
        addPetScreen: (context) => AddPetScreen(),
        editPetScreen: (context) => EditPetScreen(),
        petProfileScreen: (context) => PetProfileScreen(),
        helpScreen: (context) => HelpScreen(),
        denounceScreen: (context) => DenounceScreen(),
        appNavigationScreen: (context) => AppNavigationScreen(),
        initialRoute: (context) => LoginScreen()
      };
}