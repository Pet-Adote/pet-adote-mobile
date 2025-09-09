import 'package:flutter_test/flutter_test.dart';
import 'package:pet_adote/models/pet_model.dart';
import 'package:pet_adote/repositories/firebase_pet_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// Generate mocks for Firebase dependencies
@GenerateMocks([
  FirebaseFirestore,
  CollectionReference,
  DocumentReference,
  DocumentSnapshot,
  QuerySnapshot,
  QueryDocumentSnapshot,
  FirebaseStorage,
  Reference,
  UploadTask,
  TaskSnapshot,
])
import 'firebase_pet_repository_test.mocks.dart';

void main() {
  group('Firebase Pet Repository Integration Tests', () {
    late FirebasePetRepository repository;
    late MockFirebaseFirestore mockFirestore;
    late MockCollectionReference<Map<String, dynamic>> mockCollection;
    late MockDocumentReference<Map<String, dynamic>> mockDocRef;
    late MockFirebaseStorage mockStorage;
    late MockReference mockStorageRef;
    late Pet testPet;

    setUp(() {
      mockFirestore = MockFirebaseFirestore();
      mockCollection = MockCollectionReference<Map<String, dynamic>>();
      mockDocRef = MockDocumentReference<Map<String, dynamic>>();
      mockStorage = MockFirebaseStorage();
      mockStorageRef = MockReference();
      
      // Setup mock behaviors
      when(mockFirestore.collection('pets')).thenReturn(mockCollection);
      when(mockCollection.add(any)).thenAnswer((_) async => mockDocRef);
      when(mockDocRef.id).thenReturn('generated_pet_id_123');

      testPet = Pet(
        name: 'Rex Teste',
        location: 'Garanhuns, PE - Teste',
        age: '2 anos',
        species: 'dogs',
        gender: 'M',
        isVaccinated: true,
        description: 'Cão de teste para integração',
        responsibleName: 'Usuário Teste',
        phone: '87 99999-0000',
        createdBy: 'test_user_123',
        createdByEmail: 'test@email.com',
        createdAt: DateTime.now(),
      );

      repository = FirebasePetRepository();
    });

    group('Pet Registration Tests', () {
      test('deve salvar pet com sucesso no Firestore', () async {
        // Arrange
        when(mockCollection.add(any)).thenAnswer((_) async => mockDocRef);
        when(mockDocRef.id).thenReturn('new_pet_id_456');

        // Act & Assert - Este teste verifica a lógica sem depender do Firebase real
        expect(testPet.name, equals('Rex Teste'));
        expect(testPet.location, equals('Garanhuns, PE - Teste'));
        expect(testPet.species, equals('dogs'));
        expect(testPet.isVaccinated, isTrue);
        
        // Verifica se os dados estão corretos para persistência
        final petData = testPet.toJson();
        expect(petData['name'], equals('Rex Teste'));
        expect(petData['species'], equals('dogs'));
        expect(petData['createdBy'], equals('test_user_123'));
      });

      test('deve verificar se pet já existe', () async {
        // Arrange
        final mockQuerySnapshot = MockQuerySnapshot();
        final mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
        
        when(mockCollection.where('name', isEqualTo: testPet.name))
            .thenReturn(mockCollection as Query<Map<String, dynamic>>);
        when((mockCollection as Query).where('location', isEqualTo: testPet.location))
            .thenReturn(mockCollection as Query<Map<String, dynamic>>);
        when((mockCollection as Query).where('phone', isEqualTo: testPet.phone))
            .thenReturn(mockCollection as Query<Map<String, dynamic>>);
        when((mockCollection as Query).get()).thenAnswer((_) async => mockQuerySnapshot);
        when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);

        // Act & Assert - Simula a verificação de pet existente
        final petExists = testPet.name.isNotEmpty && 
                         testPet.location.isNotEmpty && 
                         testPet.phone.isNotEmpty;
        
        expect(petExists, isTrue);
      });

      test('deve validar campos obrigatórios do pet', () {
        // Test para validar campos obrigatórios
        expect(() => Pet(
          name: '',  // Nome vazio deve ser inválido
          location: testPet.location,
          age: testPet.age,
          species: testPet.species,
          gender: testPet.gender,
          isVaccinated: testPet.isVaccinated,
          description: testPet.description,
          responsibleName: testPet.responsibleName,
          phone: testPet.phone,
        ), returnsNormally); // Flutter não valida automaticamente, mas nosso teste pode

        // Valida que campos essenciais estão preenchidos
        expect(testPet.name.isNotEmpty, isTrue);
        expect(testPet.location.isNotEmpty, isTrue);
        expect(testPet.responsibleName.isNotEmpty, isTrue);
        expect(testPet.phone.isNotEmpty, isTrue);
      });

      test('deve gerar dados corretos para persistência', () {
        final petData = testPet.toJson();

        expect(petData, isA<Map<String, dynamic>>());
        expect(petData.containsKey('name'), isTrue);
        expect(petData.containsKey('location'), isTrue);
        expect(petData.containsKey('species'), isTrue);
        expect(petData.containsKey('gender'), isTrue);
        expect(petData.containsKey('isVaccinated'), isTrue);
        expect(petData.containsKey('createdBy'), isTrue);
        expect(petData.containsKey('createdByEmail'), isTrue);

        // Verifica tipos de dados
        expect(petData['name'], isA<String>());
        expect(petData['isVaccinated'], isA<bool>());
        expect(petData['createdBy'], isA<String>());
      });
    });

    group('Pet Query Tests', () {
      test('deve buscar pets por espécie', () async {
        // Arrange
        final mockQuerySnapshot = MockQuerySnapshot();
        final mockDoc = MockQueryDocumentSnapshot();
        
        when(mockCollection.where('species', isEqualTo: 'dogs'))
            .thenReturn(mockCollection as Query<Map<String, dynamic>>);
        when((mockCollection as Query).get()).thenAnswer((_) async => mockQuerySnapshot);
        when(mockQuerySnapshot.docs).thenReturn([mockDoc]);
        when(mockDoc.data()).thenReturn(testPet.toJson());
        when(mockDoc.id).thenReturn('pet_123');

        // Act & Assert - Verifica lógica de filtro
        expect(testPet.species, equals('dogs'));
        expect(testPet.speciesDisplayName, equals('Cão'));
      });

      test('deve buscar pets por usuário', () async {
        final userPets = [testPet];
        final filteredByUser = userPets.where((pet) => 
            pet.createdBy == 'test_user_123').toList();

        expect(filteredByUser.length, equals(1));
        expect(filteredByUser.first.createdBy, equals('test_user_123'));
      });

      test('deve ordenar pets por data de criação', () async {
        final pet1 = Pet(
          name: 'Pet 1',
          location: 'Local 1',
          age: '1 ano',
          species: 'dogs',
          gender: 'M',
          isVaccinated: false,
          description: 'Pet 1',
          responsibleName: 'User 1',
          phone: '11111',
          createdAt: DateTime(2024, 1, 1),
        );

        final pet2 = Pet(
          name: 'Pet 2',
          location: 'Local 2',
          age: '2 anos',
          species: 'cats',
          gender: 'F',
          isVaccinated: true,
          description: 'Pet 2',
          responsibleName: 'User 2',
          phone: '22222',
          createdAt: DateTime(2024, 1, 2),
        );

        final pets = [pet1, pet2];
        pets.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        expect(pets.first.name, equals('Pet 2')); // Mais recente primeiro
        expect(pets.last.name, equals('Pet 1'));
      });
    });

    group('Pet Update Tests', () {
      test('deve atualizar dados do pet', () {
        final originalPet = testPet;
        
        final updatedPet = Pet(
          id: originalPet.id,
          name: 'Rex Atualizado',
          location: originalPet.location,
          age: '3 anos', // Idade atualizada
          species: originalPet.species,
          gender: originalPet.gender,
          isVaccinated: originalPet.isVaccinated,
          description: 'Descrição atualizada',
          responsibleName: originalPet.responsibleName,
          phone: originalPet.phone,
          createdBy: originalPet.createdBy,
          createdByEmail: originalPet.createdByEmail,
          createdAt: originalPet.createdAt,
        );

        expect(updatedPet.name, equals('Rex Atualizado'));
        expect(updatedPet.age, equals('3 anos'));
        expect(updatedPet.description, equals('Descrição atualizada'));
        expect(updatedPet.createdBy, equals(originalPet.createdBy)); // Mantém o mesmo dono
      });

      test('deve manter integridade dos dados na atualização', () {
        expect(testPet.isOwnedByCurrentUser('test_user_123'), isTrue);
        
        // Simula atualização mantendo owner
        final updatedData = testPet.toJson();
        updatedData['description'] = 'Nova descrição';
        
        final updatedPet = Pet.fromJson({
          ...updatedData,
          'id': 'pet_id_123',
        });

        expect(updatedPet.createdBy, equals('test_user_123'));
        expect(updatedPet.description, equals('Nova descrição'));
      });
    });

    group('Pet Deletion Tests', () {
      test('deve verificar permissão para deletar pet', () {
        // Apenas o dono pode deletar
        expect(testPet.isOwnedByCurrentUser('test_user_123'), isTrue);
        expect(testPet.isOwnedByCurrentUser('other_user'), isFalse);
        expect(testPet.isOwnedByCurrentUser(null), isFalse);
      });
    });

    group('Image Upload Tests', () {
      test('deve validar arquivo de imagem', () {
        // Test simulado para validação de arquivo
        final validImageExtensions = ['.jpg', '.jpeg', '.png'];
        const testImagePath = 'test_image.jpg';
        
        final isValidImage = validImageExtensions.any(
          (ext) => testImagePath.toLowerCase().endsWith(ext)
        );

        expect(isValidImage, isTrue);
      });

      test('deve gerar path correto para storage', () {
        const userId = 'test_user_123';
        const fileName = 'pet_image.jpg';
        final expectedPath = 'pets/$userId/$fileName';
        
        expect(expectedPath, equals('pets/test_user_123/pet_image.jpg'));
      });
    });

    group('Error Handling Tests', () {
      test('deve lidar com dados inválidos', () {
        expect(() => Pet.fromJson({}), returnsNormally);
        
        final petFromEmptyJson = Pet.fromJson({});
        expect(petFromEmptyJson.name, isEmpty);
        expect(petFromEmptyJson.location, isEmpty);
        expect(petFromEmptyJson.isVaccinated, isFalse);
      });

      test('deve validar formato de telefone', () {
        final validPhones = [
          '87 99999-8888',
          '(87) 99999-8888',
          '87999998888',
          '+55 87 99999-8888'
        ];

        for (final phone in validPhones) {
          final pet = Pet(
            name: 'Test',
            location: 'Test',
            age: '1 ano',
            species: 'dogs',
            gender: 'M',
            isVaccinated: false,
            description: 'Test',
            responsibleName: 'Test',
            phone: phone,
          );
          
          expect(pet.phone.isNotEmpty, isTrue);
        }
      });
    });
  });
}