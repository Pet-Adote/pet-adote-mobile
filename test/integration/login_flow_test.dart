import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/presentation/login_screen/login_screen.dart';
import 'package:pet_adote/core/utils/size_utils.dart';
import 'package:pet_adote/routes/app_routes.dart';

void main() {
  group('Login Flow Integration Tests', () {
    Widget createApp() {
      return MaterialApp(
        initialRoute: AppRoutes.loginScreen,
        routes: {
          // Wrap LoginScreen in Sizer so SizeUtils is initialized (used by responsive extensions)
          AppRoutes.loginScreen: (_) => Sizer(builder: (context, orientation, deviceType) => const LoginScreen()),
          AppRoutes.registrationScreen: (_) => const Scaffold(body: Text('Registration Page')),
          AppRoutes.forgotPasswordScreen: (_) => const Scaffold(body: Text('Forgot Page')),
        },
      );
    }

    testWidgets('deve navegar para tela de cadastro', (tester) async {
      // make the test window taller so large positioned widgets are within the test surface
  tester.binding.window.physicalSizeTestValue = const Size(1000, 2000);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('CADASTRE-SE'));
      await tester.pumpAndSettle();

      expect(find.text('Registration Page'), findsOneWidget);
    });

    testWidgets('deve navegar para tela de recuperação de senha', (tester) async {
      // make the test window taller so large positioned widgets are within the test surface
  tester.binding.window.physicalSizeTestValue = const Size(1000, 2000);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(() {
        tester.binding.window.clearPhysicalSizeTestValue();
        tester.binding.window.clearDevicePixelRatioTestValue();
      });

      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Esqueci a senha'));
      await tester.pumpAndSettle();

      expect(find.text('Forgot Page'), findsOneWidget);
    });
  });
}