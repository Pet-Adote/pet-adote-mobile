import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/pet_model.dart';

class PetRepository {
  static const String _petsKey = 'saved_pets';

  // Salvar um pet
  Future<bool> savePet(Pet pet) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final pets = await getAllPets();
      
      // Adicionar o novo pet à lista
      pets.add(pet);
      
      // Converter a lista para JSON e salvar
      final petsJsonList = pets.map((pet) => pet.toJson()).toList();
      final jsonString = jsonEncode(petsJsonList);
      
      return await prefs.setString(_petsKey, jsonString);
    } catch (e) {
      print('Erro ao salvar pet: $e');
      return false;
    }
  }

  // Obter todos os pets salvos
  Future<List<Pet>> getAllPets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_petsKey);
      
      if (jsonString == null || jsonString.isEmpty) {
        return [];
      }
      
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Pet.fromJson(json)).toList();
    } catch (e) {
      print('Erro ao carregar pets: $e');
      return [];
    }
  }

  // Obter pets por espécie
  Future<List<Pet>> getPetsBySpecies(String species) async {
    final allPets = await getAllPets();
    return allPets.where((pet) => pet.species == species).toList();
  }

  // Deletar um pet específico
  Future<bool> deletePet(Pet petToDelete) async {
    try {
      final pets = await getAllPets();
      
      // Remover o pet baseado em nome, localização e telefone (identificadores únicos)
      pets.removeWhere((pet) => 
        pet.name == petToDelete.name &&
        pet.location == petToDelete.location &&
        pet.phone == petToDelete.phone
      );
      
      // Salvar a lista atualizada
      final prefs = await SharedPreferences.getInstance();
      final petsJsonList = pets.map((pet) => pet.toJson()).toList();
      final jsonString = jsonEncode(petsJsonList);
      
      return await prefs.setString(_petsKey, jsonString);
    } catch (e) {
      print('Erro ao deletar pet: $e');
      return false;
    }
  }

  // Atualizar um pet
  Future<bool> updatePet(Pet oldPet, Pet newPet) async {
    try {
      final pets = await getAllPets();
      
      // Encontrar e atualizar o pet
      final index = pets.indexWhere((pet) => 
        pet.name == oldPet.name &&
        pet.location == oldPet.location &&
        pet.phone == oldPet.phone
      );
      
      if (index != -1) {
        pets[index] = newPet;
        
        // Salvar a lista atualizada
        final prefs = await SharedPreferences.getInstance();
        final petsJsonList = pets.map((pet) => pet.toJson()).toList();
        final jsonString = jsonEncode(petsJsonList);
        
        return await prefs.setString(_petsKey, jsonString);
      }
      
      return false;
    } catch (e) {
      print('Erro ao atualizar pet: $e');
      return false;
    }
  }

  // Limpar todos os pets (útil para desenvolvimento/debug)
  Future<bool> clearAllPets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_petsKey);
    } catch (e) {
      print('Erro ao limpar pets: $e');
      return false;
    }
  }

  // Verificar se um pet específico já existe
  Future<bool> petExists(Pet pet) async {
    final pets = await getAllPets();
    return pets.any((existingPet) => 
      existingPet.name == pet.name &&
      existingPet.location == pet.location &&
      existingPet.phone == pet.phone
    );
  }
}