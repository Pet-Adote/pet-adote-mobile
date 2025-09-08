import 'package:cloud_firestore/cloud_firestore.dart';

class EmailService {
  static const String _recipientEmail = 'pet.adote2025@gmail.com';
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  static Future<bool> sendDenounceEmail({
    required String type,
    required String location,
    required String date,
    required String description,
    required bool isAnonymous,
    String? denouncerName,
    String? denouncerPhone,
    bool hasImages = false,
  }) async {
    try {
      // PRIMEIRO: Salvar no Firestore para garantir que a denúncia seja registrada
      final protocol = 'DEN-${DateTime.now().millisecondsSinceEpoch}';
      
      await _saveToFirestore(
        protocol: protocol,
        type: type,
        location: location,
        date: date,
        description: description,
        isAnonymous: isAnonymous,
        denouncerName: denouncerName,
        denouncerPhone: denouncerPhone,
        hasImages: hasImages,
      );

      print('✅ Denúncia salva no Firestore com protocolo: $protocol');
      print('📧 Dados enviados para processamento de email');
      
      return true; // Sempre true porque salvamos no Firestore
      
    } catch (e) {
      print('❌ Erro ao processar denúncia: $e');
      return false;
    }
  }

  static Future<void> _saveToFirestore({
    required String protocol,
    required String type,
    required String location,
    required String date,
    required String description,
    required bool isAnonymous,
    String? denouncerName,
    String? denouncerPhone,
    bool hasImages = false,
  }) async {
    await _firestore.collection('denounces').doc(protocol).set({
      'protocol': protocol,
      'type': type,
      'typeDisplay': getTypeDisplayName(type),
      'location': location,
      'dateOccurred': date,
      'description': description,
      'isAnonymous': isAnonymous,
      'denouncerName': denouncerName,
      'denouncerPhone': denouncerPhone,
      'hasImages': hasImages,
      'status': 'pending', // pending, reviewing, resolved
      'createdAt': FieldValue.serverTimestamp(),
      'needsEmailNotification': true,
      'emailSent': false,
      'recipientEmail': _recipientEmail,
      'priority': _getPriority(type),
      'emailBody': buildDenounceBody(
        type: type,
        location: location,
        date: date,
        description: description,
        isAnonymous: isAnonymous,
        denouncerName: denouncerName,
        denouncerPhone: denouncerPhone,
        hasImages: hasImages,
      ),
    });
  }

  static String _getPriority(String type) {
    switch (type) {
      case 'abuse':
      case 'abandonment':
        return 'high';
      case 'mistreatment':
        return 'medium';
      default:
        return 'low';
    }
  }

  static String getTypeDisplayName(String type) {
    switch (type) {
      case 'abuse':
        return 'Maus-tratos';
      case 'abandonment':
        return 'Abandono';
      case 'mistreatment':
        return 'Negligência';
      case 'illegal_sale':
        return 'Venda Ilegal';
      case 'other':
        return 'Outros';
      default:
        return type;
    }
  }

  static String buildDenounceBody({
    required String type,
    required String location,
    required String date,
    required String description,
    required bool isAnonymous,
    String? denouncerName,
    String? denouncerPhone,
    bool hasImages = false,
  }) {
    return '''
🚨 NOVA DENÚNCIA RECEBIDA - PETADOTE 🚨

═══════════════════════════════════════
📋 INFORMAÇÕES DA DENÚNCIA
═══════════════════════════════════════

🔸 Tipo: ${getTypeDisplayName(type)}
🔸 Local: $location  
🔸 Data do Ocorrido: $date
🔸 Evidências: ${hasImages ? 'Sim' : 'Não'}

📝 DESCRIÇÃO:
$description

═══════════════════════════════════════
👤 INFORMAÇÕES DO DENUNCIANTE
═══════════════════════════════════════

🔸 Tipo: ${isAnonymous ? 'Denúncia Anônima' : 'Denúncia Identificada'}
${!isAnonymous ? '🔸 Nome: ${denouncerName ?? 'Não informado'}' : ''}
${!isAnonymous ? '🔸 Telefone: ${denouncerPhone ?? 'Não informado'}' : ''}

═══════════════════════════════════════
⚡ AÇÃO NECESSÁRIA
═══════════════════════════════════════

Por favor, revise esta denúncia e tome as medidas cabíveis.
Para casos graves, considere contatar as autoridades competentes.

Data de Envio: ${DateTime.now().toString()}
Fonte: Aplicativo PetAdote
''';
  }
}
