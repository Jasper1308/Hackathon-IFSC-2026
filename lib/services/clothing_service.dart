import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/clothing_model.dart';

class ClothingService {
  final supabase = Supabase.instance.client;

  Future<String> uploadImage(
      File imageFile,
      ) async {
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}.jpg';

    await supabase.storage
        .from('images')
        .upload(
      fileName,
      imageFile,
    );

    final imageUrl = supabase.storage
        .from('images')
        .getPublicUrl(fileName);

    return imageUrl;
  }

  Future<void> addClothing(
      Clothing item,
      ) async {
    await supabase
        .from('clothes')
        .insert(
      item.toJson(),
    );
  }

  Future<List<Clothing>> getUserClothes(
      String userId,
      ) async {
    final response = await supabase
        .from('clothes')
        .select()
        .eq('user_id', userId);

    return (response as List)
        .map(
          (item) => Clothing.fromJson(
        item['id'],
        item,
      ),
    )
        .toList();
  }

  Future<List<Clothing>>
  getCommunityClothes(
      String userId,
      ) async {
    final response = await supabase
        .from('clothes')
        .select()
        .eq('disponivel', true)
        .neq('user_id', userId);

    return (response as List)
        .map(
          (item) => Clothing.fromJson(
        item['id'],
        item,
      ),
    )
        .toList();
  }
}
