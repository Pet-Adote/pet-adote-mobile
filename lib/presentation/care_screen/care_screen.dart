import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _closeMenu() {
    setState(() {
      _isMenuOpen = false;
    });
  }

  void _handleLogout() {
    _closeMenu();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appTheme.colorFFF1F1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Sair do App',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.fSize,
              fontWeight: FontWeight.bold,
              color: appTheme.colorFF4F20,
            ),
          ),
          content: Text(
            'Tem certeza que deseja sair?',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16.fSize,
              color: appTheme.colorFF4F20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.fSize,
                  color: appTheme.grey600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed(AppRoutes.loginScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appTheme.colorFF4F20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Sair',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.fSize,
                  fontWeight: FontWeight.w500,
                  color: appTheme.colorFFF1F1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleFavorites() {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.favoritesScreen);
  }

  void _handleAboutUs() {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.aboutUsScreen);
  }

  void _handleFAQ() {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.faqScreen);
  }

  void _handleCare() {
    _closeMenu();
  }

  void _launchPhone(String phoneNumber) {
    // Copia o número para a área de transferência
    Clipboard.setData(ClipboardData(text: phoneNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Número $phoneNumber copiado para área de transferência'),
        backgroundColor: appTheme.colorFF4F20,
      ),
    );
  }

  void _launchMaps(String address) {
    // Copia o endereço para a área de transferência
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Endereço "$address" copiado para área de transferência'),
        backgroundColor: appTheme.colorFF4F20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: Stack(
        children: [
          // Conteúdo principal
          Column(
            children: [
              // Header verde
              Container(
                width: double.infinity,
                height: 113.h,
                color: appTheme.colorFF9FE5,
                child: SafeArea(
                  child: Row(
                    children: [
                      // Navegação - Botão Voltar e Menu
                      Row(
                        children: [
                          // Botão Voltar
                          Container(
                            margin: EdgeInsets.only(left: 22.h),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.h),
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    borderRadius: BorderRadius.circular(8.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.h,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appTheme.colorFF4F20,
                                    size: 22.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(width: 12.h),
                          
                          // Menu hambúrguer
                          Container(
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.h),
                              child: InkWell(
                                onTap: _toggleMenu,
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    borderRadius: BorderRadius.circular(8.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.h,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
                                        ),
                                      ),
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
                                        ),
                                      ),
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
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

                      // Logo centralizado
                      Expanded(
                        child: Center(
                          child: Text(
                            'PetAdote',
                            style: TextStyle(
                              fontFamily: 'Leckerli One',
                              fontSize: 28.fSize,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                        ),
                      ),

                      // Ícone de perfil
                      Container(
                        margin: EdgeInsets.only(right: 22.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.profileScreen);
                          },
                          child: Container(
                            width: 49.h,
                            height: 64.h,
                            child: Column(
                              children: [
                                Container(
                                  width: 49.h,
                                  height: 49.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF9FE5,
                                    border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    size: 30.h,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Perfil',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.fSize,
                                    fontWeight: FontWeight.w600,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Conteúdo da tela de cuidados
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // Título "Cuidados"
                      Row(
                        children: [
                          Text(
                            'Cuidados',
                            style: TextStyle(
                              fontFamily: 'Coiny',
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.w400,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.h),
                              height: 1,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Item ONGs
                      _buildCareItem(
                        icon: Icons.pets,
                        title: 'ONGs',
                        description: 'Veja aqui ONGs mais próximas de você.',
                        details: [
                          'APAC Garanhuns - Rua José Mariano, 123',
                          'Proteção Animal Garanhuns - Av. Caruaru, 456',
                          'Adote um Amigo - Rua do Socorro, 789'
                        ],
                        onTap: () => _launchMaps('ONGs proteção animal Garanhuns PE'),
                      ),

                      _buildDivider(),

                      // Item Veterinários
                      _buildCareItem(
                        icon: Icons.medical_services,
                        title: 'Veterinários',
                        description: 'Veja aqui Veterinários e especialidades mais próximos de você.',
                        details: [
                          'Clínica Veterinária Pet Care - (87) 3761-2345',
                          'Dr. João Silva - Especialista em felinos - (87) 3761-1234',
                          'Veterinária São Francisco - (87) 3761-5678',
                          'Hospital Veterinário Central - (87) 3761-9999'
                        ],
                        onTap: () => _launchMaps('veterinário Garanhuns PE'),
                      ),

                      _buildDivider(),

                      // Item PetShops
                      _buildCareItem(
                        icon: Icons.store,
                        title: 'PetShops',
                        description: 'Veja aqui PetShops mais próximos de você.',
                        details: [
                          'Pet Shop Central - Rua 15 de Novembro, 234',
                          'Mundo Pet - Av. Rui Barbosa, 567',
                          'Casa do Pet - Rua Santo Antônio, 890',
                          'Pet Mania - Rua do Comércio, 321'
                        ],
                        onTap: () => _launchMaps('pet shop Garanhuns PE'),
                      ),

                      _buildDivider(),

                      // Item Cuidados Básicos
                      _buildCareItem(
                        icon: Icons.shower,
                        title: 'Cuidados básicos',
                        description: 'Hora do banho! Veja aqui dicas de cuidados para o seu pet.',
                        details: [
                          'Banho quinzenal ou mensal',
                          'Escovação diária',
                          'Corte de unhas mensal',
                          'Limpeza de ouvidos semanal',
                          'Escovação dos dentes 3x/semana'
                        ],
                        onTap: null,
                      ),

                      _buildDivider(),

                      // Item Clube do Pet
                      _buildCareItem(
                        icon: Icons.group,
                        title: 'Clube do Pet',
                        description: 'Traga seu amigo para o nosso Clubinho e interaja em locais públicos.',
                        details: [
                          'Parque José Mariano - Área pet liberada',
                          'Praça Tavares Correia - Caminhadas matinais',
                          'Parque da Criança - Espaço pet aos domingos',
                          'Encontros quinzenais no Parque Central'
                        ],
                        onTap: () => _launchMaps('parques pet friendly Garanhuns PE'),
                      ),

                      _buildDivider(),

                      // Item Vacinação
                      _buildCareItem(
                        icon: Icons.vaccines,
                        title: 'Vacinação',
                        description: 'Veja aqui locais de vacinação mais próximos de você.',
                        details: [
                          'Centro de Controle de Zoonoses - (87) 3761-3333',
                          'UBS Centro - Campanhas mensais',
                          'Clínica Municipal de Saúde Animal',
                          'Vacinação antirrábica anual gratuita'
                        ],
                        onTap: () => _launchPhone('87 3761-3333'),
                      ),

                      _buildDivider(),

                      // Item Outros
                      _buildCareItem(
                        icon: Icons.more_horiz,
                        title: 'Outros',
                        description: 'Outros cuidados e dicas para você e seu pet.',
                        details: [
                          'Microchipagem na Secretaria de Saúde',
                          'Castração gratuita - Programa municipal',
                          'Adestramento: Escola Canina Garanhuns',
                          'Emergências 24h: Hospital Pet Care'
                        ],
                        onTap: () => _launchPhone('87 3761-1500'),
                      ),

                      SizedBox(height: 120.h), // Espaço para o rodapé
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Overlay escuro quando menu está aberto
          if (_isMenuOpen)
            GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.black.withOpacity(0.3),
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // Menu lateral
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _isMenuOpen ? 0 : -308,
            top: 0,
            child: Container(
              width: 308,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: appTheme.colorFF9FE5,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: Offset(2, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header do menu
                  Padding(
                    padding: EdgeInsets.only(top: 36.h, right: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: _closeMenu,
                          child: Text(
                            'X',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 24.fSize,
                              fontWeight: FontWeight.bold,
                              color: appTheme.blackCustom,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Título do menu
                  Padding(
                    padding: EdgeInsets.only(left: 34.h, top: 40.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'MENU',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 40.fSize,
                          fontWeight: FontWeight.bold,
                          color: appTheme.colorFF4F20,
                        ),
                      ),
                    ),
                  ),
                  
                  // Opções do menu
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.h),
                      child: Column(
                        children: [
                          SizedBox(height: 40.h),
                          
                          // Favoritos
                          _buildMenuItem(
                            'Favoritos',
                            onTap: _handleFavorites,
                          ),
                          _buildDivider(),
                          
                          // Quem Somos
                          _buildMenuItem(
                            'Quem Somos',
                            onTap: _handleAboutUs,
                          ),
                          _buildDivider(),
                          
                          // FAQ
                          _buildMenuItem(
                            'FAQ',
                            onTap: _handleFAQ,
                          ),
                          _buildDivider(),
                        ],
                      ),
                    ),
                  ),
                  
                  // Botão de logout
                  Padding(
                    padding: EdgeInsets.only(bottom: 76.h),
                    child: GestureDetector(
                      onTap: _handleLogout,
                      child: Container(
                        width: 157.h,
                        height: 26.h,
                        decoration: BoxDecoration(
                          color: appTheme.colorFF4F20,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Sair',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w500,
                              color: appTheme.colorFFF1F1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Rodapé fixo
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80.h,
              color: appTheme.colorFF9FE5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botão Home
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
                        },
                        child: Container(
                          width: 38.h,
                          height: 38.h,
                          decoration: BoxDecoration(
                            color: appTheme.colorFF9FE5,
                            border: Border.all(color: appTheme.colorFF4F20, width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.home,
                            color: appTheme.colorFF4F20,
                            size: 20.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Home',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.fSize,
                          fontWeight: FontWeight.w600,
                          color: appTheme.colorFF4F20,
                        ),
                      ),
                    ],
                  ),
                  
                  // Botão Cuidados (destacado)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 38.h,
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: appTheme.colorFF4F20,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: appTheme.colorFF9FE5,
                          size: 20.h,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Cuidados',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.fSize,
                          fontWeight: FontWeight.w600,
                          color: appTheme.colorFF4F20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCareItem({
    required IconData icon,
    required String title,
    required String description,
    required List<String> details,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ícone
            Container(
              width: 74.h,
              height: 74.h,
              decoration: BoxDecoration(
                color: appTheme.whiteCustom,
                shape: BoxShape.circle,
                border: Border.all(color: appTheme.blackCustom, width: 1),
              ),
              child: Icon(
                icon,
                size: 40.h,
                color: appTheme.colorFF4F20,
              ),
            ),
            
            SizedBox(width: 16.h),
            
            // Conteúdo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.bold,
                      color: appTheme.colorFF4F20,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Descrição
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w400,
                      color: appTheme.colorFF4F20,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Detalhes específicos de Garanhuns
                  ...details.map((detail) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Text(
                      detail,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.fSize,
                        fontWeight: FontWeight.w400,
                        color: appTheme.colorFF4F20.withOpacity(0.8),
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: 90.h, right: 16.h),
      color: appTheme.blackCustom,
    );
  }

  Widget _buildMenuItem(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.fSize,
            fontWeight: FontWeight.bold,
            color: appTheme.colorFF4F20,
          ),
        ),
      ),
    );
  }

}