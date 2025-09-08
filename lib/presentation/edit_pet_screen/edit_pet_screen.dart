import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../models/pet_model.dart';
import '../../repositories/firebase_pet_repository.dart';

class EditPetScreen extends StatefulWidget {
  const EditPetScreen({super.key});

  @override
  State<EditPetScreen> createState() => _EditPetScreenState();
}

class _EditPetScreenState extends State<EditPetScreen> {
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _responsibleNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedSpecies = 'dogs';
  String _selectedGender = 'F';
  bool _isVaccinated = false;
  bool _isMenuOpen = false;
  Pet? _originalPet;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Obter os dados do Pet passados como argumentos
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Pet && _originalPet == null) {
      _originalPet = arguments;
      _populateFields();
    }
  }

  void _populateFields() {
    if (_originalPet != null) {
      _petNameController.text = _originalPet!.name;
      _locationController.text = _originalPet!.location;
      _ageController.text = _originalPet!.age;
      _descriptionController.text = _originalPet!.description;
      _responsibleNameController.text = _originalPet!.responsibleName;
      _phoneController.text = _originalPet!.phone;
      _selectedSpecies = _originalPet!.species;
      _selectedGender = _originalPet!.gender;
      _isVaccinated = _originalPet!.isVaccinated;
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

  void _updatePet() async {
    if (_originalPet?.id == null) return;

    // Validação dos campos obrigatórios
    if (_petNameController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty ||
        _ageController.text.trim().isEmpty ||
        _responsibleNameController.text.trim().isEmpty ||
        _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos obrigatórios'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    // Criar objeto Pet atualizado
    final updatedPet = Pet(
      id: _originalPet!.id,
      name: _petNameController.text.trim(),
      location: _locationController.text.trim(),
      age: _ageController.text.trim(),
      species: _selectedSpecies,
      gender: _selectedGender,
      isVaccinated: _isVaccinated,
      description: _descriptionController.text.trim(),
      responsibleName: _responsibleNameController.text.trim(),
      phone: _phoneController.text.trim(),
      createdBy: _originalPet!.createdBy,
      createdByEmail: _originalPet!.createdByEmail,
    );

    // Mostrar indicador de carregamento
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: appTheme.colorFF4F20,
        ),
      ),
    );

    try {
      final firebasePetRepository = FirebasePetRepository();
      final success = await firebasePetRepository.updatePet(_originalPet!.id!, updatedPet);
      Navigator.of(context).pop(); // Fechar loading

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pet atualizado com sucesso!'),
            backgroundColor: appTheme.greenCustom,
          ),
        );
        
        // Navegar para o perfil do pet atualizado
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.petProfileScreen,
          arguments: updatedPet,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar pet. Tente novamente.'),
            backgroundColor: appTheme.redCustom,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Fechar loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar pet: $e'),
          backgroundColor: appTheme.redCustom,
        ),
      );
    }
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
                      // Navegação - Botão Voltar e Menu
                      Row(
                        children: [
                          // Botão Voltar
                          Container(
                            margin: EdgeInsets.only(left: 22.h),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.h),
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    borderRadius: BorderRadius.circular(8.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.h,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appTheme.colorFF4F20,
                                    size: 22.h,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(width: 12.h),
                          
                          // Menu hambúrguer
                          Container(
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.h),
                              child: InkWell(
                                onTap: _toggleMenu,
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    borderRadius: BorderRadius.circular(8.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20,
                                      width: 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4.h,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
                                        ),
                                      ),
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
                                        ),
                                      ),
                                      Container(
                                        width: 20.h,
                                        height: 3.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(2.h),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  
                  // Logo centralizado
                  Expanded(
                    child: Center(
                      child: Text(
                        'PetAdote',
                        style: TextStyle(
                          fontFamily: 'Leckerli One',
                          fontSize: 28.fSize,
                          color: appTheme.colorFF4F20,
                        ),
                      ),
                    ),
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
                
                // Conteúdo da tela
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 35.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 22.h),
                        
                        // Título "Editar Pet"
                        Row(
                          children: [
                            Text(
                              'Editar Pet',
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
                        
                        // Nome do pet
                        Text(
                          'Nome do pet*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _petNameController,
                          placeholder: 'Ex: Rex, Mimi, Bolinha...',
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Localização
                        Text(
                          'Localização*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _locationController,
                          placeholder: 'Ex: Garanhuns - PE',
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Espécie
                        Text(
                          'Espécie*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: appTheme.whiteCustom,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: appTheme.colorFF4F20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSpecies,
                              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                              dropdownColor: appTheme.whiteCustom,
                              items: [
                                DropdownMenuItem(
                                  value: 'dogs',
                                  child: Text(
                                    'Cachorro',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'cats',
                                  child: Text(
                                    'Gato',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedSpecies = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Idade
                        Text(
                          'Idade*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _ageController,
                          placeholder: 'Ex: 2 anos, 6 meses, Filhote...',
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Sexo
                        Text(
                          'Sexo*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: appTheme.whiteCustom,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: appTheme.colorFF4F20),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedGender,
                              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
                              dropdownColor: appTheme.whiteCustom,
                              items: [
                                DropdownMenuItem(
                                  value: 'F',
                                  child: Text(
                                    'Fêmea',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'M',
                                  child: Text(
                                    'Macho',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16.fSize,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Vacinado
                        Row(
                          children: [
                            Text(
                              'Vacinado?*',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15.fSize,
                                fontWeight: FontWeight.w800,
                                color: appTheme.colorFF4F20,
                              ),
                            ),
                            SizedBox(width: 16.h),
                            Switch(
                              value: _isVaccinated,
                              onChanged: (value) {
                                setState(() {
                                  _isVaccinated = value;
                                });
                              },
                              activeColor: appTheme.colorFF4F20,
                            ),
                            Text(
                              _isVaccinated ? 'Sim' : 'Não',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.fSize,
                                color: appTheme.colorFF4F20,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Descrição
                        Text(
                          'Descrição',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 100.h,
                          child: TextFormField(
                            controller: _descriptionController,
                            maxLines: 4,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.fSize,
                              color: appTheme.blackCustom,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Conte um pouco sobre o temperamento, personalidade...',
                              hintStyle: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16.fSize,
                                color: appTheme.grey500,
                              ),
                              filled: true,
                              fillColor: appTheme.whiteCustom,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.h,
                                vertical: 12.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.h),
                                borderSide: BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.h,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.h),
                                borderSide: BorderSide(
                                  color: Color(0xFFE5E7EB),
                                  width: 1.h,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.h),
                                borderSide: BorderSide(
                                  color: Color(0xFF9FE5AD),
                                  width: 2.h,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Nome do responsável
                        Text(
                          'Nome do responsável*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _responsibleNameController,
                          placeholder: 'Seu nome completo',
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Telefone
                        Text(
                          'Telefone (WhatsApp)*',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15.fSize,
                            fontWeight: FontWeight.w800,
                            color: appTheme.colorFF4F20,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _phoneController,
                          placeholder: '(87) 99999-9999',
                          keyboardType: TextInputType.phone,
                        ),
                        
                        SizedBox(height: 40.h),
                        
                        // Botão Atualizar
                        Center(
                          child: CustomButton(
                            text: 'ATUALIZAR PET',
                            onPressed: _updatePet,
                            backgroundColor: appTheme.colorFF4F20,
                            textColor: appTheme.whiteCustom,
                            height: 50.h,
                            width: 280.h,
                            fontSize: 18.fSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        
                        SizedBox(height: 30.h),
                      ],
                    ),
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

  Widget _buildDivider() {
    return Container(
      height: 1,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      color: appTheme.blackCustom,
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
}