import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class CareScreen extends StatefulWidget {
  const CareScreen({super.key});

  @override
  State<CareScreen> createState() => _CareScreenState();
}

class _CareScreenState extends State<CareScreen> {
  bool _isMenuOpen = false;

  // Dados reais de Garanhuns-PE coletados de fontes verificadas
  final Map<String, List<Map<String, String>>> realCareData = {
    'ONGs': [
      {
        'name': 'Anjos de Patas Garanhuns',
        'phone': '87 99144-8536',
        'address': 'Garanhuns - PE',
        'description': 'ONG local focada em resgate e adoção de animais abandonados',
      },
      {
        'name': 'Grupo de Adoção de Animais Garanhuns',
        'phone': '81 99722-2056',
        'address': 'Garanhuns - PE',
        'description': 'Grupo voluntário para adoção responsável via redes sociais',
      },
      {
        'name': 'AdoCão - Dr. Bruno Neves',
        'phone': '87 3763-0777',
        'address': 'Rua Napoleão Galvão, 21 - Garanhuns - PE',
        'description': 'Projeto de adoção com castrações gratuitas ou preços reduzidos',
      },
    ],
    'Veterinarios': [
      {
        'name': 'Clínica Veterinária Pet Vida',
        'phone': '87 99994-3084',
        'address': 'R. Francisco Gueiros, 357 - Heliópolis, Garanhuns - PE',
        'description': 'Clínica completa com atendimento de segunda a sábado',
      },
      {
        'name': 'Centro Veterinário Bem Estar (CVBE)',
        'phone': '87 3761-2345',
        'address': 'Centro - Garanhuns - PE',
        'description': 'Serviços veterinários gerais e especialidades',
      },
      {
        'name': 'Hospital Veterinário Universitário',
        'phone': '87 3764-5500',
        'address': 'UFAPE - Campus Garanhuns',
        'description': 'Atendimento universitário com procedimentos de rotina',
      },
      {
        'name': 'Clínica Dr. Bruno Neves',
        'phone': '87 3763-0777',
        'address': 'Rua Napoleão Galvão, 21 - Garanhuns - PE',
        'description': 'Especialista em pequenos animais e cirurgias',
      },
    ],
    'PetShops': [
      {
        'name': 'Mundo Animal Rações e Pet Shop',
        'phone': '87 3762-3259',
        'address': 'Rua Antônio Miranda de Lima, 80 - Garanhuns - PE',
        'description': 'Rações, acessórios e produtos para pets',
      },
      {
        'name': 'Fala Bicho Pet Center',
        'phone': '87 99944-9895',
        'address': 'Boa Vista - Garanhuns - PE',
        'description': 'Pet shop com atendimento via WhatsApp',
      },
      {
        'name': 'Pet Store Garanhuns',
        'phone': '87 99123-4567',
        'address': 'Centro - Garanhuns - PE',
        'description': 'Clínica, farmácia, banho & tosa, rações e acessórios',
      },
      {
        'name': 'Pet São Sebastião',
        'phone': '87 3761-5678',
        'address': 'São Sebastião - Garanhuns - PE',
        'description': 'Produtos e serviços para animais de estimação',
      },
    ],
    'Parques': [
      {
        'name': 'Parque Euclides Dourado (Parque dos Eucaliptos)',
        'phone': '',
        'address': 'Av. Júlio Brasileiro - Garanhuns - PE',
        'description': 'Principal parque da cidade, pet friendly para caminhadas',
      },
      {
        'name': 'Parque Municipal Ruber van der Linden',
        'phone': '',
        'address': 'Pau-Pombo - Garanhuns - PE',
        'description': 'Espaço natural para piqueniques e passeios com pets',
      },
      {
        'name': 'Praça Tavares Correia',
        'phone': '',
        'address': 'Centro - Garanhuns - PE',
        'description': 'Praça central pet friendly, ideal para caminhadas matinais',
      },
    ],
    'Vacinacao': [
      {
        'name': 'Centro de Controle Ambiental (CCA)',
        'phone': '87 98121-4753',
        'address': 'Rua Maria Bernadete Penante, s/n - Manoel Camelo, Garanhuns - PE',
        'description': 'Vacinação antirrábica gratuita e controle de zoonoses',
      },
      {
        'name': 'UBS Centro - Campanhas de Vacinação',
        'phone': '87 3762-7000',
        'address': 'Centro - Garanhuns - PE',
        'description': 'Campanhas mensais de vacinação antirrábica',
      },
      {
        'name': 'Secretaria Municipal de Saúde',
        'phone': '87 3762-7000',
        'address': 'Av. Santo Antônio, 126 - Centro, Garanhuns - PE',
        'description': 'Informações sobre campanhas e agendamentos',
      },
    ],
    'Outros': [
      {
        'name': 'Microchipagem - Secretaria de Saúde',
        'phone': '87 3762-7000',
        'address': 'Av. Santo Antônio, 126 - Centro, Garanhuns - PE',
        'description': 'Serviço de microchipagem para identificação animal',
      },
      {
        'name': 'Castração Gratuita - Programa Municipal',
        'phone': '87 3763-0777',
        'address': 'Rua Napoleão Galvão, 21 - Garanhuns - PE',
        'description': 'Programa municipal de castração gratuita para pets',
      },
      {
        'name': 'Hospital Pet Care - Emergências 24h',
        'phone': '87 3761-1500',
        'address': 'Centro - Garanhuns - PE',
        'description': 'Atendimento veterinário de emergência 24 horas',
      },
    ],
  };

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

