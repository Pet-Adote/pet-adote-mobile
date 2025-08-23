import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../models/pet_model.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  bool _isFavorited = false;
  Pet? pet;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Obter os dados do Pet passados como argumentos
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Pet) {
      pet = arguments;
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  void _shareOnWhatsApp() {
    if (pet == null) return;
    
    // Usar o método do modelo Pet para gerar a mensagem
    final petInfo = pet!.generateWhatsAppMessage();

    // Simular compartilhamento
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Informações copiadas! Compartilhe no WhatsApp'),
        backgroundColor: appTheme.greenCustom,
        action: SnackBarAction(
          label: 'Copiar',
          textColor: appTheme.whiteCustom,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: petInfo));
          },
        ),
      ),
    );
  }

  void _goToCategory() {
    if (pet?.species == 'dogs') {
      Navigator.of(context).pushNamed(AppRoutes.dogsScreen);
    } else {
      Navigator.of(context).pushNamed(AppRoutes.catsScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Se não há dados do Pet, mostrar tela de carregamento ou erro
    if (pet == null) {
      return Scaffold(
        backgroundColor: appTheme.colorFFF1F1,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 80.h,
                color: appTheme.colorFF4F20,
              ),
              SizedBox(height: 16.h),
              Text(
                'Erro ao carregar informações do pet',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16.fSize,
                  color: appTheme.colorFF4F20,
                ),
              ),
              SizedBox(height: 24.h),
              CustomButton(
                text: 'Voltar',
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: appTheme.colorFF9FE5,
                textColor: appTheme.colorFF4F20,
                height: 40.h,
                width: 120.h,
              ),
            ],
          ),
        ),
      );
    }
    
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
                  
                  Expanded(child: SizedBox()),
                  
                  // Ícone de perfil
                  Container(
                    margin: EdgeInsets.only(right: 22.h),
                    width: 49.h,
                    height: 64.h,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.profileScreen);
                      },
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
                ],
              ),
            ),
            
            // Conteúdo principal
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 22.h),
                      
                      // Título "Perfil" com linha
                      Row(
                        children: [
                          Text(
                            'Perfil',
                            style: TextStyle(
                              fontFamily: 'Coiny',
                              fontSize: 18.fSize,
                              fontWeight: FontWeight.w400,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(width: 24.h),
                          Expanded(
                            child: Container(
                              height: 1.h,
                              color: appTheme.blackCustom,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 26.h),
                      
                      // Foto do pet e botão favoritar
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              width: 131.86.h,
                              height: 134.98.h,
                              decoration: BoxDecoration(
                                color: appTheme.whiteCustom,
                                border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(65.93.h),
                                child: Container(
                                  width: 127.h,
                                  height: 130.h,
                                  child: Icon(
                                    Icons.pets,
                                    size: 80.h,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Botão favoritar
                          Positioned(
                            right: 39.h,
                            top: 12.h,
                            child: GestureDetector(
                              onTap: _toggleFavorite,
                              child: Container(
                                width: 24.h,
                                height: 24.h,
                                child: Icon(
                                  _isFavorited ? Icons.favorite : Icons.favorite_border,
                                  color: _isFavorited ? appTheme.redCustom : appTheme.blackCustom,
                                  size: 24.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Nome do pet
                      Center(
                        child: Text(
                          pet!.name.toUpperCase(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18.fSize,
                            fontWeight: FontWeight.w900,
                            color: appTheme.blackCustom,
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 25.h),
                      
                      // Seção de informações do responsável e contato
                      Row(
                        children: [
                          // Nome Responsável
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome Responsável:',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15.fSize,
                                  fontWeight: FontWeight.w800,
                                  color: appTheme.colorFF4F20,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                width: 164.h,
                                height: 26.h,
                                decoration: BoxDecoration(
                                  color: appTheme.colorFFF1F1,
                                  border: Border.all(color: appTheme.colorFF4F20),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    pet!.responsibleName,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15.fSize,
                                      fontWeight: FontWeight.w600,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(width: 16.h),
                          
                          // Telefone
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Telefone (Zap):',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15.fSize,
                                    fontWeight: FontWeight.w800,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Container(
                                  width: 160.h,
                                  height: 26.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFFF1F1,
                                    border: Border.all(color: appTheme.colorFF4F20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      pet!.phone,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 15.fSize,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme.colorFF4F20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 25.h),
                      
                      // Seção de selos (espécie, vacina, idade, sexo)
                      Column(
                        children: [
                          // Primeira linha: Espécie e Vacina
                          Row(
                            children: [
                              // Espécie
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Espécie:',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15.fSize,
                                      fontWeight: FontWeight.w800,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    width: 78.h,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFFF1F1,
                                      border: Border.all(color: appTheme.colorFF4F20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        pet!.speciesDisplayName,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15.fSize,
                                          fontWeight: FontWeight.w600,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(width: 24.h),
                              
                              // Vacina
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Vacina?',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15.fSize,
                                      fontWeight: FontWeight.w800,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    width: 78.h,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFFF1F1,
                                      border: Border.all(color: appTheme.colorFF4F20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        pet!.vaccinationStatus,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15.fSize,
                                          fontWeight: FontWeight.w600,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(width: 24.h),
                              
                              // Sexo
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sexo:',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15.fSize,
                                      fontWeight: FontWeight.w800,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    width: 78.h,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFFF1F1,
                                      border: Border.all(color: appTheme.colorFF4F20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        pet!.gender,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15.fSize,
                                          fontWeight: FontWeight.w600,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(height: 15.h),
                          
                          // Segunda linha: Idade
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Idade:',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 15.fSize,
                                      fontWeight: FontWeight.w800,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Container(
                                    width: 74.h,
                                    height: 26.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFFF1F1,
                                      border: Border.all(color: appTheme.colorFF4F20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        pet!.age,
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 15.fSize,
                                          fontWeight: FontWeight.w600,
                                          color: appTheme.colorFF4F20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 30.h),
                      
                      // Caixa de descrição
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        decoration: BoxDecoration(
                          color: appTheme.whiteCustom,
                          border: Border.all(color: appTheme.colorFF4F20, width: 3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sobre o ${pet!.name}',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18.fSize,
                                  fontWeight: FontWeight.w700,
                                  color: appTheme.blackCustom,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                pet!.description.isNotEmpty 
                                    ? pet!.description 
                                    : 'Sem descrição disponível.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 15.fSize,
                                  fontWeight: FontWeight.w500,
                                  color: appTheme.blackCustom,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Localização
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pet!.location.isNotEmpty 
                                      ? pet!.location 
                                      : 'Localização não informada',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15.fSize,
                                    fontWeight: FontWeight.w500,
                                    color: appTheme.blackCustom,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 40.h,
                            height: 40.h,
                            child: Icon(
                              Icons.location_on,
                              color: appTheme.colorFF4F20,
                              size: 40.h,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 20.h),
                      
                      // Botão "Ir para categoria"
                      Center(
                        child: CustomButton(
                          text: pet!.species == 'dogs' ? 'IR PARA CACHORROS' : 'IR PARA GATOS',
                          onPressed: _goToCategory,
                          backgroundColor: appTheme.colorFF9FE5,
                          textColor: appTheme.colorFF4F20,
                          height: 50.h,
                          width: 250.h,
                          fontSize: 20.fSize,
                          fontWeight: FontWeight.w600,
                          borderRadius: 0,
                          elevation: 4.h,
                          shadowColor: appTheme.blackCustom.withOpacity(0.25),
                        ),
                      ),
                      
                      SizedBox(height: 15.h),
                      
                      // Ícone do WhatsApp (simulando imagem)
                      Center(
                        child: GestureDetector(
                          onTap: _shareOnWhatsApp,
                          child: Container(
                            width: 154.h,
                            height: 57.h,
                            decoration: BoxDecoration(
                              color: Color(0xFF25D366), // Cor do WhatsApp
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                  size: 24.h,
                                ),
                                SizedBox(width: 8.h),
                                Text(
                                  'Compartilhar',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.fSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 40.h),
                    ],
                  ),
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
                  
                  // Espaçamento central
                  Expanded(child: SizedBox()),
                  
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