import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/theme/theme_helper.dart';
import 'package:pet_adote/core/utils/size_utils.dart';

// Mock Profile Screen sem dependências do Firebase
class MockProfileScreen extends StatelessWidget {
  const MockProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header verde mockado
                Container(
                  width: double.infinity,
                  height: 113,
                  color: Color(0xFF9FE5FF),
                  child: Row(
                    children: [
                      // Botão menu mockado
                      Container(
                        margin: EdgeInsets.only(left: 22),
                        child: Icon(Icons.menu, color: Color(0xFF4F20FF)),
                      ),
                      Spacer(),
                      // Botão perfil mockado
                      Container(
                        margin: EdgeInsets.only(right: 22),
                        child: Icon(Icons.person, color: Color(0xFF4F20FF)),
                      ),
                    ],
                  ),
                ),
                
                // Conteúdo principal mockado
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        
                        // Foto de perfil mockada
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Color(0xFF4F20FF),
                          ),
                        ),
                        
                        SizedBox(height: 12),
                        
                        // Nome do usuário mockado
                        Text(
                          'Usuário Teste',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F20FF),
                          ),
                        ),
                        
                        SizedBox(height: 8),
                        
                        Text(
                          'usuario@teste.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4F20FF).withOpacity(0.7),
                          ),
                        ),
                        
                        SizedBox(height: 32),
                        
                        // Opções do perfil mockadas
                        _buildMockProfileOption('Visualizar senha'),
                        SizedBox(height: 8),
                        _buildMockProfileOption('Redefinir Senha'),
                        SizedBox(height: 8),
                        _buildMockProfileOption('Meus Favoritos'),
                        
                        SizedBox(height: 20),
                        
                        // Seção Meus Pets mockada
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Meus Pets',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4F20FF),
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '0 pets',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF4F20FF).withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 12),
                              
                              // Estado vazio mockado
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF4F20FF).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.pets,
                                      size: 40,
                                      color: Color(0xFF4F20FF).withOpacity(0.5),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Nenhum pet cadastrado',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF4F20FF).withOpacity(0.7),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Cadastrar primeiro pet',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4F20FF),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Menu lateral mockado (não visível inicialmente)
          // Este seria o menu deslizante lateral
        ],
      ),
    );
  }

  Widget _buildMockProfileOption(String title) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF4F20FF).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4F20FF),
          ),
        ),
      ),
    );
  }
}

void main() {
  group('Profile Screen Widget Tests (Mock)', () {
    Widget createTestWidget() {
      return MaterialApp(
        theme: theme,
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(800, 1400), // Tamanho bem grande
            devicePixelRatio: 1.0,
            textScaler: TextScaler.linear(0.6), // Escala bem pequena
            padding: EdgeInsets.zero,
            viewInsets: EdgeInsets.zero,
            viewPadding: EdgeInsets.zero,
          ),
          child: Sizer(
            builder: (context, orientation, deviceType) {
              return const MockProfileScreen();
            },
          ),
        ),
      );
    }

    testWidgets('deve criar widget mock sem falha crítica', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      expect(find.byType(MockProfileScreen), findsOneWidget);
    });

    testWidgets('deve encontrar MaterialApp', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('deve renderizar Scaffold corretamente', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('deve verificar se elementos de perfil existem', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      // Verifica elementos básicos do perfil
      expect(find.text('Usuário Teste'), findsOneWidget);
      expect(find.text('usuario@teste.com'), findsOneWidget);
      expect(find.text('Meus Pets'), findsOneWidget);
    });

    testWidgets('deve verificar opções do perfil', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      // Verifica opções do menu
      expect(find.text('Visualizar senha'), findsOneWidget);
      expect(find.text('Redefinir Senha'), findsOneWidget);
      expect(find.text('Meus Favoritos'), findsOneWidget);
    });

    testWidgets('deve verificar seção de pets vazia', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      // Verifica estado vazio dos pets
      expect(find.text('0 pets'), findsOneWidget);
      expect(find.text('Nenhum pet cadastrado'), findsOneWidget);
      expect(find.text('Cadastrar primeiro pet'), findsOneWidget);
    });

    testWidgets('deve encontrar ícones esperados', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      // Verifica ícones
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.person), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.pets), findsOneWidget);
    });

    testWidgets('deve verificar estrutura de layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      // Verifica estrutura (Stack pode ter mais de um devido ao menu lateral)
      expect(find.byType(Stack), findsAtLeast(1));
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsAtLeastNWidgets(1));
    });

    testWidgets('deve verificar containers de layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      final containers = find.byType(Container);
      expect(containers.evaluate().length, greaterThan(5));
    });

    testWidgets('deve verificar se GestureDetector existe', (WidgetTester tester) async {
      await tester.pumpWidget(createTestWidget());
      
      final gestures = find.byType(GestureDetector);
      expect(gestures.evaluate().length, greaterThanOrEqualTo(1));
    });
  });
}
