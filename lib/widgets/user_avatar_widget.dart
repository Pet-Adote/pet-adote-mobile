import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../repositories/firebase_user_repository.dart';
import '../widgets/custom_image_view.dart';

class UserAvatarWidget extends StatefulWidget {
  final double size;
  final bool showLabel;
  final String? label;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? iconColor;

  const UserAvatarWidget({
    super.key,
    this.size = 49.0,
    this.showLabel = true,
    this.label = 'Perfil',
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.iconColor,
  });

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  final FirebaseUserRepository _userRepository = FirebaseUserRepository();
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  void _loadProfileImage() async {
    try {
      final imageUrl = await _userRepository.getUserProfileImageUrl();
      if (mounted) {
        setState(() {
          _profileImageUrl = imageUrl;
        });
      }
    } catch (e) {
      print('Erro ao carregar imagem do perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.size.h,
        height: widget.showLabel ? (widget.size + 15).h : widget.size.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: widget.size.h,
              height: widget.size.h,
              decoration: BoxDecoration(
                color: widget.backgroundColor ?? appTheme.colorFF9FE5,
                border: Border.all(
                  color: widget.borderColor ?? appTheme.colorFF4F20, 
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                    ? CustomImageView(
                        imagePath: _profileImageUrl!,
                        width: widget.size.h,
                        height: widget.size.h,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        color: widget.iconColor ?? appTheme.colorFF4F20,
                        size: (widget.size * 0.5).h,
                      ),
              ),
            ),
            if (widget.showLabel && widget.label != null) ...[
              SizedBox(height: 2.h),
              Text(
                widget.label!,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 11.fSize,
                  fontWeight: FontWeight.w600,
                  color: widget.iconColor ?? appTheme.colorFF4F20,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
