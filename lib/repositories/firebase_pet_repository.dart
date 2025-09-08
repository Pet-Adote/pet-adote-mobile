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

  // Obter pets do usuário atual (incluindo pets antigos e novos)
  Future<List<Pet>> getUserPets() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        print('Usuário não autenticado');
        return [];
      }

      Set<String> petIds = {}; // Para evitar duplicatas
      List<Pet> allUserPets = [];

      // 1. Buscar pets com createdBy (pets novos) - sem ordenação para evitar índice composto
      try {
        final QuerySnapshot querySnapshotById = await _firestore
            .collection(_petsCollection)
            .where('createdBy', isEqualTo: user.uid)
            .get();

        for (var doc in querySnapshotById.docs) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          petIds.add(doc.id);
          allUserPets.add(Pet.fromJson(data));
        }
        print('Encontrados ${querySnapshotById.docs.length} pets com createdBy');
      } catch (e) {
        print('Erro ao buscar pets por createdBy: $e');
      }

      // 2. Buscar pets com createdByEmail (pets que podem ser antigos) - sem ordenação
      if (user.email != null) {
        try {
          final QuerySnapshot querySnapshotByEmail = await _firestore
              .collection(_petsCollection)
              .where('createdByEmail', isEqualTo: user.email)
              .get();

          for (var doc in querySnapshotByEmail.docs) {
            // Evitar duplicatas
            if (!petIds.contains(doc.id)) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              petIds.add(doc.id);
              allUserPets.add(Pet.fromJson(data));
            }
          }
          print('Encontrados ${querySnapshotByEmail.docs.length} pets adicionais com createdByEmail');
        } catch (e) {
          print('Erro ao buscar pets por createdByEmail: $e');
        }
      }

      // 3. Fallback: buscar todos os pets e filtrar aqueles que podem pertencer ao usuário
      // (para pets muito antigos sem campos de identificação)
      if (allUserPets.isEmpty && user.email != null) {
        try {
          print('Tentando buscar pets legados...');
          // Buscar todos os pets recentes (limitado para evitar overhead)
          final QuerySnapshot querySnapshotAll = await _firestore
              .collection(_petsCollection)
              .orderBy('createdAt', descending: true)
              .limit(100)
              .get();

          int legacyPetsFound = 0;
          for (var doc in querySnapshotAll.docs) {
            final data = doc.data() as Map<String, dynamic>;
            
            // Se já está na lista, pular
            if (petIds.contains(doc.id)) continue;
            
            // Se não tem createdBy nem createdByEmail, pode ser um pet legado
            if (data['createdBy'] == null && data['createdByEmail'] == null) {
              data['id'] = doc.id;
              
              // Atualizar o documento para incluir createdBy
              try {
                await _firestore.collection(_petsCollection).doc(doc.id).update({
                  'createdBy': user.uid,
                  'createdByEmail': user.email,
                });
                
                petIds.add(doc.id);
                allUserPets.add(Pet.fromJson(data));
                legacyPetsFound++;
                print('Pet legado ${data['name']} atribuído ao usuário');
              } catch (updateError) {
                print('Erro ao atualizar pet legado ${doc.id}: $updateError');
                // Adicionar mesmo sem conseguir atualizar
                petIds.add(doc.id);
                allUserPets.add(Pet.fromJson(data));
                legacyPetsFound++;
              }
            }
          }
          print('Encontrados $legacyPetsFound pets legados');
        } catch (e) {
          print('Erro ao buscar pets legados: $e');
        }
      }

      // Ordenar por data de criação (mais recente primeiro)
      allUserPets.sort((a, b) {
        // Se ambos têm timestamp, comparar
        if (a.createdAt != null && b.createdAt != null) {
          return b.createdAt!.compareTo(a.createdAt!);
        }
        // Se apenas um tem timestamp, priorizar o que tem
        if (a.createdAt != null) return -1;
        if (b.createdAt != null) return 1;
        // Se nenhum tem timestamp, manter ordem atual
        return 0;
      });

      print('Total encontrado: ${allUserPets.length} pets para o usuário ${user.email}');
      return allUserPets;
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