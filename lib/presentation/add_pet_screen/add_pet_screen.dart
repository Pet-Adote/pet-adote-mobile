import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../models/pet_model.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _responsibleNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedSpecies = 'dogs'; // dogs ou cats
  String _selectedGender = 'F'; // F ou M
  bool _isVaccinated = false;

  @override
  void dispose() {
    _petNameController.dispose();
    _locationController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    _responsibleNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleAddPhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Adicionar foto - Em desenvolvimento'),
        backgroundColor: appTheme.colorFF4F20,
      ),
    );
  }

  void _handleRegisterPet() {
    // Validação básica
    if (_petNameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _responsibleNameController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    // Criar objeto Pet com os dados do formulário
    final pet = Pet(
      name: _petNameController.text.trim(),
      location: _locationController.text.trim(),
      age: _ageController.text.trim(),
      species: _selectedSpecies,
      gender: _selectedGender,
      isVaccinated: _isVaccinated,
      description: _descriptionController.text.trim(),
      responsibleName: _responsibleNameController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    // Aqui seria implementada a lógica de cadastro do pet (salvar no banco, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pet cadastrado com sucesso!'),
        backgroundColor: appTheme.greenCustom,
      ),
    );
    
    // Navegar para a tela do perfil do pet passando os dados
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.petProfileScreen, 
      arguments: pet,
    );
  }

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
                      child: Container(
                        width: 87.h,
                        height: 58.h,
                        child: Center(
                          child: Text(
                            'PetAdote',
                            style: TextStyleHelper.instance.display55LeckerliOne.copyWith(
                              fontSize: 20.fSize,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
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
                  padding: EdgeInsets.symmetric(horizontal: 32.h),
                  child: Column(
                    children: [
                      SizedBox(height: 25.h),
                      
                      // Foto do pet
                      Column(
                        children: [
                          GestureDetector(
                            onTap: _handleAddPhoto,
                            child: Container(
                              width: 123.h,
                              height: 121.h,
                              decoration: BoxDecoration(
                                color: appTheme.whiteCustom,
                                border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 65.h,
                                  color: appTheme.colorFF4F20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 13.h),
                          Text(
                            'ADICIONAR FOTO',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w600,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 30.h),
                      
                      // Nome do Animal
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome do Animal:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w800,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          CustomTextField(
                            controller: _petNameController,
                            height: 26.h,
                            backgroundColor: appTheme.colorFFF1F1,
                            borderColor: appTheme.colorFF4F20,
                            focusBorderColor: appTheme.colorFF4F20,
                            borderRadius: 10,
                            fontSize: 14.fSize,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Localização
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Localização:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w800,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          CustomTextField(
                            controller: _locationController,
                            height: 26.h,
                            backgroundColor: appTheme.colorFFF1F1,
                            borderColor: appTheme.colorFF4F20,
                            focusBorderColor: appTheme.colorFF4F20,
                            borderRadius: 10,
                            fontSize: 14.fSize,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Idade e Espécie
                      Row(
                        children: [
                          Expanded(
                            child: Column(
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
                                CustomTextField(
                                  controller: _ageController,
                                  height: 26.h,
                                  backgroundColor: appTheme.colorFFF1F1,
                                  borderColor: appTheme.colorFF4F20,
                                  focusBorderColor: appTheme.colorFF4F20,
                                  borderRadius: 10,
                                  fontSize: 14.fSize,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24.h),
                          Expanded(
                            child: Column(
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
                                  height: 26.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.colorFFF1F1,
                                    border: Border.all(color: appTheme.colorFF4F20),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: _selectedSpecies,
                                      isExpanded: true,
                                      items: [
                                        DropdownMenuItem(value: 'dogs', child: Text('Cão')),
                                        DropdownMenuItem(value: 'cats', child: Text('Gato')),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedSpecies = value!;
                                        });
                                      },
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14.fSize,
                                        color: appTheme.colorFF4F20,
                                      ),
                                      dropdownColor: appTheme.colorFFF1F1,
                                      icon: Icon(Icons.arrow_drop_down, color: appTheme.colorFF4F20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Vacinado e Sexo
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Vacinado?',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15.fSize,
                                    fontWeight: FontWeight.w800,
                                    color: appTheme.colorFF4F20,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isVaccinated = true;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24.h,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: _isVaccinated ? appTheme.colorFF4F20 : appTheme.colorFFF1F1,
                                              border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                            ),
                                            child: _isVaccinated
                                                ? Icon(Icons.check, color: appTheme.whiteCustom, size: 16.h)
                                                : null,
                                          ),
                                          SizedBox(width: 8.h),
                                          Text(
                                            'SIM',
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
                                    SizedBox(width: 16.h),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isVaccinated = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24.h,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: !_isVaccinated ? appTheme.colorFF4F20 : appTheme.colorFFF1F1,
                                              border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                            ),
                                            child: !_isVaccinated
                                                ? Icon(Icons.check, color: appTheme.whiteCustom, size: 16.h)
                                                : null,
                                          ),
                                          SizedBox(width: 8.h),
                                          Text(
                                            'NÃO',
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
                              ],
                            ),
                          ),
                          SizedBox(width: 24.h),
                          Expanded(
                            child: Column(
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
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedGender = 'F';
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24.h,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: _selectedGender == 'F' ? appTheme.colorFF4F20 : appTheme.colorFFF1F1,
                                              border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                            ),
                                            child: _selectedGender == 'F'
                                                ? Icon(Icons.check, color: appTheme.whiteCustom, size: 16.h)
                                                : null,
                                          ),
                                          SizedBox(width: 8.h),
                                          Text(
                                            'F',
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
                                    SizedBox(width: 16.h),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedGender = 'M';
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24.h,
                                            height: 24.h,
                                            decoration: BoxDecoration(
                                              color: _selectedGender == 'M' ? appTheme.colorFF4F20 : appTheme.colorFFF1F1,
                                              border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                            ),
                                            child: _selectedGender == 'M'
                                                ? Icon(Icons.check, color: appTheme.whiteCustom, size: 16.h)
                                                : null,
                                          ),
                                          SizedBox(width: 8.h),
                                          Text(
                                            'M',
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Descrição
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Descrição:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15.fSize,
                              fontWeight: FontWeight.w800,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: double.infinity,
                            height: 97.h,
                            decoration: BoxDecoration(
                              color: appTheme.colorFFF1F1,
                              border: Border.all(color: appTheme.colorFF4F20),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _descriptionController,
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.fSize,
                                color: appTheme.colorFF4F20,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(12.h),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Nome Responsável e Telefone
                      Row(
                        children: [
                          Expanded(
                            child: Column(
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
                                CustomTextField(
                                  controller: _responsibleNameController,
                                  height: 26.h,
                                  backgroundColor: appTheme.colorFFF1F1,
                                  borderColor: appTheme.colorFF4F20,
                                  focusBorderColor: appTheme.colorFF4F20,
                                  borderRadius: 10,
                                  fontSize: 14.fSize,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 24.h),
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
                                CustomTextField(
                                  controller: _phoneController,
                                  height: 26.h,
                                  backgroundColor: appTheme.colorFFF1F1,
                                  borderColor: appTheme.colorFF4F20,
                                  focusBorderColor: appTheme.colorFF4F20,
                                  borderRadius: 10,
                                  fontSize: 14.fSize,
                                  keyboardType: TextInputType.phone,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 40.h),
                      
                      // Botão Cadastrar
                      CustomButton(
                        text: 'CADASTRAR PET',
                        onPressed: _handleRegisterPet,
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
                  
                  // Botão Adicionar (ativo)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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