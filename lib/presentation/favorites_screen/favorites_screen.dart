import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../models/pet_model.dart';
import '../../repositories/firebase_favorites_repository.dart';
import '../../widgets/custom_image_view.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool _isMenuOpen = false;
  final FirebaseFavoritesRepository _favoritesRepository = FirebaseFavoritesRepository();
  List<Pet> _favoritePets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoritePets();
  }

  Future<void> _loadFavoritePets() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final pets = await _favoritesRepository.getFavoritePets();
      setState(() {
        _favoritePets = pets;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar favoritos.'),
          backgroundColor: Colors.red,
        ),
      );
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
    // Fechar o menu
    _closeMenu();
    // Mostrar diálogo de confirmação
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

  void _handleDenounce() {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.denounceScreen);
  }

  void _navigateToPetProfile(Pet pet) async {
    final result = await Navigator.of(context).pushNamed(
      AppRoutes.petProfileScreen,
      arguments: pet,
    );
    // Recarregar a lista quando voltar da tela do pet
    if (result != null || mounted) {
      _loadFavoritePets();
    }
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
                      
                      // Logo centralizado
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
                                SizedBox(height: 3.h),
                                Text(
                                  'Perfil',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 8.fSize,
                                    fontWeight: FontWeight.w500,
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
                
                // Título da tela
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.h),
                  child: Text(
                    'Meus Favoritos',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 24.fSize,
                      fontWeight: FontWeight.bold,
                      color: appTheme.colorFF4F20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                // Conteúdo dos favoritos
                Expanded(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: appTheme.colorFF4F20,
                          ),
                        )
                      : _favoritePets.isEmpty
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      size: 80.h,
                                      color: appTheme.colorFF4F20,
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      'Nenhum favorito ainda',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18.fSize,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme.colorFF4F20,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      'Quando você favoritar um pet, ele aparecerá aqui!',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14.fSize,
                                        color: appTheme.grey600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _loadFavoritePets,
                              child: ListView.builder(
                                padding: EdgeInsets.all(20.h),
                                itemCount: _favoritePets.length,
                                itemBuilder: (context, index) {
                                  final pet = _favoritePets[index];
                                  return _buildPetCard(pet);
                                },
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
                      
                      // Botão Cuidados
                      Column(
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
                          
                          // Denúncia
                          _buildMenuItem(
                            'Denúncia',
                            onTap: _handleDenounce,
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

  Widget _buildPetCard(Pet pet) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.h),
      ),
      color: appTheme.whiteCustom,
      child: InkWell(
        onTap: () => _navigateToPetProfile(pet),
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
                  border: Border.all(color: appTheme.colorFF4F20, width: 2),
                  shape: BoxShape.circle,
                ),
                child: (pet.imagePath != null && pet.imagePath!.isNotEmpty)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30.h),
                        child: CustomImageView(
                          imagePath: pet.imagePath!,
                          width: 60.h,
                          height: 60.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.pets,
                        size: 30.h,
                        color: appTheme.colorFF4F20,
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
                      '${pet.speciesDisplayName} • ${pet.gender} • ${pet.age}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.fSize,
                        color: appTheme.grey600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    if (pet.location.isNotEmpty)
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
                                color: appTheme.grey600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              
              // Ícone de favorito e seta
              Column(
                children: [
                  Icon(
                    Icons.favorite,
                    color: appTheme.redCustom,
                    size: 24.h,
                  ),
                  SizedBox(height: 8.h),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: appTheme.colorFF4F20,
                    size: 16.h,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
