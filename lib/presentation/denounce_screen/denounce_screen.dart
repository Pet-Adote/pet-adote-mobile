import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class DenounceScreen extends StatefulWidget {
  const DenounceScreen({super.key});

  @override
  State<DenounceScreen> createState() => _DenounceScreenState();
}

class _DenounceScreenState extends State<DenounceScreen> {
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

  // Função para fazer ligação telefônica
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível fazer a ligação'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
  }

  // Função para enviar email
  void _sendEmail(String email, String subject) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
      },
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir o email'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
  }

  // Função para abrir WhatsApp
  void _openWhatsApp(String phoneNumber, String message) async {
    final Uri launchUri = Uri.parse('https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}');
    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não foi possível abrir o WhatsApp'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
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
                            'Canais de Denúncia',
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
                        
                        SizedBox(height: 30.h),
                        
                        // Subtítulo
                        Center(
                          child: Text(
                            'Proteja os animais contra\nmaus-tratos e abandono',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.fSize,
                              fontWeight: FontWeight.w600,
                              color: appTheme.colorFF4F20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Cards de denúncia
                        _buildDenounceCard(
                          icon: Icons.local_police,
                          title: 'Polícia Militar',
                          subtitle: 'Emergências e ocorrências',
                          contact: '190',
                          description: 'Para situações de emergência envolvendo maus-tratos ou abandono de animais',
                          onTap: () => _makePhoneCall('190'),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        _buildDenounceCard(
                          icon: Icons.phone,
                          title: 'Disque Denúncia',
                          subtitle: 'Denúncias anônimas',
                          contact: '181',
                          description: 'Canal gratuito para denúncias anônimas de crimes contra animais',
                          onTap: () => _makePhoneCall('181'),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        _buildDenounceCard(
                          icon: Icons.pets,
                          title: 'PetAdote',
                          subtitle: 'Suporte e orientação',
                          contact: 'denuncia@petadote.com',
                          description: 'Entre em contato conosco para orientações sobre denúncias',
                          onTap: () => _sendEmail('denuncia@petadote.com', 'Denúncia de Maus-tratos'),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        _buildDenounceCard(
                          icon: Icons.message,
                          title: 'WhatsApp Denúncia',
                          subtitle: 'Canal direto',
                          contact: '+55 11 99999-9999',
                          description: 'Envie sua denúncia com fotos e localização via WhatsApp',
                          onTap: () => _openWhatsApp('5511999999999', 'Gostaria de fazer uma denúncia sobre maus-tratos de animais.'),
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Seção de informações importantes
                        Container(
                          padding: EdgeInsets.all(20.h),
                          decoration: BoxDecoration(
                            color: appTheme.colorFF9FE5.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: appTheme.colorFF4F20, width: 1),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: appTheme.colorFF4F20,
                                    size: 24.h,
                                  ),
                                  SizedBox(width: 10.h),
                                  Text(
                                    'Informações Importantes',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      fontWeight: FontWeight.bold,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 15.h),
                              
                              _buildInfoItem('• Maus-tratos a animais é crime (Lei 9.605/98)'),
                              _buildInfoItem('• Abandono de animais é crime'),
                              _buildInfoItem('• Mantenha evidências: fotos, vídeos, localização'),
                              _buildInfoItem('• Procure testemunhas quando possível'),
                              _buildInfoItem('• Denúncias podem ser feitas anonimamente'),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Botão de voltar
                        Center(
                          child: Container(
                            width: 150.h,
                            height: 45.h,
                            decoration: BoxDecoration(
                              color: appTheme.colorFF4F20,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(8),
                                child: Center(
                                  child: Text(
                                    'Voltar',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      fontWeight: FontWeight.w600,
                                      color: appTheme.colorFFF1F1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 40.h),
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

  Widget _buildDenounceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String contact,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: appTheme.colorFF4F20, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.h,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: appTheme.colorFF9FE5,
                        shape: BoxShape.circle,
                        border: Border.all(color: appTheme.colorFF4F20, width: 2),
                      ),
                      child: Icon(
                        icon,
                        color: appTheme.colorFF4F20,
                        size: 24.h,
                      ),
                    ),
                    SizedBox(width: 15.h),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.bold,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.fSize,
                              color: appTheme.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: appTheme.colorFF4F20,
                      size: 16.h,
                    ),
                  ],
                ),
                
                SizedBox(height: 15.h),
                
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color: appTheme.colorFF9FE5.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    contact,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.bold,
                      color: appTheme.colorFF4F20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                SizedBox(height: 10.h),
                
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.fSize,
                    color: appTheme.blackCustom,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.fSize,
          color: appTheme.colorFF4F20,
          height: 1.4,
        ),
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