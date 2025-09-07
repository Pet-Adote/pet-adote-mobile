import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../models/pet_model.dart';
import '../../repositories/firebase_pet_repository.dart';

class CategoriesScreen extends StatefulWidget {
  final String categoryTitle;
  final String categoryType; // 'dogs' ou 'cats'

  const CategoriesScreen({
    super.key,
    required this.categoryTitle,
    required this.categoryType,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isMenuOpen = false;
  List<Pet> _pets = [];
  bool _isLoading = true;
  final FirebasePetRepository _firebasePetRepository = FirebasePetRepository();

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    try {
      final pets = await _firebasePetRepository.getPetsBySpecies(widget.categoryType);
      setState(() {
        _pets = pets;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar pets: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
                  // Menu hambúrguer
                  Container(
                    margin: EdgeInsets.only(left: 22.h),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _toggleMenu,
                        borderRadius: BorderRadius.circular(8),
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
                  ),
                  
                  Expanded(
                    child: Container(), // Espaço central vazio
                  ),
                  
                  // Botão Perfil
                  Container(
                    margin: EdgeInsets.only(right: 30.h),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.profileScreen);
                      },
                      child: Container(
                        width: 49.h,
                        height: 64.h,
                        decoration: BoxDecoration(
                          color: appTheme.colorFF9FE5,
                          border: Border.all(color: appTheme.colorFF4F20, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person,
                              color: appTheme.colorFF4F20,
                              size: 24.h,
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
            
            // Título da categoria com linha divisória
            Container(
              padding: EdgeInsets.only(left: 9.h, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.categoryType == 'dogs' ? 'Cachorros' : 'Gatos',
                    style: TextStyle(
                      fontFamily: 'Coiny',
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w400,
                      color: appTheme.colorFF4F20,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: 246.h,
                    height: 1.h,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            
            // Conteúdo da categoria
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Encontre seu ${widget.categoryType == 'dogs' ? 'cão' : 'gato'} ideal',
                      style: TextStyleHelper.instance.title20RegularRoboto.copyWith(
                        fontSize: 24.fSize,
                        color: appTheme.colorFF4F20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Aqui você encontrará ${widget.categoryType == 'dogs' ? 'cães' : 'gatos'} disponíveis para adoção.',
                      style: TextStyleHelper.instance.body15MediumInter.copyWith(
                        fontSize: 16.fSize,
                        color: appTheme.colorFF4F20,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    
                    // Lista de pets
                    Expanded(
                      child: _isLoading 
                        ? Center(
                            child: CircularProgressIndicator(
                              color: appTheme.colorFF4F20,
                            ),
                          )
                        : _pets.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    widget.categoryType == 'dogs' ? Icons.pets : Icons.pets,
                                    size: 80.h,
                                    color: appTheme.colorFF4F20,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Nenhum ${widget.categoryType == 'dogs' ? 'cão' : 'gato'} disponível',
                                    style: TextStyleHelper.instance.body15MediumInter.copyWith(
                                      fontSize: 18.fSize,
                                      color: appTheme.colorFF4F20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Cadastre um pet para vê-lo aqui',
                                    style: TextStyleHelper.instance.body15MediumInter.copyWith(
                                      fontSize: 14.fSize,
                                      color: appTheme.grey600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _loadPets,
                              color: appTheme.colorFF4F20,
                              child: ListView.builder(
                                itemCount: _pets.length,
                                itemBuilder: (context, index) {
                                final pet = _pets[index];
                                return Card(
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  color: appTheme.whiteCustom,
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.h),
                                    side: BorderSide(
                                      color: appTheme.colorFF4F20,
                                      width: 2,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.petProfileScreen,
                                        arguments: pet,
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(12.h),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.h),
                                      child: Row(
                                        children: [
                                          // Avatar do pet
                                          Container(
                                            width: 60.h,
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                              color: appTheme.colorFF9FE5,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: appTheme.colorFF4F20,
                                                width: 2,
                                              ),
                                            ),
                                            child: Icon(
                                              pet.species == 'dogs' ? Icons.pets : Icons.pets,
                                              color: appTheme.colorFF4F20,
                                              size: 30.h,
                                            ),
                                          ),
                                          SizedBox(width: 16.h),
                                          
                                          // Informações do pet
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  pet.name,
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 18.fSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: appTheme.colorFF4F20,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  '${pet.genderDisplayName} • ${pet.age}',
                                                  style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14.fSize,
                                                    color: appTheme.grey600,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 16.h,
                                                      color: appTheme.colorFF4F20,
                                                    ),
                                                    SizedBox(width: 4.h),
                                                    Expanded(
                                                      child: Text(
                                                        pet.location,
                                                        style: TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 12.fSize,
                                                          color: appTheme.colorFF4F20,
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          
                                          // Seta
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: appTheme.colorFF4F20,
                                            size: 16.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                },
                              ),
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
                  
                  // Botão Adicionar (central)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.addPetScreen);
                        },
                        child: Container(
                          width: 51.h,
                          height: 51.h,
                          decoration: BoxDecoration(
                            color: appTheme.colorFF4F20,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: appTheme.colorFF9FE5,
                            size: 24.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Adicionar',
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
                            width: 51.h,
                            height: 61.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Ícone de cuidados (simplificado)
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
                              ],
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
