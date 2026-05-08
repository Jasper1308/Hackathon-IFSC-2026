// lib/screens/suggestions_screen.dart

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

class SuggestionsScreen
    extends StatefulWidget {
  const SuggestionsScreen({
    super.key,
  });

  @override
  State<SuggestionsScreen>
  createState() =>
      _SuggestionsScreenState();
}

class _SuggestionsScreenState
    extends State<
        SuggestionsScreen
    > {
  Weather selectedWeather =
      Weather.ensolarado;

  Occasion selectedOccasion =
      Occasion.casual;

  Clothing? selectedBasePiece;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user =
          Supabase.instance.client
              .auth.currentUser;

      if (user == null) return;

      await context
          .read<
          ClothingProvider
      >()
          .loadMyClothes(user.id);
    });
  }

  void generateLook() {
    final clothes =
        context
            .read<
            ClothingProvider
        >()
            .myClothes;

    context
        .read<LookProvider>()
        .generateLook(
      clothes: clothes,
      clima:
      selectedWeather,
      ocasiao:
      selectedOccasion,
      basePiece:
      selectedBasePiece,
    );
  }

  void selectBasePiece() async {
    final clothes =
        context
            .read<
            ClothingProvider
        >()
            .myClothes;

    final selected =
    await showModalBottomSheet<
        Clothing
    >(
      context: context,
      backgroundColor:
      const Color(
        0xFF1A1A1A,
      ),
      isScrollControlled:
      true,
      builder: (_) {
        return Padding(
          padding:
          const EdgeInsets.all(
            20,
          ),
          child:
          GridView.builder(
            shrinkWrap: true,
            itemCount:
            clothes.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
              2,
              crossAxisSpacing:
              14,
              mainAxisSpacing:
              14,
              childAspectRatio:
              0.72,
            ),
            itemBuilder:
                (
                _,
                index,
                ) {
              final clothing =
              clothes[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                    clothing,
                  );
                },
                child:
                Container(
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFF262626,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                  child:
                  Column(
                    children: [
                      Expanded(
                        child:
                        ClipRRect(
                          borderRadius:
                          const BorderRadius.vertical(
                            top:
                            Radius.circular(
                              20,
                            ),
                          ),
                          child:
                          Image.network(
                            clothing.imagemUrl,
                            width:
                            double.infinity,
                            fit:
                            BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.all(
                          12,
                        ),
                        child:
                        Text(
                          clothing.nome,
                          maxLines:
                          1,
                          overflow:
                          TextOverflow.ellipsis,
                          style:
                          const TextStyle(
                            color:
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        selectedBasePiece =
            selected;
      });
    }
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    final lookProvider =
    context.watch<
        LookProvider
    >();

    final currentLook =
        lookProvider.currentLook;

    return Scaffold(
      backgroundColor:
      const Color(
        0xFF0F0F0F,
      ),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(
            20,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              const SizedBox(
                height: 8,
              ),

              const Text(
                'Montar Look',
                style: TextStyle(
                  color:
                  Colors.white,
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Row(
                children: [
                  Expanded(
                    child:
                    _dropdownContainer(
                      child:
                      DropdownButtonHideUnderline(
                        child:
                        DropdownButton<
                            Weather
                        >(
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
                          items:
                          Weather.values.map(
                                (
                                weather,
                                ) {
                              return DropdownMenuItem(
                                value:
                                weather,
                                child:
                                Text(
                                  weather.label,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged:
                              (
                              value,
                              ) {
                            setState(
                                  () {
                                selectedWeather =
                                value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 14,
                  ),

                  Expanded(
                    child:
                    _dropdownContainer(
                      child:
                      DropdownButtonHideUnderline(
                        child:
                        DropdownButton<
                            Occasion
                        >(
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
                          items:
                          Occasion.values.map(
                                (
                                occasion,
                                ) {
                              return DropdownMenuItem(
                                value:
                                occasion,
                                child:
                                Text(
                                  occasion.label,
                                ),
                              );
                            },
                          ).toList(),
                          onChanged:
                              (
                              value,
                              ) {
                            setState(
                                  () {
                                selectedOccasion =
                                value!;
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap:
                selectBasePiece,
                child: Container(
                  width:
                  double.infinity,
                  padding:
                  const EdgeInsets.all(
                    18,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    const Color(
                      0xFF1A1A1A,
                    ),
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (selectedBasePiece !=
                          null)
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                            12,
                          ),
                          child:
                          Image.network(
                            selectedBasePiece!
                                .imagemUrl,
                            width:
                            58,
                            height:
                            58,
                            fit:
                            BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width:
                          58,
                          height:
                          58,
                          decoration:
                          BoxDecoration(
                            color:
                            Colors.white10,
                            borderRadius:
                            BorderRadius.circular(
                              12,
                            ),
                          ),
                          child:
                          const Icon(
                            Icons
                                .checkroom,
                            color:
                            Colors.white,
                          ),
                        ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child:
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Peça base',
                              style: TextStyle(
                                color:
                                Colors.white,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                              height: 4,
                            ),

                            Text(
                              selectedBasePiece
                                  ?.nome ??
                                  'Selecionar peça',
                              style: TextStyle(
                                color:
                                Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons
                            .arrow_forward_ios,
                        color:
                        Colors.grey,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              SizedBox(
                width:
                double.infinity,
                height: 56,
                child:
                ElevatedButton(
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
                      BorderRadius.circular(
                        18,
                      ),
                    ),
                  ),
                  child:
                  const Text(
                    'Gerar Look',
                    style: TextStyle(
                      fontSize:
                      16,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Expanded(
                child:
                currentLook ==
                    null
                    ? Center(
                  child:
                  Text(
                    'Nenhum look gerado',
                    style: TextStyle(
                      color:
                      Colors.grey.shade500,
                    ),
                  ),
                )
                    : ListView(
                  children: [
                    _lookPiece(
                      currentLook['superior']!,
                    ),

                    const SizedBox(
                      height:
                      18,
                    ),

                    _lookPiece(
                      currentLook['inferior']!,
                    ),

                    const SizedBox(
                      height:
                      18,
                    ),

                    _lookPiece(
                      currentLook['calcado']!,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lookPiece(
      Clothing clothing,
      ) {
    return Container(
      decoration: BoxDecoration(
        color:
        const Color(
          0xFF1A1A1A,
        ),
        borderRadius:
        BorderRadius.circular(
          24,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          ClipRRect(
            borderRadius:
            const BorderRadius.vertical(
              top:
              Radius.circular(
                24,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1.1,
              child:
              Image.network(
                clothing.imagemUrl,
                width:
                double.infinity,
                fit:
                BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.all(
              18,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  clothing.nome,
                  style:
                  const TextStyle(
                    color:
                    Colors.white,
                    fontSize:
                    20,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _tag(
                      clothing
                          .tipo
                          .label,
                    ),

                    _tag(
                      clothing
                          .estilo
                          .label,
                    ),

                    _tag(
                      clothing
                          .cor
                          .label,
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

  Widget _tag(
      String text,
      ) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration:
      BoxDecoration(
        color:
        Colors.white10,
        borderRadius:
        BorderRadius.circular(
          16,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color:
          Colors.grey.shade300,
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
      decoration:
      BoxDecoration(
        color:
        const Color(
          0xFF1A1A1A,
        ),
        borderRadius:
        BorderRadius.circular(
          18,
        ),
      ),
      child: child,
    );
  }
}