import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../core/app_export.dart';
import '../../models/pet_model.dart';
import '../../repositories/firebase_pet_repository.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isMenuOpen = false;
  List<Pet> _userPets = [];
  bool _isLoadingPets = false;
  final FirebasePetRepository _petRepository = FirebasePetRepository();

  @override
  void initState() {
    super.initState();
    _loadUserPets();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recarregar pets sempre que a tela for exibida (após cadastrar novo pet)
    _loadUserPets();
  }

  void _loadUserPets() async {
    setState(() {
      _isLoadingPets = true;
    });

    try {
      final pets = await _petRepository.getUserPets();
      setState(() {
        _userPets = pets;
        _isLoadingPets = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingPets = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao carregar seus pets'),
          backgroundColor: appTheme.redCustom,
        ),
      );
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

  void _handleLogout(BuildContext context) {
    // Fechar o menu se estiver aberto
    _closeMenu();
    // Mostrar diálogo de confirmação
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

  void _handleDenounce() {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.denounceScreen);
  }

  void _handleVisualizarSenha(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();
    bool isPasswordVisible = false;
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: appTheme.colorFFF1F1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Visualizar Senha',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.fSize,
                  fontWeight: FontWeight.bold,
                  color: appTheme.colorFF4F20,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Digite sua senha atual para visualizá-la',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.fSize,
                      color: appTheme.colorFF4F20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: appTheme.colorFF4F20.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !isPasswordVisible,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16.fSize,
                        color: appTheme.colorFF4F20,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Senha atual',
                        hintStyle: TextStyle(
                          color: appTheme.colorFF4F20.withValues(alpha: 0.5),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.h,
                          vertical: 12.h,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
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
                  onPressed: isLoading ? null : () async {
                    final password = passwordController.text.trim();
                    if (password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Digite sua senha'),
                          backgroundColor: appTheme.redCustom,
                        ),
                      );
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    try {
                      final user = FirebaseAuth.instance.currentUser;
                      if (user?.email == null) {
                        throw FirebaseAuthException(
                          code: 'user-not-found',
                          message: 'Usuário não encontrado',
                        );
                      }

                      final credential = EmailAuthProvider.credential(
                        email: user!.email!,
                        password: password,
                      );
                      
                      await user.reauthenticateWithCredential(credential);
                      
                      Navigator.of(dialogContext).pop();
                      
                      _showPasswordDialog(context, password);
                      
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(FirebaseAuthHelper.getErrorMessage(e.code)),
                          backgroundColor: appTheme.redCustom,
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erro inesperado. Tente novamente.'),
                          backgroundColor: appTheme.redCustom,
                        ),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.colorFF4F20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 20.h,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            color: appTheme.colorFFF1F1,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Verificar',
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
      },
    );
  }

  void _showPasswordDialog(BuildContext context, String password) {
    bool isPasswordVisible = false;
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: appTheme.colorFFF1F1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Sua Senha',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.fSize,
                  fontWeight: FontWeight.bold,
                  color: appTheme.colorFF4F20,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.h),
                    decoration: BoxDecoration(
                      color: appTheme.whiteCustom,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: appTheme.colorFF4F20.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            isPasswordVisible ? password : '•' * password.length,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.fSize,
                              color: appTheme.colorFF4F20,
                              letterSpacing: isPasswordVisible ? 1 : 2,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Mantenha sua senha segura e não a compartilhe com ninguém.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.fSize,
                      color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.colorFF4F20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Fechar',
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
      },
    );
  }

  Future<void> _handleRedefinirSenha(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: const Text('Usuário não autenticado.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: user!.email!);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('E-mail de redefinição enviado!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erro'),
          content: Text(FirebaseAuthHelper.getErrorMessage(e.code)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _handleMeusFavoritos(BuildContext context) {
    _closeMenu();
    Navigator.of(context).pushNamed(AppRoutes.favoritesScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colorFFF1F1,
      body: Stack(
        children: [
          // Conteúdo principal
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
                              child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(8.h),
                                child: Container(
                                  width: 40.h,
                                  height: 40.h,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appTheme.colorFF4F20,
                                    size: 28.h,
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
                              child: InkWell(
                                onTap: _toggleMenu,
                                borderRadius: BorderRadius.circular(8.h),
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
                                          borderRadius: BorderRadius.circular(4.h),
                                        ),
                                      ),
                                      Container(
                                        width: 40.h,
                                        height: 4.h,
                                        decoration: BoxDecoration(
                                          color: appTheme.colorFF4F20,
                                          borderRadius: BorderRadius.circular(4.h),
                                        ),
                                      ),
                                      Container(
                                        width: 40.h,
                                        height: 4.h,
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
                        ],
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
                      
                      // Botão de denúncia
                      Container(
                        margin: EdgeInsets.only(right: 18.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(AppRoutes.denounceScreen);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 45.h,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  color: appTheme.redCustom.withValues(alpha: 0.1),
                                  border: Border.all(color: appTheme.redCustom, width: 2),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: appTheme.redCustom.withValues(alpha: 0.2),
                                      blurRadius: 4.h,
                                      offset: Offset(0, 2.h),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.report_problem,
                                    size: 22.h,
                                    color: appTheme.redCustom,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Denuncie\naqui',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 9.fSize,
                                  fontWeight: FontWeight.w600,
                                  color: appTheme.redCustom,
                                  height: 1.1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Conteúdo do perfil
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        
                        // Foto de perfil
                        Container(
                          width: 200.h,
                          height: 200.h,
                          decoration: BoxDecoration(
                            color: appTheme.whiteCustom,
                            shape: BoxShape.circle,
                            border: Border.all(color: appTheme.blackCustom, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              size: 100.h,
                              color: appTheme.colorFF4F20,
                            ),
                          ),
                        ),
                        
                        SizedBox(height: 12.h),
                       
                        StreamBuilder<User?>(
                          stream: FirebaseAuth.instance.authStateChanges(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              final user = snapshot.data!;
                              final displayName = user.displayName ?? 
                                                user.email?.split('@')[0] ?? 
                                                'Usuário';
                              return Column(
                                children: [
                                  Text(
                                    displayName,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 24.fSize,
                                      fontWeight: FontWeight.bold,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    user.email ?? '',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.fSize,
                                      color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Text(
                              'Usuário',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 24.fSize,
                                fontWeight: FontWeight.bold,
                                color: appTheme.colorFF4F20,
                              ),
                            );
                          },
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Opções do perfil
                        _buildProfileOption(
                          'Visualizar senha',
                          onTap: () => _handleVisualizarSenha(context),
                        ),
                        
                        SizedBox(height: 8.h),
                        
                        _buildProfileOption(
                          'Redefinir Senha',
                          onTap: () => _handleRedefinirSenha(context),
                        ),
                        
                        SizedBox(height: 8.h),
                        
                        _buildProfileOption(
                          'Meus Favoritos',
                          onTap: () => _handleMeusFavoritos(context),
                        ),
                        
                        SizedBox(height: 20.h),
                        
                        // Seção Meus Pets
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título da seção
                              Row(
                                children: [
                                  Text(
                                    'Meus Pets',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18.fSize,
                                      fontWeight: FontWeight.bold,
                                      color: appTheme.colorFF4F20,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${_userPets.length} ${_userPets.length == 1 ? 'pet' : 'pets'}',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.fSize,
                                      fontWeight: FontWeight.w500,
                                      color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                              
                              SizedBox(height: 12.h),
                              
                              // Lista de pets ou estado vazio
                              if (_isLoadingPets)
                                Center(
                                  child: CircularProgressIndicator(
                                    color: appTheme.colorFF4F20,
                                    strokeWidth: 2,
                                  ),
                                )
                              else if (_userPets.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20.h),
                                  decoration: BoxDecoration(
                                    color: appTheme.whiteCustom,
                                    borderRadius: BorderRadius.circular(12.h),
                                    border: Border.all(
                                      color: appTheme.colorFF4F20.withValues(alpha: 0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.pets,
                                        size: 40.h,
                                        color: appTheme.colorFF4F20.withValues(alpha: 0.5),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'Nenhum pet cadastrado',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14.fSize,
                                          fontWeight: FontWeight.w500,
                                          color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(AppRoutes.addPetScreen);
                                        },
                                        child: Text(
                                          'Cadastrar primeiro pet',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 14.fSize,
                                            fontWeight: FontWeight.w600,
                                            color: appTheme.colorFF4F20,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                Container(
                                  height: 120.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _userPets.length,
                                    separatorBuilder: (context, index) => SizedBox(width: 12.h),
                                    itemBuilder: (context, index) {
                                      final pet = _userPets[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            AppRoutes.petProfileScreen,
                                            arguments: pet,
                                          );
                                        },
                                        child: Container(
                                          width: 100.h,
                                          decoration: BoxDecoration(
                                            color: appTheme.whiteCustom,
                                            borderRadius: BorderRadius.circular(12.h),
                                            border: Border.all(
                                              color: appTheme.colorFF4F20.withValues(alpha: 0.3),
                                              width: 1,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.1),
                                                blurRadius: 4.h,
                                                offset: Offset(0, 2.h),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 50.h,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  color: appTheme.colorFF9FE5.withValues(alpha: 0.3),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.pets,
                                                  color: appTheme.colorFF4F20,
                                                  size: 24.h,
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Text(
                                                pet.name,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 12.fSize,
                                                  fontWeight: FontWeight.w600,
                                                  color: appTheme.colorFF4F20,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(height: 2.h),
                                              Text(
                                                pet.speciesDisplayName,
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontSize: 10.fSize,
                                                  fontWeight: FontWeight.w400,
                                                  color: appTheme.colorFF4F20.withValues(alpha: 0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 32.h),
                        
                        // Botão de logout
                        GestureDetector(
                          onTap: () => _handleLogout(context),
                          child: Container(
                            width: 100.h,
                            height: 40.h,
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
                                'SAIR',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18.fSize,
                                  fontWeight: FontWeight.w500,
                                  color: appTheme.whiteCustom,
                                ),
                              ),
                            ),
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
          
          // Overlay escuro quando menu está aberto
          if (_isMenuOpen)
            GestureDetector(
              onTap: _closeMenu,
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
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
                          
                          // Denúncia
                          _buildMenuItem(
                            'Denúncia',
                            onTap: _handleDenounce,
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
                      onTap: () => _handleLogout(context),
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

  Widget _buildProfileOption(String title, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color: appTheme.whiteCustom,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.fSize,
                fontWeight: FontWeight.w500,
                color: appTheme.colorFF4F20,
              ),
            ),
          ),
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
}
