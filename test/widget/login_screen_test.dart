import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/presentation/login_screen/login_screen.dart';
import 'package:pet_adote/routes/app_routes.dart';
import 'package:pet_adote/core/utils/image_constant.dart';
import 'package:pet_adote/widgets/custom_image_view.dart';

void main() {
  group('Login Screen Widget Tests', () {
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: const LoginScreen(),
        routes: {
          AppRoutes.registrationScreen: (_) => const Scaffold(body: Text('Registration')),
          AppRoutes.forgotPasswordScreen: (_) => const Scaffold(body: Text('Forgot')),
        },
      );
    }

    testWidgets('senha deve iniciar oculta e ser revelada ao tocar no ícone', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      final passwordField = find.byType(TextFormField).last;
      expect(tester.widget<TextFormField>(passwordField).obscureText, isTrue);

      final toggleIcon = find.byWidgetPredicate(
        (widget) => widget is CustomImageView && widget.imagePath == ImageConstant.img2,
      );
      await tester.tap(toggleIcon);
      await tester.pumpAndSettle();

      expect(tester.widget<TextFormField>(passwordField).obscureText, isFalse);
    });

    testWidgets('deve exibir mensagem de erro para e-mail inválido', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'email-invalido');
      await tester.enterText(find.byType(TextFormField).last, '123456');
      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();

      expect(find.text('Por favor, insira um e-mail válido'), findsOneWidget);
    });
  });
}