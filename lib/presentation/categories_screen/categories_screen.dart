import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class CategoriesScreen extends StatelessWidget {
  final String categoryTitle;
  final String categoryType; // 'dogs' ou 'cats'

  const CategoriesScreen({
    super.key,
    required this.categoryTitle,
    required this.categoryType,
  });

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
                  // Menu hambúrguer
                  Container(
                    margin: EdgeInsets.only(left: 30.h),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Aqui você pode implementar o menu lateral se necessário
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Menu - Em desenvolvimento')),
                          );
                        },
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
                    categoryType == 'dogs' ? 'Cachorros' : 'Gatos',
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
                      'Encontre seu ${categoryType == 'dogs' ? 'cão' : 'gato'} ideal',
                      style: TextStyleHelper.instance.title20RegularRoboto.copyWith(
                        fontSize: 24.fSize,
                        color: appTheme.colorFF4F20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Aqui você encontrará ${categoryType == 'dogs' ? 'cães' : 'gatos'} disponíveis para adoção.',
                      style: TextStyleHelper.instance.body15MediumInter.copyWith(
                        fontSize: 16.fSize,
                        color: appTheme.colorFF4F20,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    
                    // Lista de animais (placeholder)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              categoryType == 'dogs' ? Icons.pets : Icons.pets,
                              size: 80.h,
                              color: appTheme.colorFF4F20,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Em breve: Lista de ${categoryType == 'dogs' ? 'cães' : 'gatos'}',
                              style: TextStyleHelper.instance.body15MediumInter.copyWith(
                                fontSize: 18.fSize,
                                color: appTheme.colorFF4F20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Funcionalidade em desenvolvimento',
                              style: TextStyleHelper.instance.body15MediumInter.copyWith(
                                fontSize: 14.fSize,
                                color: appTheme.grey600,
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
    );
  }
}
