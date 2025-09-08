import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class AppDenounceScreen extends StatefulWidget {
  const AppDenounceScreen({super.key});

  @override
  State<AppDenounceScreen> createState() => _AppDenounceScreenState();
}

class _AppDenounceScreenState extends State<AppDenounceScreen> {
  bool _isMenuOpen = false;
  bool _isAnonymous = false;

  // Controladores dos campos
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedType = '';
  bool _hasImages = false;

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

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appTheme.colorFF4F20,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  void _pickImages() {
    // Simular seleção de imagens
    setState(() {
      _hasImages = !_hasImages;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_hasImages ? 'Imagens adicionadas!' : 'Imagens removidas!'),
        backgroundColor: appTheme.colorFF9FE5,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _submitDenounce() {
    if (_selectedType.isEmpty || _locationController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha os campos obrigatórios.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    if (!_isAnonymous && (_nameController.text.isEmpty || _phoneController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Para denúncias não anônimas, informe seu nome e telefone.'),
          backgroundColor: appTheme.redCustom,
        ),
      );
      return;
    }

    // Aqui você implementaria o envio da denúncia
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Denúncia enviada com sucesso!'),
        backgroundColor: appTheme.greenCustom,
      ),
    );
    
    Navigator.of(context).pop();
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
                  height: 112.h,
                  color: appTheme.colorFF9FE5,
                  child: Row(
                    children: [
                      // Botão Voltar
                      Container(
                        margin: EdgeInsets.only(left: 22.h, top: 48.h),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            borderRadius: BorderRadius.circular(20.h),
                            child: Container(
                              width: 40.h,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: appTheme.colorFF9FE5,
                                borderRadius: BorderRadius.circular(20.h),
                                border: Border.all(
                                  color: appTheme.colorFF4F20,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: appTheme.colorFF4F20,
                                size: 24.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 12.h),
                      
                      // Menu hambúrguer
                      Container(
                        margin: EdgeInsets.only(top: 48.h),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _toggleMenu,
                            borderRadius: BorderRadius.circular(8.h),
                            child: Container(
                              width: 40.h,
                              height: 32.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 40.h,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFF4F20,
                                      borderRadius: BorderRadius.circular(4.h),
                                    ),
                                  ),
                                  Container(
                                    width: 40.h,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFF4F20,
                                      borderRadius: BorderRadius.circular(4.h),
                                    ),
                                  ),
                                  Container(
                                    width: 40.h,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: appTheme.colorFF4F20,
                                      borderRadius: BorderRadius.circular(4.h),
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
                        margin: EdgeInsets.only(right: 22.h, top: 36.h),
                        width: 48.h,
                        height: 64.h,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.profileScreen);
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 48.h,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: appTheme.colorFF9FE5,
                                  border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 28.h,
                                  color: appTheme.colorFF4F20,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Perfil',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.fSize,
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
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24.h),
                        
                        // Título com linha
                        Row(
                          children: [
                            Text(
                              'Denúncia',
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
                        
                        SizedBox(height: 37.h),
                        
                        // Formulário
                        _buildFormField(
                          label: 'Tipo de Denúncia',
                          child: _buildDropdown(),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        _buildFormField(
                          label: 'Local do Ocorrido',
                          child: _buildTextField(
                            controller: _locationController,
                            hintText: 'Digite o endereço ou local',
                          ),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        _buildFormField(
                          label: 'Data do Ocorrido',
                          child: _buildDateField(),
                        ),
                        
                        SizedBox(height: 25.h),
                        
                        _buildFormField(
                          label: 'Descrição Detalhada',
                          child: _buildTextArea(),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        _buildFormField(
                          label: 'Fotos ou Vídeos (Opcional)',
                          child: _buildImagePicker(),
                        ),
                        
                        SizedBox(height: 24.h),
                        
                        // Checkbox denúncia anônima
                        Row(
                          children: [
                            Checkbox(
                              value: _isAnonymous,
                              onChanged: (value) {
                                setState(() {
                                  _isAnonymous = value ?? false;
                                });
                              },
                              activeColor: appTheme.colorFF4F20,
                            ),
                            Text(
                              'Denúncia anônima',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.fSize,
                                fontWeight: FontWeight.w600,
                                color: appTheme.colorFF4F20,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Campos de contato (apenas se não for anônimo)
                        if (!_isAnonymous) ...[
                          _buildFormField(
                            label: 'Seu Nome',
                            child: _buildTextField(
                              controller: _nameController,
                              hintText: 'Digite seu nome',
                            ),
                          ),
                          
                          SizedBox(height: 20.h),
                          
                          _buildFormField(
                            label: 'Telefone/WhatsApp',
                            child: _buildTextField(
                              controller: _phoneController,
                              hintText: '(00) 00000-0000',
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          
                          SizedBox(height: 20.h),
                        ],
                        
                        // Botão enviar
                        Container(
                          width: double.infinity,
                          height: 52.h,
                          margin: EdgeInsets.symmetric(vertical: 16.h),
                          child: ElevatedButton(
                            onPressed: _submitDenounce,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appTheme.colorFF4F20,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.h),
                              ),
                            ),
                            child: Text(
                              'Enviar Denúncia',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14.fSize,
                                fontWeight: FontWeight.w700,
                                color: appTheme.whiteCustom,
                              ),
                            ),
                          ),
                        ),
                        
                        // Aviso de emergência
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.h),
                          margin: EdgeInsets.only(bottom: 24.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEF2F2),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8.h),
                              bottomRight: Radius.circular(8.h),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Em caso de emergência:',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.fSize,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFB91C1C),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Text(
                                    'Disque Denúncia: ',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.fSize,
                                      color: Color(0xFFDC2626),
                                    ),
                                  ),
                                  Text(
                                    '181',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.fSize,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFDC2626),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Text(
                                    'Polícia Militar: ',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.fSize,
                                      color: Color(0xFFDC2626),
                                    ),
                                  ),
                                  Text(
                                    '190',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12.fSize,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFFDC2626),
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
                                width: 32.h,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.home,
                                  color: appTheme.colorFF4F20,
                                  size: 14.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Home',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12.fSize,
                                fontWeight: FontWeight.w600,
                                color: appTheme.colorFF4F20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
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
                                width: 32.h,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: appTheme.colorFF4F20, width: 2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: appTheme.colorFF4F20,
                                  size: 14.h,
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
          
          // Menu lateral (mesmo código do arquivo original)
          if (_isMenuOpen)
            GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          
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
                    color: Colors.black.withValues(alpha: 0.25),
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
                              color: Colors.black.withValues(alpha: 0.25),
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

  Widget _buildFormField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.fSize,
            fontWeight: FontWeight.w700,
            color: appTheme.colorFF4F20,
          ),
        ),
        SizedBox(height: 4.h),
        child,
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      width: double.infinity,
      height: 47.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        border: Border.all(color: appTheme.colorFF4F20, width: 2),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedType.isEmpty ? null : _selectedType,
          hint: Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              'Selecione o tipo',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.fSize,
                color: appTheme.colorFF4F20,
              ),
            ),
          ),
          items: [
            'Maus-tratos',
            'Abandono',
            'Negligência',
            'Exploração',
            'Outros',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.fSize,
                    color: appTheme.colorFF4F20,
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue ?? '';
            });
          },
          icon: Padding(
            padding: EdgeInsets.only(right: 12.h),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: appTheme.colorFF4F20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        border: Border.all(color: appTheme.colorFF4F20, width: 2),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.fSize,
          color: appTheme.blackCustom,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.fSize,
            color: Color(0xFFADAEBC),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          border: Border.all(color: appTheme.colorFF4F20, width: 2),
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 22.h),
                child: Text(
                  _dateController.text.isEmpty ? 'dd/mm/aaaa' : _dateController.text,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.fSize,
                    color: _dateController.text.isEmpty ? Color(0xFFADAEBC) : appTheme.blackCustom,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.h),
              child: Icon(
                Icons.calendar_today,
                color: appTheme.blackCustom,
                size: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextArea() {
    return Container(
      width: double.infinity,
      height: 128.h,
      decoration: BoxDecoration(
        color: appTheme.whiteCustom,
        border: Border.all(color: appTheme.colorFF4F20, width: 2),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: TextField(
        controller: _descriptionController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 14.fSize,
          color: appTheme.blackCustom,
        ),
        decoration: InputDecoration(
          hintText: 'Descreva o que aconteceu...',
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.fSize,
            color: Color(0xFFADAEBC),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.h),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: double.infinity,
        height: 104.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          border: Border.all(
            color: appTheme.colorFF4F20,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8.h),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              color: appTheme.colorFF4F20,
              size: 24.h,
            ),
            SizedBox(height: 8.h),
            Text(
              _hasImages 
                ? 'Imagens adicionadas - toque para remover' 
                : 'Toque para adicionar fotos',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.fSize,
                color: appTheme.colorFF4F20,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
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

  @override
  void dispose() {
    _locationController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}