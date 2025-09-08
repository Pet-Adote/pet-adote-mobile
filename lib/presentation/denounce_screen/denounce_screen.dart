import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';

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

  // Mostrar diálogo com canais públicos
  void _showPublicChannelsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: appTheme.colorFFF1F1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Canais Públicos',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.fSize,
                  fontWeight: FontWeight.bold,
                  color: appTheme.colorFF4F20,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close,
                  color: appTheme.colorFF4F20,
                  size: 24.h,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogOption(
                title: 'Polícia Militar - 190',
                description: 'Emergências e ocorrências',
                onTap: () {
                  Navigator.of(context).pop();
                  _makePhoneCall('190');
                },
              ),
              SizedBox(height: 10.h),
              _buildDialogOption(
                title: 'Disque Denúncia - 181',
                description: 'Denúncias anônimas',
                onTap: () {
                  Navigator.of(context).pop();
                  _makePhoneCall('181');
                },
              ),
              SizedBox(height: 10.h),
              _buildDialogOption(
                title: 'WhatsApp Denúncia',
                description: 'Canal direto',
                onTap: () {
                  Navigator.of(context).pop();
                  _openWhatsApp('5511999999999', 'Gostaria de fazer uma denúncia sobre maus-tratos de animais.');
                },
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.fSize,
                      color: appTheme.grey600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.colorFF4F20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                  ),
                  child: Text(
                    'Fechar',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16.fSize,
                      fontWeight: FontWeight.w600,
                      color: appTheme.whiteCustom,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
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
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(20.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFF9FE5,
                                    borderRadius: BorderRadius.circular(20.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appTheme.colorFF4F20,
                                    size: 24.h,
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
                              child: InkWell(
                                onTap: _toggleMenu,
                                borderRadius: BorderRadius.circular(8.h),
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
                                          borderRadius: BorderRadius.circular(4.h),
                                        ),
                                      ),
                                      Container(
                                        width: 40.h,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(4.h),
                                        ),
                                      ),
                                      Container(
                                        width: 40.h,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(4.h),
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
                        
                        // Botões de denúncia
                        _buildDenounceButton(
                          title: 'Denuncie a partir de meios públicos',
                          description: 'Polícia, Disque Denúncia e outros canais oficiais',
                          icon: Icons.local_police,
                          onTap: () {
                            // Mostrar diálogo com opções de meios públicos
                            _showPublicChannelsDialog();
                          },
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        _buildDenounceButton(
                          title: 'Denuncie a partir do PetAdote',
                          description: 'Formule sua denúncia através do nosso aplicativo',
                          icon: Icons.pets,
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.appDenounceScreen);
                          },
                        ),
                        
                        SizedBox(height: 30.h),
                        
                        // Seção de informações importantes
                        Container(
                          padding: EdgeInsets.all(20.h),
                          decoration: BoxDecoration(
                            color: appTheme.colorFF9FE5.withValues(alpha: 0.3),
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
                color: Colors.black.withValues(alpha: 0.3),
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
                    color: Colors.black.withValues(alpha: 0.25),
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
                              color: Colors.black.withValues(alpha: 0.25),
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

  Widget _buildDenounceButton({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appTheme.colorFF4F20,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Row(
              children: [
                Container(
                  width: 45.h,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: appTheme.whiteCustom,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: appTheme.colorFF4F20,
                    size: 22.h,
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.fSize,
                          fontWeight: FontWeight.bold,
                          color: appTheme.whiteCustom,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 11.fSize,
                          color: appTheme.whiteCustom.withValues(alpha: 0.8),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.h),
                Icon(
                  Icons.arrow_forward,
                  color: appTheme.whiteCustom,
                  size: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogOption({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appTheme.colorFF4F20, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.fSize,
                    fontWeight: FontWeight.bold,
                    color: appTheme.colorFF4F20,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.fSize,
                    color: appTheme.grey600,
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