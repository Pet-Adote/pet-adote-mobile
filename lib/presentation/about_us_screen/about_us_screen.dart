import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

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
            
            // Conteúdo "Quem Somos"
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    SizedBox(height: 52.h),
                    
                    // Título "Quem Somos"
                    Text(
                      'Quem Somos',
                      style: TextStyleHelper.instance.display55LeckerliOne.copyWith(
                        fontSize: 36.fSize,
                        color: appTheme.colorFF4F20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 26.h),
                    
                    // Linha decorativa
                    Row(
                      children: [
                        Container(
                          width: 70.h,
                          height: 2,
                          color: appTheme.colorFF4F20,
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          width: 70.h,
                          height: 2,
                          color: appTheme.colorFF4F20,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 89.h),
                    
                    // Texto sobre o PetAdote
                    Container(
                      width: 330.h,
                      child: Text(
                        'PetAdote é um aplicativo desenvolvido com o propósito de facilitar o processo de adoção de cães e gatos resgatados. A plataforma conecta diretamente ONGs, protetores independentes e pessoas interessadas em adotar animais, promovendo a adoção responsável e o bem-estar animal.',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15.fSize,
                          fontWeight: FontWeight.w700,
                          color: appTheme.colorFF4F20,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    
                    SizedBox(height: 60.h),
                    
                    // Seção de categorias
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'categorias',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w600,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          
                          // Grid de categorias
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                // Categoria Silvestre
                                Container(
                                  margin: EdgeInsets.only(right: 16.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 74.h,
                                        height: 74.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.grey200,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/image_not_found.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'silvestre',
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
                                
                                // Categoria Exóticos
                                Container(
                                  margin: EdgeInsets.only(right: 16.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 74.h,
                                        height: 74.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.grey200,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/image_not_found.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'exóticos',
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
                                
                                // Categoria Outros
                                Container(
                                  margin: EdgeInsets.only(right: 16.h),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 74.h,
                                        height: 74.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.grey200,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage('assets/images/image_not_found.png'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'outros',
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 60.h),
                    
                    // Seção da equipe
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // Felipe Mendes
                          Container(
                            margin: EdgeInsets.only(bottom: 32.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 112.h,
                                  height: 107.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: appTheme.blackCustom, width: 1),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/image_not_found.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.h),
                                Text(
                                  'Felipe Mendes',
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
                          
                          // Luiz Fellipe
                          Container(
                            margin: EdgeInsets.only(bottom: 32.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 112.h,
                                  height: 107.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: appTheme.blackCustom, width: 1),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/image_not_found.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.h),
                                Text(
                                  'Luiz Fellipe',
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
                          
                          // Filipe Gomes
                          Container(
                            margin: EdgeInsets.only(bottom: 32.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 112.h,
                                  height: 107.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: appTheme.blackCustom, width: 1),
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/image_not_found.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.h),
                                Text(
                                  'Filipe Gomes',
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
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 32.h),
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
