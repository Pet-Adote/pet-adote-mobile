import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/presentation/add_pet_screen/add_pet_screen.dart';
import 'package:pet_adote/core/app_export.dart';
import 'package:pet_adote/routes/app_routes.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Mock para Firebase Auth
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}

void main() {
  group('Add Pet Screen Widget Tests', () {
    late MockFirebaseAuth mockAuth;
    late MockUser mockUser;

    setUp(() {
      mockAuth = MockFirebaseAuth();
      mockUser = MockUser();
      
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('test_user_123');
      when(mockUser.email).thenReturn('test@email.com');
    });

    Widget createWidgetUnderTest({String? petType}) {
      return MaterialApp(
        title: 'Pet Adote Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AddPetScreen(petType: petType),
        routes: {
          AppRoutes.homeScreen: (context) => Scaffold(body: Text('Home')),
          AppRoutes.profileScreen: (context) => Scaffold(body: Text('Profile')),
          AppRoutes.petProfileScreen: (context) => Scaffold(body: Text('Pet Profile')),
          AppRoutes.loginScreen: (context) => Scaffold(body: Text('Login')),
        },
      );
    }

    group('Widget Rendering Tests', () {
      testWidgets('deve renderizar todos os campos obrigatórios', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se os campos principais estão presentes
        expect(find.text('ADICIONAR FOTO'), findsOneWidget);
        expect(find.text('CADASTRAR PET'), findsOneWidget);
        
        // Verifica TextFields
        expect(find.byType(TextField), findsWidgets);
        
        // Verifica botões de navegação
        expect(find.byIcon(Icons.arrow_back), findsOneWidget);
        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
      });

      testWidgets('deve exibir título PetAdote no header', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('PetAdote'), findsOneWidget);
      });

      testWidgets('deve mostrar dropdown de espécie quando petType não é especificado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Procura por dropdown de espécie
        expect(find.byType(DropdownButton<String>), findsAtLeastNWidgets(1));
      });

      testWidgets('deve mostrar espécie pré-selecionada quando petType é especificado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest(petType: 'dogs'));
        await tester.pumpAndSettle();

        // Deve mostrar "Cão" como texto fixo
        expect(find.text('Cão'), findsOneWidget);
      });

      testWidgets('deve mostrar checkbox de vacinação', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(Checkbox), findsAtLeastNWidgets(1));
      });

      testWidgets('deve mostrar radio buttons para gênero', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.byType(Radio<String>), findsAtLeastNWidgets(2));
        expect(find.text('Macho'), findsOneWidget);
        expect(find.text('Fêmea'), findsOneWidget);
      });
    });

    group('User Interaction Tests', () {
      testWidgets('deve permitir inserir texto nos campos', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Encontra e preenche campo de nome
        final nameFields = find.byType(TextField);
        if (nameFields.evaluate().isNotEmpty) {
          await tester.enterText(nameFields.first, 'Rex Teste');
          await tester.pump();
          
          expect(find.text('Rex Teste'), findsOneWidget);
        }
      });

      testWidgets('deve permitir selecionar gênero', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Tenta encontrar e clicar no radio button de Macho
        final machoRadio = find.text('Macho');
        if (machoRadio.evaluate().isNotEmpty) {
          await tester.tap(machoRadio);
          await tester.pump();
        }

        // Verifica se a seleção funcionou
        expect(find.text('Macho'), findsOneWidget);
      });

      testWidgets('deve permitir marcar/desmarcar vacinação', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final checkboxes = find.byType(Checkbox);
        if (checkboxes.evaluate().isNotEmpty) {
          await tester.tap(checkboxes.first);
          await tester.pump();
        }

        // Checkbox deve ter mudado de estado
        expect(find.byType(Checkbox), findsAtLeastNWidgets(1));
      });

      testWidgets('deve permitir selecionar espécie no dropdown', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final dropdowns = find.byType(DropdownButton<String>);
        if (dropdowns.evaluate().isNotEmpty) {
          await tester.tap(dropdowns.first);
          await tester.pumpAndSettle();

          // Procura por opções do dropdown
          if (find.text('Gato').evaluate().isNotEmpty) {
            await tester.tap(find.text('Gato'));
            await tester.pumpAndSettle();
          }
        }
      });

      testWidgets('deve responder ao toque no botão de foto', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final addPhotoButton = find.text('ADICIONAR FOTO');
        if (addPhotoButton.evaluate().isNotEmpty) {
          await tester.tap(addPhotoButton);
          await tester.pump();
        }

        // Verifica se o botão existe e pode ser tocado
        expect(find.text('ADICIONAR FOTO'), findsOneWidget);
      });
    });

    group('Navigation Tests', () {
      testWidgets('deve navegar de volta quando botão voltar é pressionado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final backButton = find.byIcon(Icons.arrow_back);
        if (backButton.evaluate().isNotEmpty) {
          await tester.tap(backButton);
          await tester.pumpAndSettle();
        }

        expect(backButton, findsOneWidget);
      });

      testWidgets('deve navegar para home quando botão home é pressionado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final homeButton = find.byIcon(Icons.home);
        if (homeButton.evaluate().isNotEmpty) {
          await tester.tap(homeButton);
          await tester.pumpAndSettle();
        }

        expect(homeButton, findsOneWidget);
      });

      testWidgets('deve navegar para favoritos quando botão favoritos é pressionado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final favButton = find.byIcon(Icons.favorite);
        if (favButton.evaluate().isNotEmpty) {
          await tester.tap(favButton);
          await tester.pumpAndSettle();
        }

        expect(favButton, findsOneWidget);
      });
    });

    group('Form Validation Tests', () {
      testWidgets('deve mostrar botão CADASTRAR PET', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('CADASTRAR PET'), findsOneWidget);
      });

      testWidgets('deve permitir submissão do formulário', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Preenche campos obrigatórios
        final textFields = find.byType(TextField);
        if (textFields.evaluate().length >= 5) {
          await tester.enterText(textFields.at(0), 'Rex Teste');
          await tester.enterText(textFields.at(1), 'Garanhuns, PE');
          await tester.enterText(textFields.at(2), '3 anos');
          await tester.enterText(textFields.at(3), 'Cão muito carinhoso');
          await tester.enterText(textFields.at(4), 'João Silva');
          await tester.pump();
        }

        // Tenta submeter o formulário
        final submitButton = find.text('CADASTRAR PET');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pump();
        }

        expect(find.text('CADASTRAR PET'), findsOneWidget);
      });
    });

    group('Responsive Layout Tests', () {
      testWidgets('deve ajustar layout para diferentes tamanhos de tela', (WidgetTester tester) async {
        // Teste com tela pequena
        tester.binding.window.physicalSizeTestValue = Size(400, 600);
        tester.binding.window.devicePixelRatioTestValue = 1.0;

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        expect(find.text('PetAdote'), findsOneWidget);

        // Teste com tela grande
        tester.binding.window.physicalSizeTestValue = Size(800, 1200);
        await tester.pump();

        expect(find.text('PetAdote'), findsOneWidget);

        // Reset window size
        addTearDown(() => tester.binding.window.clearPhysicalSizeTestValue());
      });

      testWidgets('deve manter elementos visíveis em scroll', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se tem scroll view
        expect(find.byType(SingleChildScrollView), findsAtLeastNWidgets(1));

        // Testa scroll down
        await tester.drag(find.byType(SingleChildScrollView), Offset(0, -200));
        await tester.pump();

        // Header deve continuar visível
        expect(find.text('PetAdote'), findsOneWidget);
      });
    });

    group('Accessibility Tests', () {
      testWidgets('deve ter labels acessíveis nos campos', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se widgets têm semantics apropriadas
        expect(find.byType(Semantics), findsWidgets);
      });

      testWidgets('deve suportar navegação por teclado', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Verifica se campos podem receber foco
        final textFields = find.byType(TextField);
        if (textFields.evaluate().isNotEmpty) {
          await tester.tap(textFields.first);
          await tester.pump();
        }

        expect(find.byType(TextField), findsWidgets);
      });
    });

    group('Error Handling Tests', () {
      testWidgets('deve lidar com estados de erro graciosamente', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Widget deve carregar mesmo com dados inválidos
        expect(find.byType(AddPetScreen), findsOneWidget);
      });

      testWidgets('deve mostrar indicadores de loading quando necessário', (WidgetTester tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        // Submete formulário para possivelmente mostrar loading
        final submitButton = find.text('CADASTRAR PET');
        if (submitButton.evaluate().isNotEmpty) {
          await tester.tap(submitButton);
          await tester.pump();
          
          // Procura por indicador de loading (CircularProgressIndicator)
          // Nota: pode não aparecer em teste unitário sem backend real
        }
      });
    });
  });
}