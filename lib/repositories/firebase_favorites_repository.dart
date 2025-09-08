import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pet_model.dart';

class FirebaseFavoritesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Adicionar um pet aos favoritos do usuário
  Future<bool> addToFavorites(String petId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(petId)
          .set({
        'petId': petId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      print('Erro ao adicionar favorito: $e');
      return false;
    }
  }

  // Remover um pet dos favoritos do usuário
  Future<bool> removeFromFavorites(String petId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(petId)
          .delete();

      return true;
    } catch (e) {
      print('Erro ao remover favorito: $e');
      return false;
    }
  }

  // Verificar se um pet está nos favoritos do usuário
  Future<bool> isFavorite(String petId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      final doc = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(petId)
          .get();

      return doc.exists;
    } catch (e) {
      print('Erro ao verificar favorito: $e');
      return false;
    }
  }

  // Obter todos os pets favoritos do usuário
  Future<List<Pet>> getFavoritePets() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return [];

      // Obter IDs dos pets favoritos
      final favoritesSnapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .orderBy('createdAt', descending: true)
          .get();

      if (favoritesSnapshot.docs.isEmpty) return [];

      final petIds = favoritesSnapshot.docs
          .map((doc) => doc.data()['petId'] as String)
          .toList();

      // Obter detalhes dos pets favoritos
      final List<Pet> favoritePets = [];
      
      for (String petId in petIds) {
        final petDoc = await _firestore.collection('pets').doc(petId).get();
        if (petDoc.exists) {
          final petData = petDoc.data()!;
          final pet = Pet(
            id: petDoc.id,
            name: petData['name'] ?? '',
            location: petData['location'] ?? '',
            age: petData['age'] ?? '',
            species: petData['species'] ?? '',
            gender: petData['gender'] ?? '',
            isVaccinated: petData['isVaccinated'] ?? false,
            description: petData['description'] ?? '',
            responsibleName: petData['responsibleName'] ?? '',
            phone: petData['phone'] ?? '',
            createdBy: petData['createdBy'] ?? '',
            createdByEmail: petData['createdByEmail'] ?? '',
          );
          favoritePets.add(pet);
        }
      }

      return favoritePets;
    } catch (e) {
      print('Erro ao obter pets favoritos: $e');
      return [];
    }
  }

  // Stream para monitorar mudanças nos favoritos
  Stream<List<String>> getFavoriteIdsStream() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => doc.data()['petId'] as String)
            .toList());
  }

  // Alternar status de favorito (adicionar se não está, remover se está)
  Future<bool> toggleFavorite(String petId) async {
    try {
      final isFav = await isFavorite(petId);
      
      if (isFav) {
        return await removeFromFavorites(petId);
      } else {
        return await addToFavorites(petId);
      }
    } catch (e) {
      print('Erro ao alternar favorito: $e');
      return false;
    }
  }
}