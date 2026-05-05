class ClothingProvider with ChangeNotifier {
  final ClothingService service;

  ClothingProvider(this.service);

  List<Clothing> _items = [];

  List<Clothing> get items => _items;

  Future<void> loadClothes(String userId) async {
    _items = await service.getUserClothes(userId);
    notifyListeners();
  }

  Future<void> addClothing(Clothing item) async {
    await service.addClothing(item);
    _items.add(item);
    notifyListeners();
  }
}