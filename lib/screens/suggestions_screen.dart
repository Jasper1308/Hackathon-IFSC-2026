import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../enums/clothing_type.dart';
import '../enums/color.dart';
import '../enums/occasion.dart';
import '../enums/style.dart';
import '../enums/weather.dart';
import '../models/clothing_model.dart';
import '../providers/clothing_provider.dart';
import '../providers/look_provider.dart';

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() =>
      _SuggestionsScreenState();
}

class _SuggestionsScreenState
    extends State<SuggestionsScreen> {
  Weather selectedWeather =
      Weather.ensolarado;

  Occasion selectedOccasion =
      Occasion.casual;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user =
          Supabase.instance.client.auth.currentUser;

      if (user == null) return;

      await context
          .read<ClothingProvider>()
          .loadMyClothes(user.id);
    });
  }

  void generateLook() {
    final clothes =
        context
            .read<ClothingProvider>()
            .myClothes;

    context.read<LookProvider>().generateLook(
      clothes: clothes,
      clima: selectedWeather,
      ocasiao: selectedOccasion,
    );
  }

  @override
  Widget build(BuildContext context) {
    final lookProvider =
    context.watch<LookProvider>();

    final currentLook =
        lookProvider.currentLook;

    return Scaffold(
      backgroundColor:
      const Color(0xFF0F0F0F),

      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              const Text(
                'Montar Look',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Recomendação inteligente baseada em estilo, clima e ocasião',
                style: TextStyle(
                  color:
                  Colors.grey.shade400,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child:
                    _dropdownContainer(
                      child:
                      DropdownButtonHideUnderline(
                        child:
                        DropdownButton<
                            Weather>(
                          value:
                          selectedWeather,
                          dropdownColor:
                          const Color(
                            0xFF1A1A1A,
                          ),
                          style:
                          const TextStyle(
                            color:
                            Colors.white,
                          ),
                          items: Weather
                              .values
                              .map(
                                (weather) {
                              return DropdownMenuItem(
                                value:
                                weather,
                                child:
                                Text(
                                  weather
                                      .label,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged:
                              (value) {
                            setState(() {
                              selectedWeather =
                              value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child:
                    _dropdownContainer(
                      child:
                      DropdownButtonHideUnderline(
                        child:
                        DropdownButton<
                            Occasion>(
                          value:
                          selectedOccasion,
                          dropdownColor:
                          const Color(
                            0xFF1A1A1A,
                          ),
                          style:
                          const TextStyle(
                            color:
                            Colors.white,
                          ),
                          items: Occasion
                              .values
                              .map(
                                (occasion) {
                              return DropdownMenuItem(
                                value:
                                occasion,
                                child:
                                Text(
                                  occasion
                                      .label,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged:
                              (value) {
                            setState(() {
                              selectedOccasion =
                              value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                  generateLook,
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    Colors.green,
                    foregroundColor:
                    Colors.black,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        18,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Gerar Look',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: currentLook == null
                    ? Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                    children: [
                      Icon(
                        Icons
                            .style_outlined,
                        size: 90,
                        color: Colors
                            .grey
                            .shade700,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Text(
                        'Nenhum look gerado',
                        style:
                        TextStyle(
                          color: Colors
                              .grey
                              .shade400,
                          fontSize:
                          18,
                        ),
                      ),
                    ],
                  ),
                )
                    : SingleChildScrollView(
                  child: Column(
                    children: [
                      _lookPiece(
                        title:
                        'Parte superior',
                        clothing:
                        currentLook[
                        'superior']!,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      _lookPiece(
                        title:
                        'Parte inferior',
                        clothing:
                        currentLook[
                        'inferior']!,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      _lookPiece(
                        title:
                        'Calçado',
                        clothing:
                        currentLook[
                        'calcado']!,
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      SizedBox(
                        width:
                        double.infinity,
                        height: 56,
                        child:
                        OutlinedButton(
                          onPressed:
                          generateLook,
                          style:
                          OutlinedButton.styleFrom(
                            side:
                            const BorderSide(
                              color:
                              Colors.green,
                            ),
                            shape:
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(
                                18,
                              ),
                            ),
                          ),
                          child:
                          const Text(
                            'Gerar Novamente',
                            style:
                            TextStyle(
                              color:
                              Colors.green,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lookPiece({
    required String title,
    required Clothing clothing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius:
        BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(28),
            ),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: Image.network(
                clothing.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration:
                  BoxDecoration(
                    color: Colors.green
                        .withOpacity(
                      0.14,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(
                      16,
                    ),
                  ),
                  child: Text(
                    title,
                    style:
                    const TextStyle(
                      color:
                      Colors.green,
                      fontWeight:
                      FontWeight
                          .w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  clothing.nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _tag(
                      clothing.tipo.label,
                    ),

                    _tag(
                      clothing.estilo
                          .label, 
                    ),

                    _tag(
                      clothing.cor.label,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius:
        BorderRadius.circular(
          16,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _dropdownContainer({
    required Widget child,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius:
        BorderRadius.circular(18),
      ),
      child: child,
    );
  }
}