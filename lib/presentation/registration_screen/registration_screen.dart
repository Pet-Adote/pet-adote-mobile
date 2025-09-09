import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';
import '../../core/utils/validator_helper.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: Stack(
        children: [
          Positioned(
            top: 11.h,
            left: 0,
            child: CustomImageView(
              imagePath: ImageConstant.imgImage5,
              height: 885.h,
              width: 428.h,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxWidth: 400.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 32.h),
                        child: Text(
                          'PetAdote',
                          style: TextStyleHelper
                              .instance.display50RegularLeckerliOne
                              .copyWith(height: 1.36),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        children: [
                          CustomTextField(
                            placeholder: 'Nome',
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            placeholder: 'E-mail',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 24.h),
                          _buildPasswordField(),
                          SizedBox(height: 24.h),
                          _buildConfirmPasswordField(),
                          SizedBox(height: 32.h),
                          _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: 'Cadastrar',
                                  onPressed: () {
                                    _handleRegistration(context);
                                  },
                                ),
                          SizedBox(height: 16.h),
                          CustomButton(
                            text: 'Voltar',
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isPasswordVisible = false;
        return Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: appTheme.whiteCustom,
            border: Border.all(color: appTheme.colorFFE5E7),
            borderRadius: BorderRadius.circular(6.h),
          ),
          child: TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            style: TextStyleHelper.instance.title20SemiBoldInter,
            decoration: InputDecoration(
              hintText: 'Senha',
              hintStyle: TextStyleHelper.instance.title20SemiBoldInter
                  .copyWith(color: appTheme.grey500),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.img,
                    width: 20.h,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isPasswordVisible = false;
        return Container(
          height: 45.h,
          decoration: BoxDecoration(
            color: appTheme.whiteCustom,
            border: Border.all(color: appTheme.colorFFE5E7),
            borderRadius: BorderRadius.circular(6.h),
          ),
          child: TextFormField(
            controller: confirmPasswordController,
            obscureText: !isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            style: TextStyleHelper.instance.title20SemiBoldInter,
            decoration: InputDecoration(
              hintText: 'Confirmar senha',
              hintStyle: TextStyleHelper.instance.title20SemiBoldInter
                  .copyWith(color: appTheme.grey500),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.img,
                    width: 20.h,
                    height: 20.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleRegistration(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    String? nameError = (name.isEmpty) ? 'Por favor, preencha o nome' : null;
    String? emailError = ValidatorHelper.validateEmail(email);
    String? passwordError = ValidatorHelper.validatePassword(password);
    String? confirmPasswordError = ValidatorHelper.validateConfirmPassword(password, confirmPassword);

    final errorMsg = nameError ?? emailError ?? passwordError ?? confirmPasswordError;
    if (errorMsg != null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Cadastro realizado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
              },
              child: const Text('Ir para login'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: Text(FirebaseAuthHelper.getErrorMessage(e.code)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}