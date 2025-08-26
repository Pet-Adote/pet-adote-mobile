
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();

  Future<void> _handleRecover(BuildContext context) async {
    String email = emailController.text.trim();
    String confirmEmail = confirmEmailController.text.trim();

    if (email.isEmpty || confirmEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha ambos os e-mails.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, insira um e-mail válido.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    if (email != confirmEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Os e-mails devem ser iguais.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    final navigator = Navigator.of(context);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('E-mail de recuperação enviado!'),
          backgroundColor: appTheme.greenCustom,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        navigator.pop();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao enviar e-mail: ${e.toString()}'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
  }

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
                            placeholder: 'E-mail',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                            placeholder: 'Confirmar e-mail',
                            controller: confirmEmailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _handleRecover(context),
                          ),
                          SizedBox(height: 32.h),
                          CustomButton(
                            text: 'Recuperar',
                            onPressed: () => _handleRecover(context),
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
}