import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums/clothing_category.dart';
import '../enums/clothing_type.dart';
import '../enums/color.dart';
import '../enums/occasion.dart';
import '../enums/style.dart';
import '../enums/weather.dart';
import '../models/clothing_model.dart';
import '../providers/clothing_provider.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() =>
      _AddClothingScreenState();
}

class _AddClothingScreenState
    extends State<AddClothingScreen> {
  final nomeController =
  TextEditingController();

  File? selectedImage;

  ClothingCategory selectedCategory =
      ClothingCategory.masculino;

  ClothingType selectedType =
      ClothingType.camiseta;

  Cores selectedColor =
      Cores.preto;

  Style selectedStyle =
      Style.casual;

  List<Weather> selectedWeather = [];

  List<Occasion> selectedOccasions = [];

  bool available = false;

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    setState(() {
      selectedImage = File(image.path);
    });
  }

  Future<void> submit() async {
    if (selectedImage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Selecione uma imagem',
          ),
        ),
      );

      return;
    }

    final user =
        Supabase.instance.client.auth.currentUser;

    if (user == null) return;

    final clothing = Clothing(
      id: '',
      userId: user.id,
      nome: nomeController.text.trim(),
      categoria: selectedCategory,
      tipo: selectedType,
      cor: selectedColor,
      estilo: selectedStyle,
      clima: selectedWeather,
      ocasiao: selectedOccasions,
      disponivel: available,
      imagemUrl: '',
    );

    try {
      await context
          .read<ClothingProvider>()
          .addClothing(
        clothing: clothing,
        imageFile: selectedImage!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Roupa cadastrada',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Widget buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) labelBuilder,
    required Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade300,
          ),
        ),

        const SizedBox(height: 10),

        Container(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF262626),
            borderRadius:
            BorderRadius.circular(18),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor:
              const Color(0xFF1A1A1A),
              style: const TextStyle(
                color: Colors.white,
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    labelBuilder(item),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nomeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<ClothingProvider>();

    return Scaffold(
      backgroundColor:
      const Color(0xFF0F0F0F),

      appBar: AppBar(
        backgroundColor:
        const Color(0xFF1A1A1A),
        title: const Text(
          'Cadastrar roupa',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF1A1A1A),
                  borderRadius:
                  BorderRadius.circular(
                    24,
                  ),
                ),
                child: selectedImage != null
                    ? ClipRRect(
                  borderRadius:
                  BorderRadius
                      .circular(24),
                  child: Image.file(
                    selectedImage!,
                    fit: BoxFit.cover,
                  ),
                )
                    : Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,
                  children: [
                    const Icon(
                      Icons
                          .add_a_photo_outlined,
                      color: Colors.grey,
                      size: 52,
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      'Selecionar imagem',
                      style: TextStyle(
                        color: Colors
                            .grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            TextField(
              controller: nomeController,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: 'Nome da peça',
                hintStyle: TextStyle(
                  color: Colors.grey.shade600,
                ),
                filled: true,
                fillColor:
                const Color(0xFF262626),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 22),

            buildDropdown(
              label: 'Categoria',
              value: selectedCategory,
              items: ClothingCategory.values,
              labelBuilder: (item) =>
              item.label,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
            ),

            const SizedBox(height: 22),

            buildDropdown(
              label: 'Tipo',
              value: selectedType,
              items: ClothingType.values,
              labelBuilder: (item) =>
              item.label,
              onChanged: (value) {
                setState(() {
                  selectedType = value!;
                });
              },
            ),

            const SizedBox(height: 22),

            buildDropdown(
              label: 'Cor',
              value: selectedColor,
              items: Cores.values,
              labelBuilder: (item) =>
              item.label,
              onChanged: (value) {
                setState(() {
                  selectedColor = value!;
                });
              },
            ),

            const SizedBox(height: 22),

            buildDropdown(
              label: 'Estilo',
              value: selectedStyle,
              items: Style.values,
              labelBuilder: (item) =>
              item.label,
              onChanged: (value) {
                setState(() {
                  selectedStyle = value!;
                });
              },
            ),

            const SizedBox(height: 22),

            SwitchListTile(
              value: available,
              activeColor: Colors.green,
              title: const Text(
                'Disponível para desapego',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  available = value;
                });
              },
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed:
                provider.isLoading
                    ? null
                    : submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green,
                  foregroundColor:
                  Colors.black,
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                      18,
                    ),
                  ),
                ),
                child: provider.isLoading
                    ? const CircularProgressIndicator(
                  color: Colors.black,
                )
                    : const Text(
                  'Salvar roupa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}