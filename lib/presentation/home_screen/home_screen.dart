import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    // Fechar o menu
    _closeMenu();
    // Navegar para a tela de perfil onde está o logout
    Navigator.of(context).pushNamed(AppRoutes.profileScreen);
  }

  void _handleFavorites() {
    _closeMenu();
    // TODO: Implementar navegação para favoritos
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Favoritos - Em desenvolvimento')),
    );
  }

  void _handleAboutUs() {
    _closeMenu();
    // TODO: Implementar navegação para "Quem Somos"
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Quem Somos - Em desenvolvimento')),
    );
  }

  void _handleFAQ() {
    _closeMenu();
    // TODO: Implementar navegação para FAQ
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('FAQ - Em desenvolvimento')),
    );
  }

  void _handleDogsCategory() {
    Navigator.of(context).pushNamed(AppRoutes.dogsScreen);
  }

  void _handleCatsCategory() {
    Navigator.of(context).pushNamed(AppRoutes.catsScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: Stack(
        children: [
          // Conteúdo principal
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
                      // Menu hambúrguer
                      Container(
                        margin: EdgeInsets.only(left: 22.h),
                        child: GestureDetector(
                          onTap: _toggleMenu,
                          child: Container(
                            width: 40.h,
                            height: 34.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 40.h,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF4F20,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  width: 40.h,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF4F20,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  width: 40.h,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF4F20,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
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
                
                // Imagem de banner
                Container(
                  width: double.infinity,
                  height: 157.h,
                  margin: EdgeInsets.only(top: 8.h),
                  decoration: BoxDecoration(
                    color: appTheme.colorFF9FE5,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.pets,
                      size: 80.h,
                      color: appTheme.colorFF4F20,
                    ),
                  ),
                ),
                
                // Seção de categorias
                Padding(
                  padding: EdgeInsets.only(top: 32.h, left: 27.h, right: 27.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título "Categorias"
                      Row(
                        children: [
                          Text(
                            'Categorias',
                            style: TextStyle(
                              fontFamily: 'Coiny',
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.w400,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 16.h),
                              height: 1,
                              color: appTheme.blackCustom,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 32.h),
                      
                      // Grid de categorias
                      Row(
                        children: [
                          // Categoria Gatos
                          Expanded(
                            child: GestureDetector(
                              onTap: _handleCatsCategory,
                              child: Container(
                                height: 140.h,
                                child: Column(
                                  children: [
                                    // Círculo com imagem
                                    Container(
                                      width: 108.h,
                                      height: 109.h,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteCustom,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: appTheme.blackCustom, width: 1),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.pets,
                                          size: 50.h,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Gatos',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15.fSize,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme.colorFF4F20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(width: 16.h),
                          
                          // Categoria Cachorros
                          Expanded(
                            child: GestureDetector(
                              onTap: _handleDogsCategory,
                              child: Container(
                                height: 140.h,
                                child: Column(
                                  children: [
                                    // Círculo com imagem
                                    Container(
                                      width: 112.h,
                                      height: 107.h,
                                      decoration: BoxDecoration(
                                        color: appTheme.whiteCustom,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: appTheme.blackCustom, width: 1),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.pets,
                                          size: 50.h,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Cachorros',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15.fSize,
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
                    ],
                  ),
                ),
                
                // Espaço restante
                Expanded(child: SizedBox()),
                
                // Bottom navigation bar
                Container(
                  width: double.infinity,
                  height: 80.h,
                  color: appTheme.colorFF9FE5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botão Home
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
                              Icons.home,
                              color: appTheme.colorFF9FE5,
                              size: 20.h,
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
                      
                      // Botão Cuidados
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
              ],
            ),
          ),
          
          // Menu lateral
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
