import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: SafeArea(
        child: Column(
          children: [
            // Header verde
            Container(
              width: double.infinity,
              height: 113.h,
              color: appTheme.colorFF9FE5,
              child: Row(
                children: [
                  // Botão voltar (menu hambúrguer)
                  Container(
                    margin: EdgeInsets.only(left: 30.h),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
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
            
            // Conteúdo dos favoritos
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    
                    // Título "Favoritos"
                    Row(
                      children: [
                        Text(
                          'Favoritos',
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
                    
                    // Lista de favoritos
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Card do pet favorito
                            Container(
                              width: double.infinity,
                              height: 200.h,
                              margin: EdgeInsets.only(bottom: 16.h),
                              decoration: BoxDecoration(
                                color: appTheme.whiteCustom,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  // Imagem do pet
                                  Positioned(
                                    left: 9.11.h,
                                    top: 21.17.h,
                                    child: Container(
                                      width: 130.h,
                                      height: 130.h,
                                      decoration: BoxDecoration(
                                        color: appTheme.grey200,
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/image_not_found.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Informações do pet
                                  Positioned(
                                    left: 150.h,
                                    top: 30.h,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pantera',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15.fSize,
                                            fontWeight: FontWeight.w700,
                                            color: appTheme.blackCustom,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          '2 anos',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 10.fSize,
                                            fontWeight: FontWeight.w400,
                                            color: appTheme.blackCustom,
                                          ),
                                        ),
                                        SizedBox(height: 16.h),
                                        Text(
                                          'Gato preto muito carinhoso',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 12.fSize,
                                            color: appTheme.colorFF4F20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Botão de favorito
                                  Positioned(
                                    right: 16.h,
                                    top: 16.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        // TODO: Implementar remoção dos favoritos
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Removido dos favoritos'),
                                            backgroundColor: appTheme.colorFF4F20,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 24.h,
                                        height: 24.h,
                                        child: Icon(
                                          Icons.favorite,
                                          color: appTheme.colorFF4F20,
                                          size: 24.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Mensagem quando não há favoritos
                            if (false) // Alterar para true quando não há favoritos
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite_border,
                                      size: 80.h,
                                      color: appTheme.colorFF4F20,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      'Nenhum pet favoritado',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18.fSize,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme.colorFF4F20,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      'Adicione pets aos seus favoritos',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14.fSize,
                                        color: appTheme.grey600,
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
    );
  }
}
