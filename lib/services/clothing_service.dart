import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/clothing_model.dart';

class ClothingService {
  final supabase = Supabase.instance.client;

  Future<void> addClothing(Clothing item) async {
    await supabase.from('clothes').insert(item.toJson());
  }

  Future<List<Clothing>> getUserClothes(String userId) async {
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

  Future<List<Clothing>> getCommunityClothes(String userId) async {
    final response = await supabase
        .from('clothes')
        .select()
        .eq('available', true)
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