import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header verde
                Container(
                  width: double.infinity,
                  height: 113.h,
                  color: appTheme.colorFF9FE5,
                  child: Row(
                    children: [
                      // Navegação - Botão Voltar e Menu
                      Row(
                        children: [
                          // Botão Voltar
                          Container(
                            margin: EdgeInsets.only(left: 22.h, top: 48.h),
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
                            margin: EdgeInsets.only(top: 48.h),
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
                        child: Container(
                          margin: EdgeInsets.only(top: 40.h),
                          child: Center(
                            child: Text(
                              'PetAdote',
                              style: TextStyleHelper.instance.display55LeckerliOne.copyWith(
                                fontSize: 28.fSize,
                                color: appTheme.colorFF4F20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      // Botão Perfil
                      Container(
                        margin: EdgeInsets.only(right: 30.h, top: 37.h),
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
                
                // Conteúdo principal
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        
                        // Título
                        Padding(
                          padding: EdgeInsets.only(left: 15.h),
                          child: Text(
                            'Fale conosco e obtenha ajuda',
                            style: TextStyle(
                              fontFamily: 'Coiny',
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.w400,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 12.h),
                        
                        // Linha divisória
                        Container(
                          margin: EdgeInsets.only(left: 62.h),
                          width: 296.h,
                          height: 1.h,
                          color: Colors.black,
                        ),
                        
                        SizedBox(height: 70.h),
                        
                        // Seção Fale conosco
                        Center(
                          child: Column(
                            children: [
                              // Botão Fale conosco
                              Container(
                                width: 101.h,
                                height: 33.h,
                                decoration: BoxDecoration(
                                  color: appTheme.colorFF4F20,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Fale conosco',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.fSize,
                                      fontWeight: FontWeight.w700,
                                      color: appTheme.colorFFF1F1,
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 17.h),
                              
                              // Informações de contato
                              Container(
                                width: 270.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Text(
                                  'Central de Atendimento do PetAdote:\n0800 4241-0758 (para todo o Brasil)\n0800 5587-4768 (para deficientes auditivos)',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.fSize,
                                    fontWeight: FontWeight.w700,
                                    color: appTheme.colorFF4F20,
                                    height: 1.25,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              
                              SizedBox(height: 76.h),
                              
                              // Botão Denuncie
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(AppRoutes.denounceScreen);
                                },
                                child: Container(
                                  width: 101.h,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF4F20,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Denuncie',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12.fSize,
                                        fontWeight: FontWeight.w700,
                                        color: appTheme.colorFFF1F1,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 17.h),
                              
                              // Informações de denúncia
                              Container(
                                width: 270.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.h),
                                child: Text(
                                  'Disque Denúncia 181\n(para todo o Brasil)',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12.fSize,
                                    fontWeight: FontWeight.w700,
                                    color: appTheme.colorFF4F20,
                                    height: 1.25,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bottom navigation bar
                Container(
                  width: double.infinity,
                  height: 80.h,
                  color: appTheme.colorFF9FE5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botão Home
                      Container(
                        margin: EdgeInsets.only(left: 25.h),
                        child: Column(
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
                      ),
                      
                      // Botão Cuidados
                      Container(
                        margin: EdgeInsets.only(right: 25.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(AppRoutes.careScreen);
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
                                  Icons.favorite,
                                  color: appTheme.colorFF4F20,
                                  size: 20.h,
                                ),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        ],
      ),
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

  Widget _buildDivider() {
    return Container(
      width: 236.h,
      height: 1,
      color: appTheme.blackCustom,
    );
  }
}