import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../core/app_export.dart';
import '../models/pet_model.dart';

class ShareButton extends StatelessWidget {
  final Pet pet;
  final double? size;
  final Color? color;
  final Color? backgroundColor;
  final bool showLabel;
  final String? customLabel;

  const ShareButton({
    super.key,
    required this.pet,
    this.size,
    this.color,
    this.backgroundColor,
    this.showLabel = false,
    this.customLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showShareOptions(context),
      child: Container(
        width: size ?? 40.h,
        height: size ?? 40.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? appTheme.colorFF9FE5,
          border: Border.all(
            color: appTheme.colorFF4F20, 
            width: 2
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.h,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.share,
              color: color ?? appTheme.colorFF4F20,
              size: (size ?? 40.h) * 0.5,
            ),
            if (showLabel) ...[
              SizedBox(height: 2.h),
              Text(
                customLabel ?? 'Compartilhar',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 8.fSize,
                  fontWeight: FontWeight.w600,
                  color: color ?? appTheme.colorFF4F20,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: appTheme.colorFFF1F1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.h)),
      ),
      builder: (context) => ShareOptionsBottomSheet(pet: pet),
    );
  }
}

class ShareOptionsBottomSheet extends StatelessWidget {
  final Pet pet;

  const ShareOptionsBottomSheet({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicador de arrastar
          Container(
            width: 40.h,
            height: 4.h,
            decoration: BoxDecoration(
              color: appTheme.colorFF4F20.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.h),
            ),
          ),
          
          SizedBox(height: 20.h),
          
          // Título
          Text(
            'Compartilhar ${pet.name}',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20.fSize,
              fontWeight: FontWeight.bold,
              color: appTheme.colorFF4F20,
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Opções de compartilhamento
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 16.h,
            crossAxisSpacing: 16.h,
            children: [
              _buildShareOption(
                context,
                icon: Icons.share,
                label: 'Geral',
                color: appTheme.colorFF4F20,
                onTap: () => _shareGeneral(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.message,
                label: 'WhatsApp',
                color: Color(0xFF25D366),
                onTap: () => _shareToWhatsApp(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.send,
                label: 'Telegram',
                color: Color(0xFF0088CC),
                onTap: () => _shareToTelegram(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.camera_alt,
                label: 'Instagram',
                color: Color(0xFFE4405F),
                onTap: () => _shareToInstagram(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.facebook,
                label: 'Facebook',
                color: Color(0xFF1877F2),
                onTap: () => _shareToFacebook(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.alternate_email,
                label: 'Twitter',
                color: Color(0xFF1DA1F2),
                onTap: () => _shareToTwitter(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.link,
                label: 'Copiar Link',
                color: appTheme.grey600,
                onTap: () => _copyLink(context),
              ),
              _buildShareOption(
                context,
                icon: Icons.copy,
                label: 'Copiar Texto',
                color: appTheme.grey600,
                onTap: () => _copyInfo(context),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50.h,
            height: 50.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.fSize,
              fontWeight: FontWeight.w500,
              color: appTheme.colorFF4F20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _shareGeneral(BuildContext context) async {
    try {
      await ShareService.sharePetProfile(pet);
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _shareToWhatsApp(BuildContext context) async {
    try {
      await ShareService.shareToSocialMedia(pet, 'whatsapp');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _shareToTelegram(BuildContext context) async {
    try {
      await ShareService.shareToSocialMedia(pet, 'telegram');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _shareToInstagram(BuildContext context) async {
    try {
      await ShareService.shareToSocialMedia(pet, 'instagram');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _shareToFacebook(BuildContext context) async {
    try {
      await ShareService.shareToSocialMedia(pet, 'facebook');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _shareToTwitter(BuildContext context) async {
    try {
      await ShareService.shareToSocialMedia(pet, 'twitter');
      Navigator.pop(context);
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, e.toString());
    }
  }

  void _copyLink(BuildContext context) async {
    try {
      await ShareService.copyPetLink(pet);
      Navigator.pop(context);
      _showMessage(context, 'Link copiado para área de transferência!');
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, 'Erro ao copiar link');
    }
  }

  void _copyInfo(BuildContext context) async {
    try {
      await ShareService.copyPetInfo(pet);
      Navigator.pop(context);
      _showMessage(context, 'Informações copiadas para área de transferência!');
    } catch (e) {
      Navigator.pop(context);
      _showMessage(context, 'Erro ao copiar informações');
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: appTheme.colorFF4F20,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
