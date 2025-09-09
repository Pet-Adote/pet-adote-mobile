import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/presentation/login_screen/login_screen.dart';
import 'package:pet_adote/routes/app_routes.dart';

void main() {
  group('Login Flow Integration Tests', () {
    Widget createApp() {
      return MaterialApp(
        initialRoute: AppRoutes.loginScreen,
        routes: {
          AppRoutes.loginScreen: (_) => const LoginScreen(),
          AppRoutes.registrationScreen: (_) => const Scaffold(body: Text('Registration Page')),
          AppRoutes.forgotPasswordScreen: (_) => const Scaffold(body: Text('Forgot Page')),
        },
      );
    }

    testWidgets('deve navegar para tela de cadastro', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('CADASTRE-SE'));
      await tester.pumpAndSettle();

      expect(find.text('Registration Page'), findsOneWidget);
    });

    testWidgets('deve navegar para tela de recuperação de senha', (tester) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Esqueci a senha'));
      await tester.pumpAndSettle();

      expect(find.text('Forgot Page'), findsOneWidget);
    });
  });
}