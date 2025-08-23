class Pet {
  final String name;
  final String location;
  final String age;
  final String species;
  final String gender;
  final bool isVaccinated;
  final String description;
  final String responsibleName;
  final String phone;
  final String? imagePath;

  Pet({
    required this.name,
    required this.location,
    required this.age,
    required this.species,
    required this.gender,
    required this.isVaccinated,
    required this.description,
    required this.responsibleName,
    required this.phone,
    this.imagePath,
  });

  // Método para obter o nome da espécie formatado
  String get speciesDisplayName {
    switch (species) {
      case 'dogs':
        return 'Cão';
      case 'cats':
        return 'Gato';
      default:
        return 'Outro';
    }
  }

  // Método para obter o status de vacinação formatado
  String get vaccinationStatus {
    return isVaccinated ? 'SIM' : 'NÃO';
  }

  // Método para obter o sexo formatado
  String get genderDisplayName {
    switch (gender) {
      case 'M':
        return 'Macho';
      case 'F':
        return 'Fêmea';
      default:
        return 'Não informado';
    }
  }

  // Método para gerar texto de compartilhamento do WhatsApp
  String generateWhatsAppMessage() {
    final petIcon = species == 'cats' ? '🐱' : '🐶';
    
    return '''
$petIcon *$name* está disponível para adoção!

📍 *Localização:* $location
📞 *Contato:* $phone
👤 *Responsável:* $responsibleName

🏷️ *Informações:*
• Espécie: $speciesDisplayName
• Idade: $age  
• Sexo: $genderDisplayName
• Vacinado: $vaccinationStatus

ℹ️ *Sobre o $name:*
$description

Adote com amor! 💙
    ''';
  }
}