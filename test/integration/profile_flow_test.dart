import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/theme/theme_helper.dart';
import 'package:pet_adote/core/utils/size_utils.dart';

// Mock Profile Screen para integração sem Firebase
class MockProfileScreen extends StatefulWidget {
  const MockProfileScreen({super.key});

  @override
  State<MockProfileScreen> createState() => _MockProfileScreenState();
}

class _MockProfileScreenState extends State<MockProfileScreen> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

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
                        child: GestureDetector(
                          onTap: _toggleMenu,
                          child: Icon(Icons.menu, color: Color(0xFF4F20FF)),
                        ),
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
                        GestureDetector(
                          onTap: () {
                            // Mock para ação de trocar foto
                          },
                          child: Container(
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
                              Text(
                                'Meus Pets',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4F20FF),
                                ),
                              ),
                              
                              SizedBox(height: 12),
                              
                              // Estado vazio mockado
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
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
                                        color: Color(0xFF4F20FF).withOpacity(0.7),
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
          
          // Menu lateral mockado
          if (_isMenuOpen)
            GestureDetector(
              onTap: _toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 250,
                    height: double.infinity,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          color: Color(0xFF9FE5FF),
                          child: Center(
                            child: Text(
                              'MENU',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4F20FF),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              _buildMenuItem('Favoritos'),
                              _buildMenuItem('Quem Somos'),
                              _buildMenuItem('FAQ'),
                              _buildMenuItem('Denúncia'),
                            ],
                          ),
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

  Widget _buildMockProfileOption(String title) {
    return GestureDetector(
      onTap: () {
        // Mock para ação do item
      },
      child: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4F20FF),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return GestureDetector(
      onTap: () {
        _toggleMenu();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF4F20FF),
          ),
        ),
      ),
    );
  }
}

void main() {
  group('Testes de Integração - Fluxo do Perfil', () {
    late Widget testApp;

    setUp(() {
      testApp = MaterialApp(
        theme: theme,
        home: Sizer(
          builder: (context, orientation, deviceType) {
            return const MockProfileScreen();
          },
        ),
      );
    });

    testWidgets('1. Deve carregar a tela do perfil com sucesso', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Verifica se a tela carregou com elementos principais
      expect(find.byType(MockProfileScreen), findsOneWidget);
      expect(find.text('Usuário Teste'), findsOneWidget);
      expect(find.text('usuario@teste.com'), findsOneWidget);
    });

    testWidgets('2. Deve exibir informações do usuário', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Verifica informações mockadas do usuário
      expect(find.text('Usuário Teste'), findsOneWidget);
      expect(find.text('usuario@teste.com'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsAtLeast(1));
    });

    testWidgets('3. Deve exibir opções do perfil', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Verifica se as opções do perfil estão presentes
      expect(find.text('Visualizar senha'), findsOneWidget);
      expect(find.text('Redefinir Senha'), findsOneWidget);
      expect(find.text('Meus Favoritos'), findsOneWidget);
    });

    testWidgets('4. Deve abrir e fechar menu lateral', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Procura pelo ícone de menu
      final menuIcon = find.byIcon(Icons.menu);
      expect(menuIcon, findsOneWidget);

      // Toca no menu
      await tester.tap(menuIcon);
      await tester.pumpAndSettle();

      // Verifica se o menu abriu
      expect(find.text('MENU'), findsOneWidget);
      expect(find.text('Favoritos'), findsOneWidget);
      expect(find.text('Quem Somos'), findsOneWidget);
      expect(find.text('FAQ'), findsOneWidget);
      expect(find.text('Denúncia'), findsOneWidget);

      // Fecha o menu tocando fora
      await tester.tapAt(const Offset(300, 300));
      await tester.pumpAndSettle();

      // Verifica se o menu fechou
      expect(find.text('MENU'), findsNothing);
    });

    testWidgets('5. Deve interagir com opções do perfil', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Testa interação com "Visualizar senha"
      final visualizarSenha = find.text('Visualizar senha');
      expect(visualizarSenha, findsOneWidget);
      
      await tester.tap(visualizarSenha);
      await tester.pumpAndSettle();

      // Testa interação com "Redefinir Senha"
      final redefinirSenha = find.text('Redefinir Senha');
      expect(redefinirSenha, findsOneWidget);
      
      await tester.tap(redefinirSenha);
      await tester.pumpAndSettle();

      // Testa interação com "Meus Favoritos"
      final meusFavoritos = find.text('Meus Favoritos');
      expect(meusFavoritos, findsOneWidget);
      
      await tester.tap(meusFavoritos);
      await tester.pumpAndSettle();
    });

    testWidgets('6. Deve exibir seção "Meus Pets"', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Verifica se a seção está presente
      expect(find.text('Meus Pets'), findsOneWidget);
      expect(find.text('Nenhum pet cadastrado'), findsOneWidget);
      expect(find.byIcon(Icons.pets), findsOneWidget);
    });

    testWidgets('7. Deve permitir scroll na tela', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Verifica elementos iniciais
      expect(find.text('Usuário Teste'), findsOneWidget);
      expect(find.text('Meus Pets'), findsOneWidget);

      // Faz scroll para baixo
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pumpAndSettle();

      // Verifica se ainda consegue ver elementos
      expect(find.text('Nenhum pet cadastrado'), findsOneWidget);

      // Faz scroll para cima
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, 200));
      await tester.pumpAndSettle();

      // Verifica se voltou ao topo
      expect(find.text('Usuário Teste'), findsOneWidget);
    });

    testWidgets('8. Deve testar navegação completa entre elementos', (tester) async {
      await tester.pumpWidget(testApp);
      await tester.pumpAndSettle();

      // Navega pelos elementos principais
      expect(find.text('Usuário Teste'), findsOneWidget);
      
      // Abre menu
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      
      // Toca em FAQ no menu
      await tester.tap(find.text('FAQ'));
      await tester.pumpAndSettle();
      
      // Verifica se menu fechou
      expect(find.text('MENU'), findsNothing);
      
      // Interage com opções do perfil
      await tester.tap(find.text('Meus Favoritos'));
      await tester.pumpAndSettle();
      
      // Verifica se a tela ainda está funcional
      expect(find.text('Usuário Teste'), findsOneWidget);
      expect(find.text('Meus Pets'), findsOneWidget);
    });
  });
}
