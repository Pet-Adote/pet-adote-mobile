import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

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
            
            // Conteúdo FAQ
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    
                    // Título "FAQ"
                    Row(
                      children: [
                        Text(
                          'FAQ',
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
                    
                    SizedBox(height: 83.h),
                    
                    // Seção "Fale conosco"
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // Botão "Fale conosco"
                          Container(
                            width: 101.h,
                            height: 33.h,
                            decoration: BoxDecoration(
                              color: appTheme.colorFF4F20,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Fale conosco',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.fSize,
                                  fontWeight: FontWeight.w700,
                                  color: appTheme.colorFFF1F1,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // Informações de contato
                          Container(
                            width: 270.h,
                            child: Text(
                              'Central de Atendimento do PetAdote:\n0800 4241-0758 (para todo o Brasil)\n0800 5587-4768 (para deficientes auditivos)',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.fSize,
                                fontWeight: FontWeight.w700,
                                color: appTheme.colorFF4F20,
                                height: 1.25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 32.h),
                    
                    // Seção "Denuncie"
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // Botão "Denuncie"
                          Container(
                            width: 101.h,
                            height: 33.h,
                            decoration: BoxDecoration(
                              color: appTheme.colorFF4F20,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Denuncie',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.fSize,
                                  fontWeight: FontWeight.w700,
                                  color: appTheme.colorFFF1F1,
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // Informações de denúncia
                          Container(
                            width: 270.h,
                            child: Text(
                              'Disque Denúncia 181\n(para todo o Brasil)',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.fSize,
                                fontWeight: FontWeight.w700,
                                color: appTheme.colorFF4F20,
                                height: 1.25,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.25),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 32.h),
                    
                    // Seção de perguntas frequentes
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Perguntas Frequentes',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.fSize,
                              fontWeight: FontWeight.w700,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // FAQ Item 1
                          _buildFaqItem(
                            'Como funciona o processo de adoção?',
                            'O processo de adoção é simples: escolha um pet, entre em contato com o protetor responsável e agende uma visita para conhecer o animal.',
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // FAQ Item 2
                          _buildFaqItem(
                            'Preciso pagar para adotar?',
                            'Não! A adoção é gratuita. Apenas alguns protetores podem cobrar uma taxa simbólica para cobrir custos de vacinação e castração.',
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // FAQ Item 3
                          _buildFaqItem(
                            'Posso devolver o pet se não me adaptar?',
                            'Sim, mas recomendamos que você pense bem antes de adotar. Se necessário, entre em contato conosco para orientação.',
                          ),
                          
                          SizedBox(height: 16.h),
                          
                          // FAQ Item 4
                          _buildFaqItem(
                            'Como posso ajudar os protetores?',
                            'Você pode doar ração, medicamentos, fazer trabalho voluntário ou contribuir financeiramente para as ONGs parceiras.',
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

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: appTheme.colorFF4F20.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.fSize,
              fontWeight: FontWeight.w600,
              color: appTheme.colorFF4F20,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            answer,
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
    );
  }
}
