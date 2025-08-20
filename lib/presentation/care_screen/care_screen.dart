import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({super.key});

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
                          // TODO: Implementar menu lateral
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Menu - Em desenvolvimento'),
                              backgroundColor: appTheme.colorFF4F20,
                            ),
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
            
            // Conteúdo dos cuidados
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
                            margin: EdgeInsets.only(left: 16.h),
                            height: 1,
                            color: appTheme.blackCustom,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 40.h),
                    
                    // Lista de serviços de cuidados
                    Column(
                      children: [
                        // ONGs
                        _buildCareItem(
                          'Ongs',
                          'Veja aqui Ongs mais próximas de você.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('ONGs - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Veterinários
                        _buildCareItem(
                          'Veterinários',
                          'Veja aqui Veterinários e especialidades mais próximos de você.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Veterinários - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Petshops
                        _buildCareItem(
                          'Petshops',
                          'Veja aqui PetShops mais próximos de você.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Petshops - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Cuidados básicos
                        _buildCareItem(
                          'Cuidados básicos',
                          'Hora do banho! Veja aqui dicas de cuidados para o seu pet.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cuidados básicos - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Clube do Pet
                        _buildCareItem(
                          'Clube do Pet',
                          'Traga seu amigo para o nosso Clubinho e interaja em locais públicos.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Clube do Pet - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Vacinação
                        _buildCareItem(
                          'Vacinação',
                          'Veja aqui locais de vacinação mais próximos de você.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Vacinação - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Outros
                        _buildCareItem(
                          'Outros',
                          'Outros cuidados e dicas para você e seu pet.',
                          'assets/images/image_not_found.png',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Outros cuidados - Em desenvolvimento'),
                                backgroundColor: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                      ],
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
          ],
        ),
      ),
    );
  }

  Widget _buildCareItem(String title, String description, String imagePath, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: appTheme.colorFF4F20.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Imagem do serviço
            Container(
              width: 74.h,
              height: 74.h,
              decoration: BoxDecoration(
                color: appTheme.grey200,
                shape: BoxShape.circle,
                border: Border.all(color: appTheme.blackCustom, width: 1),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            SizedBox(width: 16.h),
            
            // Informações do serviço
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.fSize,
                      fontWeight: FontWeight.w700,
                      color: appTheme.colorFF4F20,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w400,
                      color: appTheme.colorFF4F20,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            
            // Ícone de seta
            Icon(
              Icons.arrow_forward_ios,
              color: appTheme.colorFF4F20,
              size: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
