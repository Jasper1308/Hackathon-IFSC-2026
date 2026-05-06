import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clothing_model.dart';

class ClothingService {
  final collection = FirebaseFirestore.instance.collection('clothes');

  Future<void> addClothing(Clothing item) async {
    await collection.add(item.toJson());
  }

  Future<List<Clothing>> getUserClothes(String userId) async {
    final snapshot =
    await collection.where('userId', isEqualTo: userId).get();

    return snapshot.docs
        .map((doc) => Clothing.fromJson(doc.id, doc.data()))
        .toList();
  }

  Future<List<Clothing>> getCommunityClothes(String userId) async {
    final snapshot =
    await collection.where('disponivel', isEqualTo: true).get();

    return snapshot.docs
        .where((doc) => doc['userId'] != userId)
        .map((doc) => Clothing.fromJson(doc.id, doc.data()))
        .toList();
  }
}