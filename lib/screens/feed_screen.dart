import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/clothing_model.dart';
import '../../providers/clothing_provider.dart';
import '../enums/clothing_category.dart';
import '../enums/clothing_type.dart';
import '../enums/color.dart';
import '../enums/style.dart';
import '../enums/weather.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() =>
      _FeedScreenState();
}

class _FeedScreenState
    extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user =
          Supabase.instance.client.auth.currentUser;

      if (user == null) return;

      await context
          .read<ClothingProvider>()
          .loadCommunityClothes(
        user.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<ClothingProvider>();

    final clothes =
        provider.communityClothes;

    return Scaffold(
      backgroundColor:
      const Color(0xFF0F0F0F),

      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.green,
          onRefresh: () async {
            final user = Supabase
                .instance
                .client
                .auth
                .currentUser;

            if (user == null) return;

            await context
                .read<ClothingProvider>()
                .loadCommunityClothes(
              user.id,
            );
          },
          child: ListView(
            padding:
            const EdgeInsets.all(20),
            children: [
              const SizedBox(height: 8),

              const Text(
                'Feed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Descubra peças da comunidade',
                style: TextStyle(
                  color:
                  Colors.grey.shade400,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              if (provider.isLoading)
                const Padding(
                  padding:
                  EdgeInsets.only(
                    top: 120,
                  ),
                  child: Center(
                    child:
                    CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                ),

              if (!provider.isLoading &&
                  clothes.isEmpty)
                Padding(
                  padding:
                  const EdgeInsets.only(
                    top: 120,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons
                            .checkroom_outlined,
                        color: Colors
                            .grey.shade700,
                        size: 90,
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      Text(
                        'Nenhuma peça compartilhada',
                        style: TextStyle(
                          color: Colors
                              .grey.shade400,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

              ...clothes.map(
                    (clothing) {
                  return Padding(
                    padding:
                    const EdgeInsets.only(
                      bottom: 22,
                    ),
                    child: _feedCard(
                      clothing,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feedCard(
      Clothing clothing,
      ) {
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
          Padding(
            padding:
            const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration:
                  const BoxDecoration(
                    color: Colors.green,
                    shape:
                    BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
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
                          fontWeight:
                          FontWeight
                              .bold,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                        height: 4,
                      ),

                      Text(
                        clothing.estilo
                            .label,
                        style: TextStyle(
                          color: Colors
                              .grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:
                  const EdgeInsets
                      .symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration:
                  BoxDecoration(
                    color:
                    Colors.green
                        .withOpacity(
                      0.14,
                    ),
                    borderRadius:
                    BorderRadius
                        .circular(
                      18,
                    ),
                  ),
                  child: Text(
                    clothing.tipo.label,
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
              ],
            ),
          ),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(
              22,
            ),
            child: AspectRatio(
              aspectRatio: 1,
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
                Row(
                  children: [
                    _actionButton(
                      icon:
                      Icons.favorite,
                      label: 'Curtir',
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    _actionButton(
                      icon:
                      Icons.chat_bubble_outline,
                      label: 'Chat',
                    ),

                    const Spacer(),

                    Container(
                      width: 18,
                      height: 18,
                      decoration:
                      BoxDecoration(
                        color: _getColor(
                          clothing
                              .cor.label,
                        ),
                        shape:
                        BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _tag(
                      clothing
                          .categoria.label,
                    ),

                    _tag(
                      clothing
                          .estilo.label,
                    ),

                    ...clothing.clima.map(
                          (weather) =>
                          _tag(
                            weather.label,
                          ),
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

  Widget _actionButton({
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius:
        BorderRadius.circular(
          18,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
              FontWeight.w500,
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
          fontSize: 13,
        ),
      ),
    );
  }

  Color _getColor(String color) {
    switch (color.toLowerCase()) {
      case 'preto':
        return Colors.black;

      case 'branco':
        return Colors.white;

      case 'azul':
        return Colors.blue;

      case 'verde':
        return Colors.green;

      case 'vermelho':
        return Colors.red;

      case 'cinza':
        return Colors.grey;

      default:
        return Colors.grey;
    }
  }
}