import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/models/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('Pet Model Tests', () {
    late Pet testPet;

    setUp(() {
      testPet = Pet(
        id: 'test_id_123',
        name: 'Rex',
        location: 'Garanhuns, PE',
        age: '3 anos',
        species: 'dogs',
        gender: 'M',
        isVaccinated: true,
        description: 'Cão muito carinhoso e brincalhão',
        responsibleName: 'João Silva',
        phone: '87 99999-8888',
        imagePath: 'assets/images/rex.jpg',
        createdBy: 'user123',
        createdByEmail: 'joao@email.com',
        createdAt: DateTime.parse('2024-01-15 10:30:00'),
      );
    });

    test('deve criar um Pet com todos os campos', () {
      expect(testPet.id, equals('test_id_123'));
      expect(testPet.name, equals('Rex'));
      expect(testPet.location, equals('Garanhuns, PE'));
      expect(testPet.age, equals('3 anos'));
      expect(testPet.species, equals('dogs'));
      expect(testPet.gender, equals('M'));
      expect(testPet.isVaccinated, isTrue);
      expect(testPet.description, equals('Cão muito carinhoso e brincalhão'));
      expect(testPet.responsibleName, equals('João Silva'));
      expect(testPet.phone, equals('87 99999-8888'));
      expect(testPet.imagePath, equals('assets/images/rex.jpg'));
      expect(testPet.createdBy, equals('user123'));
      expect(testPet.createdByEmail, equals('joao@email.com'));
    });

    test('deve retornar nome da espécie formatado corretamente', () {
      expect(testPet.speciesDisplayName, equals('Cão'));

      final catPet = Pet(
        name: 'Luna',
        location: 'Garanhuns, PE',
        age: '2 anos',
        species: 'cats',
        gender: 'F',
        isVaccinated: false,
        description: 'Gata calma e independente',
        responsibleName: 'Maria Santos',
        phone: '87 88888-7777',
      );

      expect(catPet.speciesDisplayName, equals('Gato'));
    });

    test('deve retornar status de vacinação formatado', () {
      expect(testPet.vaccinationStatus, equals('SIM'));

      final unvaccinatedPet = Pet(
        name: 'Buddy',
        location: 'Garanhuns, PE',
        age: '1 ano',
        species: 'dogs',
        gender: 'M',
        isVaccinated: false,
        description: 'Cão jovem e energético',
        responsibleName: 'Ana Costa',
        phone: '87 77777-6666',
      );

      expect(unvaccinatedPet.vaccinationStatus, equals('NÃO'));
    });

    test('deve retornar nome do sexo formatado corretamente', () {
      expect(testPet.genderDisplayName, equals('Macho'));

      final femalePet = Pet(
        name: 'Lola',
        location: 'Garanhuns, PE',
        age: '4 anos',
        species: 'dogs',
        gender: 'F',
        isVaccinated: true,
        description: 'Cadela dócil e carinhosa',
        responsibleName: 'Pedro Oliveira',
        phone: '87 66666-5555',
      );

      expect(femalePet.genderDisplayName, equals('Fêmea'));
    });

    test('deve gerar mensagem do WhatsApp corretamente', () {
      final whatsappMessage = testPet.generateWhatsAppMessage();
      
      expect(whatsappMessage, contains('*Rex* está disponível para adoção!'));
      expect(whatsappMessage, contains('*Localização:* Garanhuns, PE'));
      expect(whatsappMessage, contains('*Contato:* 87 99999-8888'));
      expect(whatsappMessage, contains('*Responsável:* João Silva'));
      expect(whatsappMessage, contains('- Espécie: Cão'));
      expect(whatsappMessage, contains('- Idade: 3 anos'));
      expect(whatsappMessage, contains('- Sexo: Macho'));
      expect(whatsappMessage, contains('- Vacinado: SIM'));
      expect(whatsappMessage, contains('Cão muito carinhoso e brincalhão'));
      expect(whatsappMessage, contains('Adote com amor!'));
    });

    test('deve converter para JSON corretamente', () {
      final json = testPet.toJson();

      expect(json['name'], equals('Rex'));
      expect(json['location'], equals('Garanhuns, PE'));
      expect(json['age'], equals('3 anos'));
      expect(json['species'], equals('dogs'));
      expect(json['gender'], equals('M'));
      expect(json['isVaccinated'], isTrue);
      expect(json['description'], equals('Cão muito carinhoso e brincalhão'));
      expect(json['responsibleName'], equals('João Silva'));
      expect(json['phone'], equals('87 99999-8888'));
      expect(json['imagePath'], equals('assets/images/rex.jpg'));
      expect(json['createdBy'], equals('user123'));
      expect(json['createdByEmail'], equals('joao@email.com'));
    });

    test('deve criar Pet a partir de JSON', () {
      final json = {
        'id': 'json_pet_456',
        'name': 'Bella',
        'location': 'Recife, PE',
        'age': '5 anos',
        'species': 'cats',
        'gender': 'F',
        'isVaccinated': false,
        'description': 'Gata independente e carinhosa',
        'responsibleName': 'Carlos Lima',
        'phone': '81 55555-4444',
        'imagePath': 'assets/images/bella.jpg',
        'createdBy': 'user456',
        'createdByEmail': 'carlos@email.com',
        'createdAt': Timestamp.fromDate(DateTime.parse('2024-02-20 14:45:00')),
      };

      final petFromJson = Pet.fromJson(json);

      expect(petFromJson.id, equals('json_pet_456'));
      expect(petFromJson.name, equals('Bella'));
      expect(petFromJson.location, equals('Recife, PE'));
      expect(petFromJson.species, equals('cats'));
      expect(petFromJson.speciesDisplayName, equals('Gato'));
      expect(petFromJson.gender, equals('F'));
      expect(petFromJson.genderDisplayName, equals('Fêmea'));
      expect(petFromJson.isVaccinated, isFalse);
      expect(petFromJson.vaccinationStatus, equals('NÃO'));
    });

    test('deve verificar se usuário é dono do pet', () {
      expect(testPet.isOwnedByCurrentUser('user123'), isTrue);
      expect(testPet.isOwnedByCurrentUser('other_user'), isFalse);
      expect(testPet.isOwnedByCurrentUser(null), isFalse);
      
      final petWithoutOwner = Pet(
        name: 'Stray',
        location: 'Garanhuns, PE',
        age: '2 anos',
        species: 'dogs',
        gender: 'M',
        isVaccinated: false,
        description: 'Cão sem dono',
        responsibleName: 'Abrigo Local',
        phone: '87 11111-2222',
      );

      expect(petWithoutOwner.isOwnedByCurrentUser('any_user'), isFalse);
    });

    test('deve lidar com campos opcionais corretamente', () {
      final minimalPet = Pet(
        name: 'Minimal',
        location: 'Garanhuns, PE',
        age: '1 ano',
        species: 'dogs',
        gender: 'M',
        isVaccinated: true,
        description: 'Pet básico',
        responsibleName: 'Test User',
        phone: '87 00000-0000',
      );

      expect(minimalPet.id, isNull);
      expect(minimalPet.imagePath, isNull);
      expect(minimalPet.createdBy, isNull);
      expect(minimalPet.createdByEmail, isNull);
      expect(minimalPet.createdAt, isNull);
      expect(minimalPet.isOwnedByCurrentUser('any_user'), isFalse);
    });
  });
}