import 'package:flutter/material.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({super.key});

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'Todos';

  final List<String> categories = [
    'Todos',
    'Camiseta',
    'Calça',
    'Tênis',
    'Jaqueta',
  ];

  final List<Map<String, dynamic>> clothes = [
    {
      'name': 'Camiseta Branca',
      'category': 'Camiseta',
      'image': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    },
    {
      'name': 'Calça Jeans Rasgada',
      'category': 'Calça',
      'image': 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246',
    },
    {
      'name': 'Tênis Vermelho',
      'category': 'Tênis',
      'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
    },
    {
      'name': 'Jaqueta Verde',
      'category': 'Jaqueta',
      'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredClothes = clothes.where((item) {
      final matchesSearch = item['name']
          .toString()
          .toLowerCase()
          .contains(searchController.text.toLowerCase());

      final matchesCategory =
          selectedCategory == 'Todos' || item['category'] == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Armário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Pesquisar roupa...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list, size: 30),
                  onSelected: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  itemBuilder: (context) {
                    return categories.map((category) {
                      return PopupMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: filteredClothes.isEmpty
                  ? const Center(
                child: Text(
                  'Nenhuma roupa encontrada',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: filteredClothes.length,
                itemBuilder: (context, index) {
                  final clothing = filteredClothes[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.network(
                                clothing['image'],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clothing['name'],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    clothing['category'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}