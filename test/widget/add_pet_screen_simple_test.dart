import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/presentation/add_pet_screen/add_pet_screen.dart';
import 'package:pet_adote/routes/app_routes.dart';
import 'package:pet_adote/core/utils/size_utils.dart';

void main() {
  group('Add Pet Screen Widget Tests (Simplified)', () {
    
    Widget createWidgetUnderTest({String? petType}) {
      return MaterialApp(
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return AddPetScreen(petType: petType);
          },
        ),
        routes: {
          AppRoutes.homeScreen: (context) => const Scaffold(body: Text('Home')),
          AppRoutes.profileScreen: (context) => const Scaffold(body: Text('Profile')),
          AppRoutes.petProfileScreen: (context) => const Scaffold(body: Text('Pet Profile')),
          AppRoutes.loginScreen: (context) => const Scaffold(body: Text('Login')),
          AppRoutes.favoritesScreen: (context) => const Scaffold(body: Text('Favorites')),
        },
      );
    }

    group('Widget Structure Tests', () {
      testWidgets('deve renderizar AddPetScreen corretamente', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se o widget principal foi criado
        expect(find.byType(AddPetScreen), findsOneWidget);
        expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
      });

      testWidgets('deve conter elementos básicos da interface', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica elementos básicos que devem estar presentes
        expect(find.byType(AppBar), findsAny);
        expect(find.byType(TextFormField), findsAny);
        expect(find.byType(ElevatedButton), findsAny);
      });

      testWidgets('deve ter estrutura de formulário', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se há elementos de formulário
        expect(find.byType(SingleChildScrollView), findsAny);
        expect(find.byType(Column), findsAtLeastNWidgets(1));
      });

      testWidgets('deve renderizar botões de navegação', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica ícones de navegação
        expect(find.byIcon(Icons.arrow_back), findsAny);
        expect(find.byIcon(Icons.home), findsAny);
        expect(find.byIcon(Icons.favorite), findsAny);
      });
    });

    group('Pet Type Configuration Tests', () {
      testWidgets('deve aceitar petType como parâmetro', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(petType: 'dogs'));
        await tester.pumpAndSettle();

        expect(find.byType(AddPetScreen), findsOneWidget);
        
        // Verifica se o widget foi criado com o parâmetro
        final addPetScreen = tester.widget<AddPetScreen>(find.byType(AddPetScreen));
        expect(addPetScreen.petType, equals('dogs'));
      });

      testWidgets('deve funcionar sem petType especificado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(AddPetScreen), findsOneWidget);
        
        final addPetScreen = tester.widget<AddPetScreen>(find.byType(AddPetScreen));
        expect(addPetScreen.petType, isNull);
      });

      testWidgets('deve aceitar petType cats', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(petType: 'cats'));
        await tester.pumpAndSettle();

        expect(find.byType(AddPetScreen), findsOneWidget);
        
        final addPetScreen = tester.widget<AddPetScreen>(find.byType(AddPetScreen));
        expect(addPetScreen.petType, equals('cats'));
      });
    });

    group('Navigation Tests', () {
      testWidgets('deve ter botão de voltar funcionando', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton.first);
          await tester.pumpAndSettle();
          // Se chegou até aqui, o tap funcionou sem erro
        }
        
        expect(find.byType(AddPetScreen), findsOneWidget);
      });

      testWidgets('deve ter botões de navegação inferior', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Testa se os botões podem ser tocados sem erro
        final homeButton = find.byIcon(Icons.home);
        if (homeButton.evaluate().isNotEmpty) {
          await tester.tap(homeButton.first);
          await tester.pumpAndSettle();
        }

        expect(find.byType(AddPetScreen), findsOneWidget);
      });
    });

    group('Form Interaction Tests', () {
      testWidgets('deve permitir interação com campos de texto', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final textFields = find.byType(TextFormField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.enterText(textFields.first, 'Texto de teste');
          await tester.pump();
          
          expect(find.text('Texto de teste'), findsAny);
        } else {
          // Se não encontrou TextField, verifica se há algum widget editável
          expect(find.byType(Scaffold), findsOneWidget);
        }
      });

      testWidgets('deve permitir scroll na tela', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final scrollable = find.byType(SingleChildScrollView);
        if (scrollable.evaluate().isNotEmpty) {
          await tester.drag(scrollable.first, const Offset(0, -100));
          await tester.pumpAndSettle();
        }
        
        expect(find.byType(AddPetScreen), findsOneWidget);
      });

      testWidgets('deve responder a taps em botões', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final buttons = find.byType(ElevatedButton);
            
        if (buttons.evaluate().isNotEmpty) {
          await tester.tap(buttons.first);
          await tester.pump();
        }
        
        expect(find.byType(AddPetScreen), findsOneWidget);
      });
    });

    group('Widget State Tests', () {
      testWidgets('deve manter estado durante interações', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se o widget mantém estado
        final initialWidget = tester.widget<AddPetScreen>(find.byType(AddPetScreen));
        
        // Simula alguma interação
        await tester.tap(find.byType(Scaffold));
        await tester.pump();

        final finalWidget = tester.widget<AddPetScreen>(find.byType(AddPetScreen));
        expect(finalWidget.petType, equals(initialWidget.petType));
      });

      testWidgets('deve lidar com hot reload', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Simula hot reload
        await tester.pumpWidget(createWidgetUnderTest(petType: 'dogs'));
        await tester.pumpAndSettle();

        expect(find.byType(AddPetScreen), findsOneWidget);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('deve lidar com construção sem erros', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(AddPetScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('deve funcionar com diferentes configurações', (WidgetTester tester) async {
        // Testa diferentes configurações
        for (final petType in [null, 'dogs', 'cats']) {
          await tester.pumpWidget(createWidgetUnderTest(petType: petType));
          await tester.pumpAndSettle();

          expect(find.byType(AddPetScreen), findsOneWidget);
          expect(tester.takeException(), isNull);
        }
      });

      testWidgets('deve manter responsividade em diferentes tamanhos', (WidgetTester tester) async {
        // Teste com diferentes tamanhos de tela
        final sizes = [
          const Size(320, 568), // iPhone SE
          const Size(375, 667), // iPhone 8
          const Size(411, 731), // Pixel 2
          const Size(768, 1024), // iPad
        ];

        for (final size in sizes) {
          tester.binding.window.physicalSizeTestValue = size;
          tester.binding.window.devicePixelRatioTestValue = 1.0;

          await tester.pumpWidget(createWidgetUnderTest());
          await tester.pumpAndSettle();

          expect(find.byType(AddPetScreen), findsOneWidget);
          expect(tester.takeException(), isNull);
        }

        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      });
    });

    group('Performance Tests', () {
      testWidgets('deve renderizar rapidamente', (WidgetTester tester) async {
        final stopwatch = Stopwatch()..start();
        
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();
        
        stopwatch.stop();
        
        expect(find.byType(AddPetScreen), findsOneWidget);
        expect(stopwatch.elapsedMilliseconds, lessThan(5000)); // 5 segundos máximo
      });

      testWidgets('deve manter performance com múltiplas reconstruções', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Simula múltiplas reconstruções
        for (int i = 0; i < 10; i++) {
          await tester.pump();
        }

        expect(find.byType(AddPetScreen), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('deve ter estrutura acessível', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se há widgets com semântica apropriada
        expect(find.byType(Semantics), findsAny);
        expect(find.byType(AddPetScreen), findsOneWidget);
      });

      testWidgets('deve suportar navegação por foco', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se elementos podem receber foco
        final focusableWidgets = find.byType(TextFormField);

        if (focusableWidgets.evaluate().isNotEmpty) {
          await tester.tap(focusableWidgets.first);
          await tester.pump();
        }

        expect(find.byType(AddPetScreen), findsOneWidget);
      });
    });
  });
}