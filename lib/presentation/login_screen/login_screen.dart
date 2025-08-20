import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
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
      debugPrint('Login attempt: ${_emailController.text}');
      Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
    }
  }

  void _handleForgotPassword() {
    Navigator.of(context).pushNamed(AppRoutes.forgotPasswordScreen);
  }

  void _handleRegister() {
    Navigator.of(context).pushNamed(AppRoutes.registrationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appTheme.colorFF9FE5,
        body: Stack(children: [
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
          Positioned(
              top: 118.h,
              left: 30.h,
              child: SizedBox(
                  height: 669.h,
                  width: 372.h,
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 166.h),
                        child: SizedBox(
                            height: 84.h,
                            width: 222.h,
                            child: Center(
                                child: Text('PetAdote',
                                    style: TextStyleHelper
                                        .instance.display55LeckerliOne
                                        .copyWith(height: 1.35))))),
                    Column(children: [
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
                      SizedBox(
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
                            Positioned(
                                right: 12.h,
                                top: 0,
                                bottom: 0,
                                child: GestureDetector(
                                    onTap: _togglePasswordVisibility,
                                    child: SizedBox(
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
                      GestureDetector(
                          onTap: _handleForgotPassword,
                          child: Text('Esqueci a senha',
                              style: TextStyleHelper.instance.body15MediumInter
                                  .copyWith(
                                      height: 1.27,
                                      decoration: TextDecoration.underline))),
                      SizedBox(height: 138.h),
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