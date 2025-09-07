import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  SupabaseStorageService();

  Future<String> uploadFile(File file) async {
    final supabase = Supabase.instance.client;
    final fileName = file.uri.pathSegments.last;
    await supabase.storage.from('pets').upload(
      fileName,
      file,
      fileOptions: const FileOptions(upsert: true),
    );
    return supabase.storage.from('pets').getPublicUrl(fileName);
  }
}

