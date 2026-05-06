import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),

          const Text(
            'Feed da Comunidade',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Looks compartilhados por outros usuários',
            style: TextStyle(
              color: Colors.grey.shade400,
            ),
          ),

          const SizedBox(height: 24),

          _feedCard(
            username: '@marina',
            description:
            'Look casual para clima frio ☁️',
          ),

          const SizedBox(height: 18),

          _feedCard(
            username: '@lucas',
            description:
            'Combinação streetwear minimalista',
          ),

          const SizedBox(height: 18),

          _feedCard(
            username: '@ana',
            description:
            'Visual elegante para evento',
          ),
        ],
      ),
    );
  }

  Widget _feedCard({
    required String username,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: const Center(
              child: Icon(
                Icons.image_outlined,
                color: Colors.grey,
                size: 60,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade300,
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}