  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';

  import '../enums/clothing_type.dart';
  import '../enums/color.dart';
  import '../models/clothing_model.dart';
  import '../providers/clothing_provider.dart';
  import '../routes/app_routes.dart';
  import '../widgets/app_empty_state.dart';
  import '../widgets/app_network_image.dart';
  import '../widgets/app_skeleton.dart';

  class WardrobeScreen extends StatefulWidget {
    const WardrobeScreen({super.key});

    @override
    State<WardrobeScreen> createState() =>
        _WardrobeScreenState();
  }

  class _WardrobeScreenState
      extends State<WardrobeScreen> {
    final searchController =
    TextEditingController();

    String selectedFilter = 'Todos';

    final filters = [
      'Todos',
      'Camiseta',
      'Calça',
      'Tênis',
      'Jaqueta',
      'Moletom',
    ];

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

    @override
    Widget build(BuildContext context) {
      final provider =
      context.watch<ClothingProvider>();

      final clothes =
      provider.myClothes.where((item) {
        final matchesSearch = item.nome
            .toLowerCase()
            .contains(
          searchController.text
              .toLowerCase(),
        );

        final matchesFilter =
            selectedFilter == 'Todos' ||
                item.tipo.label ==
                    selectedFilter;

        return matchesSearch &&
            matchesFilter;
      }).toList();

      return Scaffold(
        backgroundColor:
        const Color(0xFF0F0F0F),

        body: SafeArea(
          child: RefreshIndicator(
            color: Colors.green,
            onRefresh: () async {
              final user =
                  Supabase.instance.client.auth.currentUser;
              if (user == null) return;
              await context
                  .read<ClothingProvider>()
                  .loadMyClothes(user.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                const SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFF1A1A1A),
                    borderRadius:
                    BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: TextField(
                    controller:
                    searchController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration:
                    InputDecoration(
                      hintText:
                      'Pesquisar peça...',
                      hintStyle:
                      TextStyle(
                        color: Colors
                            .grey.shade600,
                      ),
                      prefixIcon:
                      const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border:
                      InputBorder.none,
                      contentPadding:
                      const EdgeInsets
                          .symmetric(
                        vertical: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection:
                    Axis.horizontal,
                    itemCount:
                    filters.length,
                    separatorBuilder:
                        (_, __) =>
                    const SizedBox(
                      width: 10,
                    ),
                    itemBuilder:
                        (context, index) {
                      final filter =
                      filters[index];

                      final isSelected =
                          selectedFilter ==
                              filter;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter =
                                filter;
                          });
                        },
                        child: AnimatedContainer(
                          duration:
                          const Duration(
                            milliseconds: 200,
                          ),
                          padding:
                          const EdgeInsets
                              .symmetric(
                            horizontal: 18,
                          ),
                          decoration:
                          BoxDecoration(
                            color: isSelected
                                ? Colors.green
                                : const Color(
                              0xFF1A1A1A,
                            ),
                            borderRadius:
                            BorderRadius
                                .circular(
                              14,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              filter,
                              style:
                              TextStyle(
                                color: isSelected
                                    ? Colors
                                    .black
                                    : Colors
                                    .white,
                                fontWeight:
                                FontWeight
                                    .w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 28),

                Expanded(
                  child: provider.isLoading
                      ? _gridSkeleton()
                      : provider.lastError != null
                          ? AppEmptyState(
                              icon: Icons.error_outline_rounded,
                              title: 'Não foi possível carregar suas roupas',
                              message: 'Puxe para atualizar e tente novamente.',
                              action: OutlinedButton(
                                onPressed: () async {
                                  final user = Supabase
                                      .instance
                                      .client
                                      .auth
                                      .currentUser;
                                  if (user == null) return;
                                  await context
                                      .read<ClothingProvider>()
                                      .loadMyClothes(user.id);
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white24),
                                ),
                                child: const Text('Tentar agora'),
                              ),
                            )
                          : clothes.isEmpty
                              ? AppEmptyState(
                                  icon: Icons.checkroom_outlined,
                                  title: 'Seu guarda-roupa está vazio',
                                  message:
                                      'Adicione suas primeiras peças para começar a gerar looks.',
                                  action: Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.addClothing,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.black,
                                        ),
                                        child: const Text('Adicionar peça'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {
                                          final user = Supabase
                                              .instance
                                              .client
                                              .auth
                                              .currentUser;
                                          context
                                              .read<ClothingProvider>()
                                              .loadDemoData(
                                                userId:
                                                    user?.id ?? 'demo-user',
                                              );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          side: const BorderSide(
                                            color: Colors.white24,
                                          ),
                                        ),
                                        child: const Text('Usar dados de exemplo'),
                                      ),
                                    ],
                                  ),
                                )
                              : GridView.builder(
                    itemCount:
                    clothes.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                      2,
                      crossAxisSpacing:
                      16,
                      mainAxisSpacing:
                      16,
                      childAspectRatio:
                      0.68,
                    ),
                    itemBuilder:
                        (context,
                        index) {
                      final clothing =
                      clothes[
                      index];

                      return _clothingCard(
                        clothing,
                      );
                    },
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
      );
    }

    Widget _clothingCard(
        Clothing clothing,
        ) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius:
          BorderRadius.circular(26),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius
                        .vertical(
                      top: Radius.circular(
                        26,
                      ),
                    ),
                    child: AppNetworkImage(
                      url: clothing.imagemUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration:
                      BoxDecoration(
                        color:
                        Colors.black54,
                        borderRadius:
                        BorderRadius
                            .circular(
                          20,
                        ),
                      ),
                      child: Text(
                        clothing.tipo
                            .label,
                        style:
                        const TextStyle(
                          color:
                          Colors.white,
                          fontSize: 12,
                          fontWeight:
                          FontWeight
                              .w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
              const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .start,
                children: [
                  Text(
                    clothing.nome,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration:
                        BoxDecoration(
                          color:
                          _getColor(
                            clothing.cor
                                .label,
                          ),
                          shape:
                          BoxShape.circle,
                        ),
                      ),

                      const SizedBox(
                        width: 8,
                      ),

                      Text(
                        clothing.cor.label,
                        style: TextStyle(
                          color: Colors
                              .grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                          const EdgeInsets
                              .symmetric(
                            vertical: 10,
                          ),
                          decoration:
                          BoxDecoration(
                            color: clothing
                                .disponivel
                                ? Colors.green
                                .withOpacity(
                                0.18)
                                : Colors
                                .white10,
                            borderRadius:
                            BorderRadius
                                .circular(
                              14,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              clothing
                                  .disponivel
                                  ? 'Disponível'
                                  : 'Privado',
                              style:
                              TextStyle(
                                color: clothing
                                    .disponivel
                                    ? Colors
                                    .green
                                    : Colors
                                    .grey,
                                fontWeight:
                                FontWeight
                                    .w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
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

  Widget _gridSkeleton() {
    return GridView.builder(
      itemCount: 6,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(26),
                  ),
                  child: const AppSkeleton(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSkeleton(width: double.infinity, height: 14),
                    SizedBox(height: 10),
                    AppSkeleton(width: 120, height: 12),
                    SizedBox(height: 14),
                    AppSkeleton(width: double.infinity, height: 34),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }