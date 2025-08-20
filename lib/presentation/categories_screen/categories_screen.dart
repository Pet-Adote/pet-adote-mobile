import 'package:flutter/material.dart';

import '../../core/app_export.dart';

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
            // Header
            Container(
              width: double.infinity,
              height: 113.h,
              color: appTheme.colorFF9FE5,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: appTheme.colorFF4F20, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        categoryTitle,
                        style: TextStyleHelper.instance.display55LeckerliOne.copyWith(
                          fontSize: 28.fSize,
                          color: appTheme.colorFF4F20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 56.h), // Espaço para balancear o layout
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