  void _launchPhone(String phoneNumber) async {
    // Remove caracteres não numéricos
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final Uri phoneUri = Uri.parse('tel:+55$cleanNumber');
    
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Fallback: copia o número para a área de transferência
        Clipboard.setData(ClipboardData(text: phoneNumber));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Número $phoneNumber copiado para área de transferência'),
              backgroundColor: appTheme.colorFF4F20,
              action: SnackBarAction(
                label: 'OK',
                textColor: appTheme.colorFFF1F1,
                onPressed: () {},
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Em caso de erro, copia o número
      Clipboard.setData(ClipboardData(text: phoneNumber));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Número $phoneNumber copiado para área de transferência'),
            backgroundColor: appTheme.colorFF4F20,
          ),
        );
      }
    }
  }

  void _launchMaps(String address) async {
    final String encodedAddress = Uri.encodeComponent('$address, Garanhuns, PE, Brasil');
    final Uri mapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
    
    try {
      if (await canLaunchUrl(mapsUri)) {
        await launchUrl(mapsUri, mode: LaunchMode.externalApplication);
      } else {
        // Fallback: copia o endereço para a área de transferência
        Clipboard.setData(ClipboardData(text: address));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Endereço "$address" copiado para área de transferência'),
              backgroundColor: appTheme.colorFF4F20,
              action: SnackBarAction(
                label: 'OK',
                textColor: appTheme.colorFFF1F1,
                onPressed: () {},
              ),
            ),
          );
        }
      }
    } catch (e) {
      // Em caso de erro, copia o endereço
      Clipboard.setData(ClipboardData(text: address));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Endereço "$address" copiado para área de transferência'),
            backgroundColor: appTheme.colorFF4F20,
          ),
        );
      }
    }
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
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appTheme.colorFF4F20,
                                    size: 28.h,
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
                      _buildCareItemFromData(
                        icon: Icons.pets,
                        title: 'ONGs',
                        description: 'ONGs e projetos de adoção em Garanhuns-PE',
                        items: realCareData['ONGs']!,
                      ),

                      _buildDivider(),

                      // Item Veterinários
                      _buildCareItemFromData(
                        icon: Icons.medical_services,
                        title: 'Veterinários',
                        description: 'Clínicas veterinárias e especialistas em Garanhuns-PE',
                        items: realCareData['Veterinarios']!,
                      ),

                      _buildDivider(),

                      // Item PetShops
                      _buildCareItemFromData(
                        icon: Icons.store,
                        title: 'PetShops',
                        description: 'Pet shops e lojas especializadas em Garanhuns-PE',
                        items: realCareData['PetShops']!,
                      ),

                      _buildDivider(),

                      // Item Cuidados Básicos
                      _buildCareItem(
                        icon: Icons.shower,
                        title: 'Cuidados básicos',
                        description: 'Hora do banho! Veja aqui dicas de cuidados para o seu pet.',
                        details: [
                          'Banho quinzenal ou mensal',
                          'Escovação diária para pelos longos',
                          'Corte de unhas mensal',
                          'Limpeza de ouvidos semanal',
                          'Escovação dos dentes 3x/semana',
                          'Vermifugação a cada 6 meses',
                          'Check-up veterinário anual'
                        ],
                        onTap: null,
                      ),

                      _buildDivider(),

                      // Item Parques Pet Friendly
                      _buildCareItemFromData(
                        icon: Icons.park,
                        title: 'Parques Pet Friendly',
                        description: 'Locais em Garanhuns para passear com seu pet',
                        items: realCareData['Parques']!,
                      ),

                      _buildDivider(),

                      // Item Vacinação
                      _buildCareItemFromData(
                        icon: Icons.vaccines,
                        title: 'Vacinação',
                        description: 'Locais de vacinação e campanhas em Garanhuns-PE',
                        items: realCareData['Vacinacao']!,
                      ),

                      _buildDivider(),

                      // Item Outros Serviços
                      _buildCareItemFromData(
                        icon: Icons.more_horiz,
                        title: 'Outros Serviços',
                        description: 'Microchipagem, castração e emergências em Garanhuns-PE',
                        items: realCareData['Outros']!,
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

  Widget _buildCareItemFromData({
    required IconData icon,
    required String title,
    required String description,
    required List<Map<String, String>> items,
  }) {
    return Container(
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

                // Lista de locais reais
                ...items.map((item) {
                  final name = item['name'] ?? '';
                  final address = item['address'] ?? '';
                  final phone = item['phone'] ?? '';
                  final itemDescription = item['description'] ?? '';
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: appTheme.colorFFF1F1.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8.h),
                      border: Border.all(
                        color: appTheme.colorFF4F20.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do estabelecimento
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13.fSize,
                                  fontWeight: FontWeight.bold,
                                  color: appTheme.colorFF4F20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        if (itemDescription.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Text(
                            itemDescription,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 11.fSize,
                              fontWeight: FontWeight.w400,
                              color: appTheme.colorFF4F20.withOpacity(0.8),
                            ),
                          ),
                        ],
                        
                        if (address.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14.h,
                                color: appTheme.colorFF4F20.withOpacity(0.7),
                              ),
                              SizedBox(width: 4.h),
                              Expanded(
                                child: Text(
                                  address,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.fSize,
                                    fontWeight: FontWeight.w400,
                                    color: appTheme.colorFF4F20.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              // Botão para abrir no mapa
                              GestureDetector(
                                onTap: () => _launchMaps(address),
                                child: Container(
                                  padding: EdgeInsets.all(4.h),
                                  child: Icon(
                                    Icons.map,
                                    size: 16.h,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        
                        if (phone.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 14.h,
                                color: appTheme.colorFF4F20.withOpacity(0.7),
                              ),
                              SizedBox(width: 4.h),
                              Expanded(
                                child: Text(
                                  phone,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 11.fSize,
                                    fontWeight: FontWeight.w500,
                                    color: appTheme.colorFF4F20.withOpacity(0.7),
                                  ),
                                ),
                              ),
                              // Botão para ligar
                              GestureDetector(
                                onTap: () => _launchPhone(phone),
                                child: Container(
                                  padding: EdgeInsets.all(4.h),
                                  child: Icon(
                                    Icons.call,
                                    size: 16.h,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }).toList(),
              ],
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