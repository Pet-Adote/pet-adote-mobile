import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pet_model.dart';

class FirebasePetRepository {
  static const String _petsCollection = 'pets';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Salvar um pet no Firestore
  Future<bool> savePet(Pet pet) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Usuário não autenticado');
        return false;
      }

      // Adicionar informações do usuário que cadastrou o pet
      final petData = pet.toJson();
      petData['createdBy'] = user.uid;
      petData['createdByEmail'] = user.email;
      petData['createdAt'] = FieldValue.serverTimestamp();

      await _firestore.collection(_petsCollection).add(petData);
      return true;
    } catch (e) {
      print('Erro ao salvar pet no Firestore: $e');
      return false;
    }
  }

  // Obter todos os pets (global - todos os usuários podem ver)
  Future<List<Pet>> getAllPets() async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_petsCollection)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Adicionar o ID do documento
        return Pet.fromJson(data);
      }).toList();
    } catch (e) {
      print('Erro ao carregar pets do Firestore: $e');
      return [];
    }
  }

  // Obter pets por espécie (global - todos os usuários podem ver)
  Future<List<Pet>> getPetsBySpecies(String species) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_petsCollection)
          .where('species', isEqualTo: species)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Adicionar o ID do documento
        return Pet.fromJson(data);
      }).toList();
    } catch (e) {
      print('Erro ao carregar pets por espécie do Firestore: $e');
      return [];
    }
  }

  // Obter pets do usuário atual (apenas os que ele criou)
  Future<List<Pet>> getUserPets() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Usuário não autenticado');
        return [];
      }

      final QuerySnapshot querySnapshot = await _firestore
          .collection(_petsCollection)
          .where('createdBy', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Adicionar o ID do documento
        return Pet.fromJson(data);
      }).toList();
    } catch (e) {
      print('Erro ao carregar pets do usuário do Firestore: $e');
      return [];
    }
  }

  // Deletar um pet (apenas o criador pode deletar)
  Future<bool> deletePet(String petId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Usuário não autenticado');
        return false;
      }

      // Verificar se o pet pertence ao usuário
      final DocumentSnapshot doc = await _firestore
          .collection(_petsCollection)
          .doc(petId)
          .get();

      if (!doc.exists) {
        print('Pet não encontrado');
        return false;
      }

      final data = doc.data() as Map<String, dynamic>;
      if (data['createdBy'] != user.uid) {
        print('Usuário não tem permissão para deletar este pet');
        return false;
      }

      await _firestore.collection(_petsCollection).doc(petId).delete();
      return true;
    } catch (e) {
      print('Erro ao deletar pet do Firestore: $e');
      return false;
    }
  }

  // Atualizar um pet (apenas o criador pode atualizar)
  Future<bool> updatePet(String petId, Pet updatedPet) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Usuário não autenticado');
        return false;
      }

      // Verificar se o pet pertence ao usuário
      final DocumentSnapshot doc = await _firestore
          .collection(_petsCollection)
          .doc(petId)
          .get();

      if (!doc.exists) {
        print('Pet não encontrado');
        return false;
      }

      final data = doc.data() as Map<String, dynamic>;
      if (data['createdBy'] != user.uid) {
        print('Usuário não tem permissão para atualizar este pet');
        return false;
      }

      final petData = updatedPet.toJson();
      petData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection(_petsCollection).doc(petId).update(petData);
      return true;
    } catch (e) {
      print('Erro ao atualizar pet no Firestore: $e');
      return false;
    }
  }

  // Verificar se um pet com os mesmos dados já existe
  Future<bool> petExists(Pet pet) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_petsCollection)
          .where('name', isEqualTo: pet.name)
          .where('location', isEqualTo: pet.location)
          .where('phone', isEqualTo: pet.phone)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Erro ao verificar se pet existe no Firestore: $e');
      return false;
    }
  }

  // Stream para ouvir mudanças em tempo real (todos os pets)
  Stream<List<Pet>> getAllPetsStream() {
    return _firestore
        .collection(_petsCollection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Pet.fromJson(data);
      }).toList();
    });
  }

  // Stream para ouvir mudanças por espécie em tempo real
  Stream<List<Pet>> getPetsBySpeciesStream(String species) {
    return _firestore
        .collection(_petsCollection)
        .where('species', isEqualTo: species)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Pet.fromJson(data);
      }).toList();
    });
  }
}