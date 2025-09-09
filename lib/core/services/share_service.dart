import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../models/pet_model.dart';

class ShareService {
  // Gerar URL de deep link para o pet
  static String generatePetDeepLink(String petId) {
    // URL scheme customizado para o app
    return 'petadote://pet/$petId';
  }

  // Gerar URL web para fallback
  static String generatePetWebLink(String petId) {
    // URL web que pode redirecionar para o app ou mostrar o pet
    return 'https://petadote.app/pet/$petId';
  }

  // Gerar texto para compartilhamento
  static String generateShareText(Pet pet) {
    final petLink = generatePetWebLink(pet.id ?? '');
    
    return '''
🐾 ${pet.name.toUpperCase()} - ${pet.speciesDisplayName} para adoção!

📍 ${pet.location}
🎂 ${pet.age}
${pet.gender == 'M' ? '♂️ Macho' : '♀️ Fêmea'}
💉 ${pet.vaccinationStatus}

💖 ${pet.description.isNotEmpty ? pet.description : 'Um pet especial esperando por uma família!'}

📞 Contato: ${pet.responsibleName}
📱 ${pet.phone}

Baixe o app PetAdote e ajude a encontrar um lar para este pet!
$petLink

#PetAdote #Adoção #${pet.species == 'dogs' ? 'Cachorro' : 'Gato'}
    ''';
  }

  // Compartilhar perfil do pet
  static Future<void> sharePetProfile(Pet pet) async {
    final text = generateShareText(pet);
    
    try {
      await Share.share(
        text,
        subject: '🐾 ${pet.name} - ${pet.speciesDisplayName} para adoção!',
      );
    } catch (e) {
      // Fallback: copiar para clipboard
      await Clipboard.setData(ClipboardData(text: text));
      throw Exception('Texto copiado para área de transferência');
    }
  }

  // Compartilhar em rede social específica
  static Future<void> shareToSocialMedia(Pet pet, String platform) async {
    final text = generateShareText(pet);
    final encodedText = Uri.encodeComponent(text);
    
    String url;
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        url = 'https://wa.me/?text=$encodedText';
        break;
      case 'telegram':
        url = 'https://t.me/share/url?text=$encodedText';
        break;
      case 'twitter':
        url = 'https://twitter.com/intent/tweet?text=$encodedText';
        break;
      case 'facebook':
        url = 'https://www.facebook.com/sharer/sharer.php?u=${generatePetWebLink(pet.id ?? '')}&quote=$encodedText';
        break;
      case 'instagram':
        // Instagram não permite compartilhamento direto de texto via URL
        await Clipboard.setData(ClipboardData(text: text));
        throw Exception('Texto copiado! Cole nos stories do Instagram');
      default:
        throw Exception('Plataforma não suportada');
    }
    
    try {
      final uri = Uri.parse(url);
      // Nota: Esta implementação requer url_launcher
      // await launchUrl(uri, mode: LaunchMode.externalApplication);
      
      // Por enquanto, vamos usar o Share.share para todas as plataformas
      await Share.share(text, subject: '🐾 ${pet.name} para adoção!');
    } catch (e) {
      await Clipboard.setData(ClipboardData(text: text));
      throw Exception('Erro ao compartilhar. Texto copiado para área de transferência');
    }
  }

  // Copiar link do pet
  static Future<void> copyPetLink(Pet pet) async {
    final link = generatePetWebLink(pet.id ?? '');
    await Clipboard.setData(ClipboardData(text: link));
  }

  // Copiar informações completas do pet
  static Future<void> copyPetInfo(Pet pet) async {
    final text = generateShareText(pet);
    await Clipboard.setData(ClipboardData(text: text));
  }
}
