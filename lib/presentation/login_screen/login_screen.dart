import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Handle login functionality
      print('Login attempt: ${_emailController.text}');
    }
  }

  void _handleForgotPassword() {
    // Handle forgot password functionality
    print('Forgot password clicked');
  }

  void _handleRegister() {
    Navigator.of(context).pushNamed(AppRoutes.registrationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appTheme.colorFF9FE5,
        body: Stack(children: [
          // Background Image with Paw Prints
          Positioned(

              top: 11.h,
              left: 0,
              child: Opacity(
                  opacity: 0.3,
                  child: CustomImageView(
                      imagePath: ImageConstant.imgImage5,
                      height: 885.h,
                      width: 428.h,
                      fit: BoxFit.cover))),

          // Main Content
          Positioned(
              top: 118.h,
              left: 30.h,
              child: Container(
                  height: 669.h,
                  width: 372.h,
                  child: Column(children: [
                    // PetAdote Logo/Title
                    Container(
                        height: 84.h,
                        width: 222.h,
                        margin: EdgeInsets.only(bottom: 166.h),
                        child: Center(
                            child: Text('PetAdote',
                                style: TextStyleHelper
                                    .instance.display55LeckerliOne
                                    .copyWith(height: 1.35)))),

                    // Login Form
                    Column(children: [
                      // Email Input
                      CustomTextField(
                          placeholder: 'E-mail',
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          height: 45.h,
                          backgroundColor: appTheme.whiteCustom,
                          borderColor: appTheme.transparentCustom,
                          focusBorderColor: appTheme.whiteCustom.withAlpha(128),
                          fontSize: 20.fSize,
                          onSubmitted: (_) =>
                              _passwordFocusNode.requestFocus()),

                      SizedBox(height: 32.h),

                      // Password Input
                      Container(
                          height: 45.h,
                          width: 372.h,
                          child: Stack(children: [
                            CustomTextField(
                                placeholder: 'Senha',
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                keyboardType: _isPasswordVisible
                                    ? TextInputType.text
                                    : TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                height: 45.h,
                                backgroundColor: appTheme.whiteCustom,
                                borderColor: appTheme.transparentCustom,
                                focusBorderColor:
                                    appTheme.whiteCustom.withAlpha(128),
                                fontSize: 20.fSize,
                                contentPadding: EdgeInsets.only(
                                    left: 16.h,
                                    right: 48.h,
                                    top: 12.h,
                                    bottom: 12.h),
                                onSubmitted: (_) => _handleLogin()),

                            // Password Toggle Button
                            Positioned(
                                right: 12.h,
                                top: 0,
                                bottom: 0,
                                child: GestureDetector(
                                    onTap: _togglePasswordVisibility,
                                    child: Container(
                                        width: 24.h,
                                        height: 24.h,
                                        child: Center(
                                            child: CustomImageView(
                                                imagePath: ImageConstant.img2,
                                                width: 24.h,
                                                height: 24.h,
                                                color: appTheme.grey600))))),
                          ])),

                      SizedBox(height: 43.h),

                      // Login Button
                      CustomButton(
                          text: 'Entrar',
                          onPressed: _handleLogin,
                          backgroundColor: appTheme.colorFFF1F1,
                          textColor: appTheme.colorFF120F,
                          height: 39.h,
                          width: 150.h,
                          fontSize: 20.fSize,
                          fontWeight: FontWeight.normal,
                          borderRadius: 0,
                          elevation: 4.h,
                          shadowColor: appTheme.blackCustom),

                      SizedBox(height: 14.h),

                      // Forgot Password Link
                      GestureDetector(
                          onTap: _handleForgotPassword,
                          child: Text('Esqueci a senha',
                              style: TextStyleHelper.instance.body15MediumInter
                                  .copyWith(
                                      height: 1.27,
                                      decoration: TextDecoration.underline))),

                      SizedBox(height: 138.h),

                      // Register Button
                      CustomButton(
                          text: 'CADASTRE-SE',
                          onPressed: _handleRegister,
                          backgroundColor: appTheme.colorFFF1F1,
                          textColor: appTheme.colorFF120F,
                          height: 42.h,
                          width: 250.h,
                          fontSize: 20.fSize,
                          fontWeight: FontWeight.normal,
                          borderRadius: 0,
                          elevation: 4.h,
                          shadowColor: appTheme.blackCustom),
                    ]),
                  ]))),
        ]));
  }
}
