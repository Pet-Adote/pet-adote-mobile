import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Upload da foto de perfil do usuário
  Future<String?> uploadUserProfileImage(File imageFile) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      final fileName = 'profile_${currentUser.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child('user_profiles').child(fileName);
      
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      // Salvar a URL no documento do usuário
      await _firestore.collection('users').doc(currentUser.uid).set({
        'profileImageUrl': downloadUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      return downloadUrl;
    } catch (e) {
      print('Erro ao fazer upload da imagem do perfil: $e');
      throw Exception('Falha ao fazer upload da imagem do perfil');
    }
  }

  /// Obter a URL da foto de perfil do usuário
  Future<String?> getUserProfileImageUrl() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return null;
      }

      final doc = await _firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists) {
        final data = doc.data();
        return data?['profileImageUrl'] as String?;
      }
      
      return null;
    } catch (e) {
      print('Erro ao obter imagem do perfil: $e');
      return null;
    }
  }

  /// Deletar a foto de perfil do usuário
  Future<void> deleteUserProfileImage() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      // Obter a URL atual da imagem
      final currentImageUrl = await getUserProfileImageUrl();
      
      if (currentImageUrl != null && currentImageUrl.isNotEmpty) {
        // Deletar o arquivo do Storage
        final ref = _storage.refFromURL(currentImageUrl);
        await ref.delete();
      }

      // Remover a URL do Firestore
      await _firestore.collection('users').doc(currentUser.uid).update({
        'profileImageUrl': FieldValue.delete(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erro ao deletar imagem do perfil: $e');
      throw Exception('Falha ao deletar imagem do perfil');
    }
  }

  /// Atualizar informações do usuário
  Future<void> updateUserInfo({
    String? displayName,
    String? profileImageUrl,
  }) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('Usuário não autenticado');
      }

      final Map<String, dynamic> updateData = {
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (displayName != null) {
        updateData['displayName'] = displayName;
        // Atualizar também no Firebase Auth
        await currentUser.updateDisplayName(displayName);
      }

      if (profileImageUrl != null) {
        updateData['profileImageUrl'] = profileImageUrl;
      }

      await _firestore.collection('users').doc(currentUser.uid).set(
        updateData,
        SetOptions(merge: true),
      );
    } catch (e) {
      print('Erro ao atualizar informações do usuário: $e');
      throw Exception('Falha ao atualizar informações do usuário');
    }
  }

  /// Obter informações completas do usuário
  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return null;
      }

      final doc = await _firestore.collection('users').doc(currentUser.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        
        // Combinar dados do Auth com dados do Firestore
        return {
          'uid': currentUser.uid,
          'email': currentUser.email,
          'displayName': data['displayName'] ?? currentUser.displayName ?? currentUser.email?.split('@')[0] ?? 'Usuário',
          'profileImageUrl': data['profileImageUrl'],
          'createdAt': data['createdAt'],
          'updatedAt': data['updatedAt'],
        };
      }
      
      // Se não existe documento no Firestore, retornar dados básicos do Auth
      return {
        'uid': currentUser.uid,
        'email': currentUser.email,
        'displayName': currentUser.displayName ?? currentUser.email?.split('@')[0] ?? 'Usuário',
        'profileImageUrl': null,
      };
    } catch (e) {
      print('Erro ao obter informações do usuário: $e');
      return null;
    }
  }
}
