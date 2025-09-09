
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_text_field.dart';
import '../../core/utils/validator_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleRecover(BuildContext context) async {
    final email = emailController.text.trim();
    final confirmEmail = confirmEmailController.text.trim();

    final emailError = ValidatorHelper.validateEmail(email);
    final confirmEmailError = ValidatorHelper.validateEmail(confirmEmail);
    final matchError = email != confirmEmail ? 'Os e-mails devem ser iguais' : null;

    if (emailError != null || confirmEmailError != null || matchError != null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: Text(emailError ?? confirmEmailError ?? matchError!),
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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('E-mail de recuperação enviado!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Voltar para o login'),
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
    } catch (e) {
      setState(() => _isLoading = false);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Erro inesperado. Tente novamente.'),
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
                          _isLoading
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: 'Recuperar',
                                  onPressed: () => _handleRecover(context),
                                ),
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Voltar para o login',
                              style: TextStyle(
                                color: appTheme.greenCustom,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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