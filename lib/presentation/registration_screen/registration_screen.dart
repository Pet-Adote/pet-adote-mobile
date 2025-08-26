import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                            validator: (value) =>
                                (value?.trim().isEmpty ?? true)
                                    ? 'Por favor, preencha o nome'
                                    : null,
                          ),

                          SizedBox(height: 24.h),

                          
                          CustomTextField(
                            placeholder: 'E-mail',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'Por favor, preencha o e-mail';
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value!)) {
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 24.h),

                          
                          _buildPasswordField(),

                          SizedBox(height: 32.h),

                          
                          CustomButton(
                            text: 'Cadastrar',
                            onPressed: () {
                              _handleRegistration(context);
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
            textInputAction: TextInputAction.done,
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
            validator: (value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Por favor, preencha a senha';
              }
              if ((value?.length ?? 0) < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
        );
      },
    );
  }

  Future<void> _handleRegistration(BuildContext context) async {


    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um e-mail válido.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A senha deve ter pelo menos 6 caracteres.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final navigator = Navigator.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: appTheme.greenCustom,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        navigator.pushReplacementNamed(AppRoutes.loginScreen);
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Erro ao realizar cadastro.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
  }
}
